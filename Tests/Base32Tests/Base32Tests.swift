//
//  Base32Tests.swift
//  Base32
//

import XCTest
import Base32

final class Base32Tests: XCTestCase {
	func testOneLetter() {
		let input = "A"
		let output = "84"
		
		var encoder = Base32Encoder()
		encoder.encode(input.utf8)
		let encoded = encoder.finalize()
		XCTAssertEqual(encoded, output)
		
		var decoder = Base32Decoder()
		decoder.decode(output)
		let decoded = decoder.finalize()
			.map { Character(UnicodeScalar($0)) }
		XCTAssertEqual(String(decoded), input)
	}
	
	func testTwoLetters() {
		let input = "AB"
		let output = "8510"
		
		var encoder = Base32Encoder()
		encoder.encode(input.utf8)
		let encoded = encoder.finalize()
		XCTAssertEqual(encoded, output)
		
		var decoder = Base32Decoder()
		decoder.decode(output)
		let decoded = decoder.finalize()
			.map { Character(UnicodeScalar($0)) }
		XCTAssertEqual(String(decoded), input)
	}
	
	func testThreeLetters() {
		let input = "ABC"
		let output = "85146"
		
		var encoder = Base32Encoder()
		encoder.encode(input.utf8)
		let encoded = encoder.finalize()
		XCTAssertEqual(encoded, output)
		
		var decoder = Base32Decoder()
		decoder.decode(output)
		let decoded = decoder.finalize()
			.map { Character(UnicodeScalar($0)) }
		XCTAssertEqual(String(decoded), input)
	}
	
	func testFourLetters() {
		let input = "ABCD"
		let output = "85146H0"
		
		var encoder = Base32Encoder()
		encoder.encode(input.utf8)
		let encoded = encoder.finalize()
		XCTAssertEqual(encoded, output)
		
		var decoder = Base32Decoder()
		decoder.decode(output)
		let decoded = decoder.finalize()
			.map { Character(UnicodeScalar($0)) }
		XCTAssertEqual(String(decoded), input)
	}
	
	func testFiveLetters() {
		let input = "ABCDE"
		let output = "85146H25"
		
		var encoder = Base32Encoder()
		encoder.encode(input.utf8)
		let encoded = encoder.finalize()
		XCTAssertEqual(encoded, output)
		
		var decoder = Base32Decoder()
		decoder.decode(output)
		let decoded = decoder.finalize()
			.map { Character(UnicodeScalar($0)) }
		XCTAssertEqual(String(decoded), input)
	}
	
	func testHelloWorld() {
		let input = "Hello World"
		let output = "91JPRV3F41BPYWKCCG"
		
		var encoder = Base32Encoder()
		encoder.encode(input.utf8)
		let encoded = encoder.finalize()
		XCTAssertEqual(encoded, output)
		
		var decoder = Base32Decoder()
		decoder.decode(output)
		let decoded = decoder.finalize()
			.map { Character(UnicodeScalar($0)) }
		XCTAssertEqual(String(decoded), input)
	}
	
	func testString1() {
		let input = "Wow, it really works!"
		let output = "AXQQEB10D5T20WK5C5P6RY90EXQQ4TVK44"
		
		var encoder = Base32Encoder()
		encoder.encode(input.utf8)
		let encoded = encoder.finalize()
		XCTAssertEqual(encoded, output)
		
		var decoder = Base32Decoder()
		decoder.decode(output)
		let decoded = decoder.finalize()
			.map { Character(UnicodeScalar($0)) }
		XCTAssertEqual(String(decoded), input)
	}
	
	func testString2() {
		let input = "lowercase UPPERCASE 1234567 !@#$%^&*"
		let output = "DHQQESBJCDGQ6S90AN850HAJ8D0N6H9064S36D1N6RVJ08A04CJ2AQH658"
		
		var encoder = Base32Encoder()
		encoder.encode(input.utf8)
		let encoded = encoder.finalize()
		XCTAssertEqual(encoded, output)
		
		var decoder = Base32Decoder()
		decoder.decode(output)
		let decoded = decoder.finalize()
			.map { Character(UnicodeScalar($0)) }
		XCTAssertEqual(String(decoded), input)
	}
	
	func testDecodeAlternatives() {
		let input = "lowercase UPPERCASE 1234567 !@#$%^&*"
		let output = "dhqQesbjcdgq6s9Oan850haj8d0n6h9o64s36d1n6rvj08a04cj2aqh658"
		
		var decoder = Base32Decoder()
		decoder.decode(output)
		let decoded = decoder.finalize()
			.map { Character(UnicodeScalar($0)) }
		XCTAssertEqual(String(decoded), input)
	}
	
	func testPartialEncoding() {
		let input = [
			"lowercase ",
			"UPP",
			"ERCASE 1234",
			"567 !@#$%^&*",
		]
		let output = "DHQQESBJCDGQ6S90AN850HAJ8D0N6H9064S36D1N6RVJ08A04CJ2AQH658"
		
		var encoder = Base32Encoder()
		input.forEach { encoder.encode($0.utf8) }
		let encoded = encoder.finalize()
		XCTAssertEqual(encoded, output)
	}
	
	func testPartialEncoding2() {
		let input = [
			"lowercase ",
			"UPP",
			"ERCASE 1234",
			"567 !@#$%^&*",
		]
		let output = "DHQQESBJCDGQ6S90AN850HAJ8D0N6H9064S36D1N6RVJ08A04CJ2AQH658"
		
		var encoder = Base32Encoder()
		let partials = input.flatMap { encoder.encodePartial($0.utf8) } + encoder.finalize()
		let encoded = partials.reduce(into: "") { $0.append($1) }
		XCTAssertEqual(encoded, output)
	}
	
	func testPartialDecoding() {
		let input = "lowercase UPPERCASE 1234567 !@#$%^&*"
		let output = [
			"DHQQESB",
			"JCDGQ6S",
			"90AN850",
			"HAJ8D0N",
			"6H9064S",
			"36D1N6R",
			"VJ08A04",
			"CJ2AQH658",
		]
		
		var decoder = Base32Decoder()
		output.forEach { decoder.decode($0) }
		let decoded = decoder.finalize()
			.map { Character(UnicodeScalar($0)) }
		XCTAssertEqual(String(decoded), input)
	}
	
	func testPartialDecoding2() {
		let input = "lowercase UPPERCASE 1234567 !@#$%^&*"
		let output = [
			"DHQQESB",
			"JCDGQ6S",
			"90AN850",
			"HAJ8D0N",
			"6H9064S",
			"36D1N6R",
			"VJ08A04",
			"CJ2AQH658",
		]
		
		var decoder = Base32Decoder()
		let partials = output.flatMap { decoder.decodePartial($0) } + decoder.finalize()
		let decoded = partials
			.map { Character(UnicodeScalar($0)) }
		XCTAssertEqual(String(decoded), input)
	}
}
