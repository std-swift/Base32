//
//  Base32Encoder.swift
//  Base32
//

import Encoding

// A queue encoder. Data is stored in input and output queues.
public struct Base32Encoder {
	private static let EncodeLookup = Array("0123456789ABCDEFGHJKMNPQRSTVWXYZ")
	
	private var inputQueue = [UInt8]()
	private var outputQueue = String()
	
	public init() {}
	
	/// Add `data` to the decoding queue and decode as much as possible to the
	/// output queue
	public mutating func encodePartial<T: Sequence>(_ data: T) where T.Element == UInt8 {
		self.inputQueue.append(contentsOf: data)
		self.encodeStep(final: false)
	}
	
	/// Add `data` to the decoding queue and return everything that can be
	/// decoded
	public mutating func encode<T: Sequence>(_ data: T) -> String where T.Element == UInt8 {
		self.inputQueue.append(contentsOf: data)
		self.encodeStep(final: false)
		defer { self.outputQueue.removeAll(keepingCapacity: true) }
		return self.outputQueue
	}
	
	/// Stop buffering input data and encode the remaining buffer
	public mutating func finalize() -> String {
		self.encodeStep(final: true)
		defer { self.outputQueue.removeAll(keepingCapacity: true) }
		return self.outputQueue
	}
	
	private mutating func encodeStep(final: Bool) {
		let remaining = self.inputQueue.count % 5
		let encoded = self.inputQueue
			.dropLast(remaining)
			.asBigEndian(resultBits: 5)
			.map { Base32Encoder.EncodeLookup[$0] }
		self.outputQueue.append(contentsOf: encoded)
		
		if final {
			let encoded = self.inputQueue
				.suffix(remaining)
				.asBigEndian(resultBits: 5)
				.map { Base32Encoder.EncodeLookup[$0] }
			self.outputQueue.append(contentsOf: encoded)
			self.inputQueue.removeAll(keepingCapacity: true)
		} else {
			self.inputQueue = self.inputQueue.suffix(remaining)
		}
	}
}
