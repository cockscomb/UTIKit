#if os(iOS)
import MobileCoreServices
#endif

import UTIKit

UTI(MIMEType: "image/jpeg").filenameExtensions

UTI(filenameExtension: "jpeg") == UTI(MIMEType: "image/jpeg")

switch UTI(kUTTypeJPEG as String) {
case UTI(kUTTypeImage as String):
    print("JPEG is a kind of images")
default:
    fatalError("JPEG must be a image")
}
