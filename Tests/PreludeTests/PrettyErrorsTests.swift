import XCTest
@testable import Prelude

fileprivate struct User: Codable {
	var name: String
	var age: Int
}

class PrettyErrorsTests: XCTestCase {
	func testDataCorrupted() {
		let string = """
		[
			{
				"name": "John",
				"age": "77"
			},
			{
				"name": "James",
				"age: "77"
			}
		]
		"""
		
		let data = string.data(using: .utf8)!
		
		let expectedMessage = """
		🚫 DecodingError: dataCorrupted 🧟 The given data was not valid JSON.

		No value for key in object around line 8, column 9.
		▵ 🔚\n
		"""
		
		do {
			try prettyErrors {
				_ = try JSONDecoder().decode([User].self, from: data)
				
				XCTFail("Parsing should fail")
			}
		} catch {
			switch error {
				case let error as PrettyPrintedError:
					XCTAssertEqual(
						error.message,
						expectedMessage
					)
					
					switch error.original {
						case DecodingError.dataCorrupted:
							break
						default:
							XCTFail("Unexpected original error \(error.original)")
					}
					
				default:
					XCTFail("Invalid error")
			}
		}
	}
	
	func testTypeMismatch() {
		let string = """
		[
			{
				"name": "John",
				"age": "77"
			},
			{
				"name": "James",
				"age": 77
			}
		]
		"""
		
		let data = string.data(using: .utf8)!
		
		let expectedMessage = """
		🚫 DecodingError: typeMismatch ♦️
		Expected to decode Int but found a string/data instead.
		Path: [0].age
		▵ 🔚\n
		"""
		
		do {
			try prettyErrors {
				_ = try JSONDecoder().decode([User].self, from: data)
				
				XCTFail("Parsing should fail")
			}
		} catch {
			switch error {
				case let error as PrettyPrintedError:
					XCTAssertEqual(
						error.message,
						expectedMessage
					)
					
					switch error.original {
						case DecodingError.typeMismatch:
							break
						default:
							XCTFail("Unexpected original error \(error.original)")
					}
					
				default:
					XCTFail("Invalid error")
			}
		}
	}
	
	func testKeyNotFound() {
		let string = """
		[
			{
				"name": "John",
				"age": 77
			},
			{
				"name": "James"
			}
		]
		"""
		
		let data = string.data(using: .utf8)!
		
		let expectedMessage = """
		🚫 DecodingError: keyNotFound "age" 🔑
		Path: [1]
		
		No value associated with key CodingKeys(stringValue: "age", intValue: nil) ("age").
		▵ 🔚\n
		"""
		
		do {
			try prettyErrors {
				_ = try JSONDecoder().decode([User].self, from: data)
				
				XCTFail("Parsing should fail")
			}
		} catch {
			switch error {
				case let error as PrettyPrintedError:
					XCTAssertEqual(
						error.message,
						expectedMessage
					)
					
					switch error.original {
						case DecodingError.keyNotFound:
							break
						default:
							XCTFail("Unexpected original error \(error.original)")
					}
					
				default:
					XCTFail("Invalid error")
			}
		}
	}
}
