import XCTest
import Prelude

class ComparableUtilsTests: XCTestCase {
	func testClamped() {
		var value = 25
		
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
}
