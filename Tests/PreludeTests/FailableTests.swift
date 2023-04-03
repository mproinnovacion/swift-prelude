import XCTest
@testable import Prelude

extension String: Error {}

class FailableTests: XCTestCase {
	func testMap() {
		let state = Failable<String>.valid("a")
		let mappedId = state.map { $0 }
		XCTAssertEqual(state, mappedId)
		
		let mappedComposition = state.map { $0.count * 2 }
		
		let composedMapping = state.map { $0.count }.map { $0 * 2 }
		
		XCTAssertEqual(mappedComposition, composedMapping)
		
		let invalid = Failable<String>.invalid("b")
		
		XCTAssertEqual(invalid.error as? String, "b")
		XCTAssertEqual(invalid.map { $0.count }, .invalid("b"))
	}
	
	func testMapFailable() {
		let state = Failable<String>.valid("a")
		let mappedId = mapFailable { $0 }(state)
		XCTAssertEqual(state, mappedId)
		
		let mappedComposition = mapFailable { $0.count * 2 }(state)
		
		let composedMapping = mapFailable { $0 * 2 }(mapFailable { $0.count }(state))
		
		XCTAssertEqual(mappedComposition, composedMapping)
		
		let invalid = Failable<String>.invalid("b")
		
		XCTAssertEqual(invalid.error as? String, "b")
		XCTAssertEqual(mapFailable { $0.count }(invalid), .invalid("b"))
	}
	
	func testRawValue() {
		var valid = Failable<String>.valid("a")
		var invalid = Failable<String>.invalid("b")

		valid.rawValue = "c"
		XCTAssertEqual(valid, .valid("c"))
		
		valid.rawValue = nil
		XCTAssertEqual(valid, .valid("c"))
		
		invalid.rawValue = nil
		XCTAssertEqual(invalid, .invalid("b"))
		
		invalid.rawValue = "c"
		XCTAssertEqual(invalid, .invalid("b"))
		
		XCTAssertEqual(Failable(rawValue: "a"), Failable<String>.valid("a"))
	}

	func testOptional() {
		XCTAssertEqual(Failable.from("a", error: "b"), Failable<String>.valid("a"))
		XCTAssertEqual(Failable.from(nil, error: "b"), Failable<String>.invalid("b"))
	}
	
	func testDescription() {
		let valid = Failable<String>.valid("a")
		let invalid = Failable<String>.invalid("b")

		XCTAssertEqual(valid.description, String(describing: valid))
		XCTAssertEqual(invalid.description, String(describing: invalid))
	}
	
	func testPlaygroundDescription() {
		let valid = Failable<String>.valid("a")
		let invalid = Failable<String>.invalid("b")

		XCTAssertEqual(valid.playgroundDescription as! String, "a")
		XCTAssertEqual(invalid.playgroundDescription as! String, "b")
	}
	
	func testValidItems() {
		let values: [Failable<Int>] = [
			.valid(1),
			.invalid("error"),
			.valid(7)
		]
		
		XCTAssertEqual(Failable.validItems(values), [ 1, 7 ])
	}
	
	func testErrors() {
		let values: [Failable<Int>] = [
			.valid(1),
			.invalid("error"),
			.valid(7)
		]
		
		let errors = Failable.errors(values)
		
		XCTAssertEqual(errors.count, 1)
		
		let recovered = errors[0] as! String
		
		XCTAssertEqual(recovered, "error")
	}
	
	func testFailableArray() {
		let values = [1, 2, 3].failable()
		
		XCTAssertEqual(
			values,
			[
				.valid(1),
				.valid(2),
				.valid(3)
			]
		)
	}
	
	func testEither() {
		let valid = Failable<String>.valid("a")
		let invalid = Failable<String>.invalid("b")

		XCTAssertNil(valid.either.left)
		XCTAssertEqual(valid.either.right, "a")
		XCTAssertEqual(invalid.either.left as! String, "b")
		XCTAssertEqual(invalid.either.right, nil)
	}
}
