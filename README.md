# Base32

[![](https://img.shields.io/badge/Swift-5.0-orange.svg)][1]
[![](https://img.shields.io/badge/os-macOS%20|%20Linux-lightgray.svg)][1]
[![](https://travis-ci.com/std-swift/Base32.svg?branch=master)][2]
[![](https://codecov.io/gh/std-swift/Base32/branch/master/graph/badge.svg)][3]
[![](https://codebeat.co/badges/17250caa-b6c1-4444-9432-59807b8e5cdb)][4]

[1]: https://swift.org/download/#releases
[2]: https://travis-ci.com/std-swift/Base32
[3]: https://codecov.io/gh/std-swift/Base32
[4]: https://codebeat.co/projects/github-com-std-swift-base32-master

[Crockford's][5] Base32 (without check symbols)

###### Encoding and decoding errors are silently ignored, and invalid bytes are stripped

[5]: https://www.crockford.com/base32.html

## Importing

```Swift
import Base32
```

```Swift
dependencies: [
	.package(url: "https://github.com/std-swift/Base32.git",
	         from: "1.0.0")
],
targets: [
	.target(
		name: "",
		dependencies: [
			"Base32"
		]),
]
```

## Using

### `Base32`

```Swift
Base32.decode(_ data: String) -> [UInt8]
Base32.encode(_ data: Sequence) -> String
```

### `Base32Decoder`

```Swift
mutating func decodePartial(_ data: String)
mutating func decode(_ data: String) -> [UInt8]
mutating func finalize() -> [UInt8]
```

### `Base32Encoder`

```Swift
mutating func encodePartial<T: Sequence>(_ data: T) where T.Element == UInt8
mutating func encode<T: Sequence>(_ data: T) -> String where T.Element == UInt8
mutating func finalize() -> String
```
