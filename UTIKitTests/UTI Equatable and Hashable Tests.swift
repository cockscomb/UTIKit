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

class UTIEquatableTests: XCTestCase {
	
	let gif = UTI("com.compuserve.gif")
	let png = UTI("public.png")
	
	func testRawOperators() {
		XCTAssertTrue(gif == gif)
		XCTAssertTrue(gif != png)
		
		XCTAssertFalse(gif == png)
		XCTAssertFalse(gif != gif)
	}
	
	func testReflexivity() {
		/// Test that every UTI is equal to itself.
		func testReflexivity(_ uti: UTI) {
			XCTAssertEqual(uti, uti)
		}
		
		testReflexivity(gif)
		testReflexivity(png)
	}
	
	func testSymmetry() {
		/// Test the equality is symmetric, i.e. that a == b equivalent to b == a
		func testSymmetry(_ a: UTI, _ b: UTI) {
			if a == b {
				XCTAssertEqual(b, a)
			} else {
				XCTAssertNotEqual(b, a)
			}
		}
		
		testSymmetry(gif, gif)
		testSymmetry(gif, png)
		testSymmetry(png, gif)
		testSymmetry(png, png)
	}
	
	func testTransitivity() {
		/// Test that 2/3 pairs being equal implies the 3rd pair must be equal.
		func testTransitivity(_ a: UTI, _ b: UTI, _ c: UTI) {
			let pairs = [
				(a, b),
				(b, c),
				(c, a),
			]
			
			let pairEquality = pairs.map(==)
			
			if pairEquality[0] && pairEquality[1] { XCTAssertEqual(pairs[2].0, pairs[2].1) }
			if pairEquality[1] && pairEquality[2] { XCTAssertEqual(pairs[0].0, pairs[0].1) }
			if pairEquality[2] && pairEquality[0] { XCTAssertEqual(pairs[1].0, pairs[1].1) }
		}
		
		testTransitivity(gif, gif, gif)
		testTransitivity(gif, gif, png)
		testTransitivity(gif, png, gif)
		testTransitivity(gif, png, png)
		testTransitivity(png, gif, gif)
		testTransitivity(png, gif, png)
		testTransitivity(png, png, gif)
		testTransitivity(png, png, png)
	}
}
