//
//  Base32Decoder.swift
//  Base32
//

import Encoding

public struct Base32Decoder: StreamDecoder {
	public typealias Element = Character
	public typealias Partial = [UInt8]
	public typealias Decoded = [UInt8]
	
	private static let EndingCount: ContiguousArray = [0, 0, 1, 0, 2, 3, 0, 4]
	private static let DecodeLookup: [Character : UInt8] = [
		"0": 0, "O": 0, "o": 0,
		"1": 1, "I": 1, "L": 1, "l": 1,
		"2": 2,
		"3": 3,
		"4": 4,
		"5": 5,
		"6": 6,
		"7": 7,
		"8": 8,
		"9": 9,
		"A": 10, "a": 10,
		"B": 11, "b": 11,
		"C": 12, "c": 12,
		"D": 13, "d": 13,
		"E": 14, "e": 14,
		"F": 15, "f": 15,
		"G": 16, "g": 16,
		"H": 17, "h": 17,
		"J": 18, "j": 18,
		"K": 19, "k": 19,
		"M": 20, "m": 20,
		"N": 21, "n": 21,
		"P": 22, "p": 22,
		"Q": 23, "q": 23,
		"R": 24, "r": 24,
		"S": 25, "s": 25,
		"T": 26, "t": 26,
		"V": 27, "v": 27,
		"W": 28, "w": 28,
		"X": 29, "x": 29,
		"Y": 30, "y": 30,
		"Z": 31, "z": 31,
	]
	
	private var inputQueue = [UInt8]()
	private var outputQueue = [UInt8]()
	
	public init() {}
	
	/// Add `data` to the decoding queue and decode as much as possible to the
	/// output queue
	public mutating func decode<T: Sequence>(_ data: T) where T.Element == Element {
		self.inputQueue.append(contentsOf: data
			.compactMap { Base32Decoder.DecodeLookup[$0] })
		self.decodeStep(final: false)
	}
	
	/// Add `data` to the decoding queue and return everything that can be
	/// decoded
	public mutating func decodePartial<T: Sequence>(_ data: T) -> Partial where T.Element == Element {
		self.inputQueue.append(contentsOf: data
			.compactMap { Base32Decoder.DecodeLookup[$0] })
		self.decodeStep(final: false)
		defer { self.outputQueue.removeAll(keepingCapacity: true) }
		return self.outputQueue
	}
	
	/// Stop buffering input data and decode the remaining buffer
	public mutating func finalize() -> Decoded {
		self.decodeStep(final: true)
		defer { self.outputQueue.removeAll(keepingCapacity: true) }
		return self.outputQueue
	}
	
	private mutating func decodeStep(final: Bool) {
		let remaining = self.inputQueue.count % 8
		let decoded: [UInt8] = self.inputQueue
			.dropLast(remaining)
			.asBigEndian(sourceBits: 5)
		self.outputQueue.append(contentsOf: decoded)
		
		if final {
			Base32Decoder.EndingCount.withUnsafeBufferPointer { buffer in
				let decoded: ArraySlice<UInt8> = self.inputQueue
					.suffix(remaining)
					.asBigEndian(sourceBits: 5)
					.prefix(buffer[remaining])
				self.outputQueue.append(contentsOf: decoded)
			}
			self.inputQueue.removeAll(keepingCapacity: true)
		} else {
			self.inputQueue = self.inputQueue.suffix(remaining)
		}
	}
}
