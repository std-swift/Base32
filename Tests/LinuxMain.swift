import XCTest

import Base32Tests

var tests = [XCTestCaseEntry]()
tests += Base32Tests.__allTests()

XCTMain(tests)
