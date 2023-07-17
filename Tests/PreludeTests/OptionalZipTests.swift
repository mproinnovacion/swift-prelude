import XCTest
import Prelude

class OptionalZipTests: XCTestCase {
	let firstSome: Int? = 1
	let firstNone: Int? = nil
	let secondSome: Int? = 2
	let secondNone: Int? = nil
	let thirdSome: Int? = 3
	let thirdNone: Int? = nil
	let fourthSome: Int? = 4
	let fourthNone: Int? = nil
	
	func testZip() {
		var zipped = zip(firstSome, secondSome)
		
		XCTAssertEqual(zipped?.0, 1)
		XCTAssertEqual(zipped?.1, 2)
		
		zipped = zip(firstNone, secondSome)
		
		XCTAssertNil(zipped)

		zipped = zip(firstSome, secondNone)
		
		XCTAssertNil(zipped)
	}
	
	func testZipWith() {
		var zippedWith = zip(firstSome, secondSome) {
			$0 + $1
		}

		XCTAssertEqual(zippedWith, 3)
		
		zippedWith = zip(firstNone, secondSome) {
			$0 + $1
		}
		
		XCTAssertNil(zippedWith)

		zippedWith = zip(firstSome, secondNone) {
			$0 + $1
		}
		
		XCTAssertNil(zippedWith)
	}
	
	func testZip3() {
		var zipped = zip3(firstSome, secondSome, thirdSome)
		
		XCTAssertEqual(zipped?.0, 1)
		XCTAssertEqual(zipped?.1, 2)
		XCTAssertEqual(zipped?.2, 3)
		
		zipped = zip3(firstNone, secondSome, thirdSome)
		
		XCTAssertNil(zipped)

		zipped = zip3(firstSome, secondNone, thirdSome)
		
		XCTAssertNil(zipped)
		
		zipped = zip3(firstSome, secondSome, thirdNone)
		
		XCTAssertNil(zipped)
	}
	
	func testZipWith3() {
		var zippedWith = zip3(firstSome, secondSome, thirdSome) {
			$0 + $1 + $2
		}

		XCTAssertEqual(zippedWith, 6)
		
		zippedWith = zip3(firstNone, secondSome, thirdSome) {
			$0 + $1 + $2
		}
		
		XCTAssertNil(zippedWith)

		zippedWith = zip3(firstSome, secondNone, thirdSome) {
			$0 + $1 + $2
		}
		
		XCTAssertNil(zippedWith)
		
		zippedWith = zip3(firstSome, secondSome, thirdNone) {
			$0 + $1 + $2
		}
		
		XCTAssertNil(zippedWith)
	}
	
	func testZip4() {
		var zipped = zip4(firstSome, secondSome, thirdSome, fourthSome)
		
		XCTAssertEqual(zipped?.0, 1)
		XCTAssertEqual(zipped?.1, 2)
		XCTAssertEqual(zipped?.2, 3)
		XCTAssertEqual(zipped?.3, 4)
		
		zipped = zip4(firstNone, secondSome, thirdSome, fourthSome)
		
		XCTAssertNil(zipped)

		zipped = zip4(firstSome, secondNone, thirdSome, fourthSome)
		
		XCTAssertNil(zipped)
		
		zipped = zip4(firstSome, secondSome, thirdNone, fourthSome)
		
		XCTAssertNil(zipped)
		
		zipped = zip4(firstSome, secondSome, thirdSome, fourthNone)
		
		XCTAssertNil(zipped)
	}
	
	func testZipWith4() {
		var zippedWith = zip4(firstSome, secondSome, thirdSome, fourthSome) {
			$0 + $1 + $2 + $3
		}

		XCTAssertEqual(zippedWith, 10)
		
		zippedWith = zip4(firstNone, secondSome, thirdSome, fourthSome) {
			$0 + $1 + $2 + $3
		}
		
		XCTAssertNil(zippedWith)

		zippedWith = zip4(firstSome, secondNone, thirdSome, fourthSome) {
			$0 + $1 + $2 + $3
		}
		
		XCTAssertNil(zippedWith)
		
		zippedWith = zip4(firstSome, secondSome, thirdNone, fourthSome) {
			$0 + $1 + $2 + $3
		}
		
		XCTAssertNil(zippedWith)
		
		zippedWith = zip4(firstSome, secondSome, thirdSome, fourthNone) {
			$0 + $1 + $2 + $3
		}
		
		XCTAssertNil(zippedWith)
	}
}
