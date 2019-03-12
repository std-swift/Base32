//
//  Base32.swift
//  Base32
//

public struct Base32 {
	@inlinable
	public static func decode<T: Sequence>(_ data: T) -> Base32Decoder.Decoded where T.Element == Base32Decoder.Element{
		var decoder = Base32Decoder()
		decoder.decode(data)
		return decoder.finalize()
	}
	
	@inlinable
	public static func encode<T: Sequence>(_ data: T) -> Base32Encoder.Encoded where T.Element == Base32Encoder.Element {
		var decoder = Base32Encoder()
		decoder.encode(data)
		return decoder.finalize()
	}
}
