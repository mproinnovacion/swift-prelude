import XCTest
import Prelude

class ChangeDetectorTests: XCTestCase {
	func testChanges() {
		struct Environment {
			var dependency: () -> Void
		}
		
		var numCallsBeforeChange = 0
		
		let env = Environment {
			numCallsBeforeChange += 1
		}
		
		let expectWillChange = expectation(description: "will change")
		let expectDidChange = expectation(description: "did change")
		
		var detector = ChangeDetector(
			value: env
		) { root, property in
			XCTAssertEqual(root, "Environment")
			XCTAssertEqual(property, "() -> ()")
			expectWillChange.fulfill()
		} didChange: { root, property in
			XCTAssertEqual(root, "Environment")
			XCTAssertEqual(property, "() -> ()")
			expectDidChange.fulfill()
		}

		var numCallsAfterChange = 0

		detector.dependency = {
			numCallsAfterChange += 1
		}
		
		detector.value.dependency()

		XCTAssertEqual(numCallsBeforeChange, 0)
		XCTAssertEqual(numCallsAfterChange, 1)
		
		waitForExpectations(timeout: 0.1)
	}
}
