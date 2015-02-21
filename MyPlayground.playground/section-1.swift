#if os(iOS)
import MobileCoreServices
#endif

import UTIKit

UTI(MIMEType: "image/jpeg").filenameExtensions

UTI(filenameExtension: "jpeg") == UTI(MIMEType: "image/jpeg")

switch UTI(kUTTypeJPEG) {
case UTI(kUTTypeImage):
    println("JPEG is a kind of images")
default:
    fatalError("JPEG must be a image")
}
