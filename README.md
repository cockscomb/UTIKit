# UTIKit

![CI status](https://github.com/cockscomb/UTIKit/workflows/CI/badge.svg)

UTIKit is an UTI (Uniform Type Identifier) wrapper for Swift.

## Features

UTIKit is a fully featured library containing the entire set of UTI functions.

- Convertibility
  - Filename extension
  - MIME type
  - OSType (OS X only)
  - Pasteboard type (OS X only)
- Equality
- UTI Conformance checking
- and others…

## Usage

### Making a UTI from a UTI string

```swift
let jpeg = UTI("public.jpeg")
```

### Making a UTI from a filename extension

```swift
let jpeg = UTI(filenameExtension: "jpeg")
```

### Making a UTI from a MIME type

```swift
let jpeg = UTI(mimeType: "image/jpeg")
```

### Listing filename extensions and MIME types for a UTI

```swift
UTI(mimeType: "image/jpeg").filenameExtensions // => ["jpeg", "jpg", "jpe"]

UTI(filenameExtension: "jpeg").mimeTypes // => ["image/jpeg"]
```

### Equality

```swift
UTI(mimeType: "image/jpeg") == UTI(filenameExtension: "jpeg") // => true
```

### UTI Conformance checking

```swift
switch UTI(kUTTypeJPEG) {
case UTI(kUTTypeImage):
    print("JPEG is a kind of image")
default:
    fatalError("JPEG must be a kind of image")
}
```

## Requirements

- Swift 4.0 or later
- iOS 8 or later
- OS X 10.10 or later

## Author

Hiroki Kato, mail@cockscomb.info

## License

UTIKit is available under the MIT license. See the LICENSE file for more info.
