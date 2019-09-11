import Foundation
#if os(iOS)
import MobileCoreServices
#endif

import UTIKit

UTI(mimeType: "image/jpeg")?.filenameExtensions

UTI(filenameExtension: "jpeg") == UTI(mimeType: "image/jpeg")

switch UTI(kUTTypeJPEG as String) {
case UTI(kUTTypeImage as String):
    print("JPEG is a kind of image")
default:
    fatalError("JPEG must be a kind of image")
}
