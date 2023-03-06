import XCTest
import Prelude

class ComparableUtilsTests: XCTestCase {
	func testClamped() {
		let value = 25
		
		XCTAssertEqual(
			value.clamped(to: 1...10),
			10
		)
		
		XCTAssertEqual(
			value.clamped(to: 1...100),
			25
		)
		
		XCTAssertEqual(
			value.clamped(to: 50...100),
			50
		)
	}
	
	func testClampedPartiallyClosed() {
		let value = 25
		
		XCTAssertEqual(
			value.clamped(to: ...10),
			10
		)
		
		XCTAssertEqual(
			value.clamped(to: ...100),
			25
		)
		
		XCTAssertEqual(
			value.clamped(to: 50...),
			50
		)

		XCTAssertEqual(
			value.clamped(to: 10...),
			25
		)
	}
}
