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
	         from: "2.0.0")
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

- `Base32Decoder: StreamDecoder` with `Character` input elements and `[UInt8]` output
- `Base32Encoder: StreamEncoder` with `UInt8` input elements and `String` output

### `Base32`

```Swift
Base32.decode(_ data: Sequence) -> Base32Decoder.Decoded
Base32.encode(_ data: Sequence) -> Base32Encoder.Encoded
```
