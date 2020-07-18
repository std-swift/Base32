# Base32

[![](https://img.shields.io/badge/Swift-5.1--5.3-orange.svg)][1]
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

Add the following line to the dependencies in your `Package.swift` file:

```Swift
.package(url: "https://github.com/std-swift/Base32.git", from: "3.0.0")
```

Add `Base32` as a dependency for your target:

```swift
.product(name: "Base32", package: "Base32"),
```

and finally,

```Swift
import Base32
```
