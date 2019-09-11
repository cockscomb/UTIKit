//  The MIT License (MIT)
//
//  Copyright (c) 2019 Alexander Momchilov
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
@testable import UTIKit

class UTIHashableTests: XCTestCase {
	let testUTIs = [
		UTI("public.text"),
		UTI("public.plain-text"),
		UTI("public.image"),
		UTI("public.jpeg"),
	]
	
	private func computeHash<T: Hashable>(_ value: T) -> Int {
		var hasher = Hasher()
		hasher.combine(value)
		return hasher.finalize()
	}
	
	func testEqualHashImpliesEquality() {
		for a in testUTIs {
			for b in testUTIs {
				if a == b {
					XCTAssertEqual(computeHash(a), computeHash(b))
				}
				// If unequal, hashes don't have to be equal
			}
		}
	}
	
	// Technically redundant, but it's a nice little sanity check
	func testHashableUsage() {
		let utiSet = Set(testUTIs)
		
		XCTAssertEqual(testUTIs.count, utiSet.count)
		XCTAssertTrue(testUTIs.allSatisfy { utiSet.contains($0) })
		
		XCTAssertFalse(utiSet.contains(UTI("not.real.uti")))
	}
}
