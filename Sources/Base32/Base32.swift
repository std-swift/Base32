//
//  Base32.swift
//  Base32
//

public struct Base32 {
	@inlinable
	public static func decode(_ data: String) -> [UInt8] {
		var decoder = Base32Decoder()
		decoder.decodePartial(data)
		return decoder.finalize()
	}
	
	@inlinable
	public static func encode<T: Sequence>(_ data: T) -> String where T.Element == UInt8 {
		var decoder = Base32Encoder()
		decoder.encodePartial(data)
		return decoder.finalize()
	}
}
