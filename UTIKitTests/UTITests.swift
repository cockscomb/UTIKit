//  The MIT License (MIT)
//
//  Copyright (c) 2015 Hiroki Kato
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.


import XCTest
#if os(iOS)
import UIKit
import MobileCoreServices
#endif

import UTIKit

class UTITests: XCTestCase {

    func testInitialize() {
        let jpeg = UTI(kUTTypeJPEG as String)
        XCTAssertEqual(jpeg.UTIString, kUTTypeJPEG as String)
    }

    func testInitialize_filenameExtension() {
        let jpeg = UTI(filenameExtension: "jpg")
        XCTAssertEqual(jpeg.UTIString, kUTTypeJPEG as String)
    }

    func testInitialize_MIMEType() {
        let jpeg = UTI(MIMEType: "image/jpg")
        XCTAssertEqual(jpeg.UTIString, kUTTypeJPEG as String)
    }

    func testUTIsFromFilenameExtension() {
        let UTIs = UTI.UTIsFromFilenameExtension("key")
        XCTAssertEqual(UTIs, [ UTI("com.apple.iwork.keynote.key"), UTI("com.apple.iwork.keynote.sffkey") ])
    }

    func testUTIsFromMIMEType() {
        let UTIs = UTI.UTIsFromMIMEType("text/plain")
        XCTAssertEqual(UTIs, [ UTI("public.plain-text") ])
    }

    func testFilenameExtension() {
        let html = UTI(kUTTypeHTML as String)
        XCTAssertEqual(html.filenameExtension!, "html")
    }

    func testFilenameExtensions() {
        let html = UTI(kUTTypeHTML as String)
        XCTAssertEqual(html.filenameExtensions, [ "html" , "htm", "shtml", "shtm" ])
    }

    func testMIMEType() {
        let xls = UTI(filenameExtension: "xls")
        XCTAssertEqual(xls.MIMEType!, "application/vnd.ms-excel")
    }

    func testMIMETypes() {
        let xls = UTI(filenameExtension: "xls")
        XCTAssertEqual(xls.MIMETypes, [ "application/vnd.ms-excel", "application/msexcel" ])
    }

    func testIsDeclared() {
        XCTAssertTrue(UTI(filenameExtension: "numbers").isDeclared)
        XCTAssertFalse(UTI(filenameExtension: "meaningless-characters").isDeclared)
    }

    func testIsDynamic() {
        XCTAssertFalse(UTI(filenameExtension: "key").isDynamic)
        XCTAssertTrue(UTI(filenameExtension: "all-new-filetype").isDynamic)
    }

    func testDeclaration() {
        let pages = UTI(filenameExtension: "pages")
        XCTAssertTrue(pages.declaration.exportedTypeDeclarations.isEmpty)
        XCTAssertTrue(pages.declaration.importedTypeDeclarations.isEmpty)
        XCTAssertEqual(pages.declaration.identifier!, "com.apple.iWork.Pages.pages")
        XCTAssertNotNil(pages.declaration.tagSpecification)
        XCTAssertEqual(pages.declaration.conformsTo, [ UTI(kUTTypePackage as String), UTI(kUTTypeCompositeContent as String) ])
        XCTAssertNil(pages.declaration.iconFile)
        XCTAssertEqual(pages.declaration.referenceURL!, NSURL(string: "http://www.apple.com/iwork/pages/")!)
        XCTAssertNil(pages.declaration.version)
    }

    func testDeclaringBundle() {
        let pdf = UTI(kUTTypePDF as String)
        XCTAssertNotNil(pdf.declaringBundle)
    }

    func testEquatable() {
        XCTAssertEqual(UTI(filenameExtension: "gif"), UTI(MIMEType: "image/gif"))
    }

    func testMatch() {
        XCTAssertTrue(UTI(kUTTypeImage as String) ~= UTI(MIMEType: "image/jpeg"))

        switch UTI(kUTTypeJPEG as String) {
        case UTI(kUTTypeImage as String):
            XCTAssert(true)
        default:
            XCTFail("kUTTypeJPEG must be comforms to kUTTypeImage")
        }
    }

}
