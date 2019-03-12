//
//  Base32Encoder.swift
//  Base32
//

import Encoding

public struct Base32Encoder: StreamEncoder {
	public typealias Element = UInt8
	public typealias Partial = String
	public typealias Encoded = String
	
	private static let EncodeLookup = Array("0123456789ABCDEFGHJKMNPQRSTVWXYZ")
	
	private var inputQueue = [UInt8]()
	private var outputQueue = String()
	
	public init() {}
	
	public mutating func encode<T: Sequence>(_ elements: T) where T.Element == Element {
		self.inputQueue.append(contentsOf: elements)
		self.encodeStep(final: false)
	}
	
	public mutating func encodePartial<T: Sequence>(_ elements: T) -> String where T.Element == Element {
		self.inputQueue.append(contentsOf: elements)
		self.encodeStep(final: false)
		defer { self.outputQueue.removeAll(keepingCapacity: true) }
		return self.outputQueue
	}
	
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
