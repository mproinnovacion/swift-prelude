import XCTest
import Prelude

class StringUtilsTests: XCTestCase {
	func testContains() {
		XCTAssertEqual("hello!".contains("llo"), true)
		XCTAssertEqual("hello!".contains("bye"), false)
	}
	
	func testContainsIgnoringCase() {
		XCTAssertEqual("hello!".containsIgnoringCase("LlO"), true)
		XCTAssertEqual("hello!".containsIgnoringCase("HELlO"), true)
		XCTAssertEqual("hello!".containsIgnoringCase("bye"), false)
	}
	
	func testEqualsIgnoringCase() {
		XCTAssertEqual("hello!".equalsIgnoringCase("HELlO!"), true)
		XCTAssertEqual("hello!".equalsIgnoringCase("HELlO"), false)
	}
	
	func testContainsDiacriticInsensitive() {
		XCTAssertEqual("camión".containsDiacriticInsensitive("ion"), true)
		XCTAssertEqual("áéíóú".containsDiacriticInsensitive("aeiou"), true)
		XCTAssertEqual("hello!".containsDiacriticInsensitive("bye"), false)
	}
	
	func testIsBlank() {
		let nilStr: String? = nil
		
		XCTAssert(String.isBlank(nilStr))
		XCTAssert(String.isBlank(""))
		XCTAssert(String.isBlank(" "))
		XCTAssert(String.isBlank("\t"))
		XCTAssert(String.isBlank("\n"))
		XCTAssert(String.isBlank("h") == false)
		XCTAssert(String.isBlank("hello") == false)
	}
	
	func testTrimmingHead() {
		XCTAssertEqual("h".trimmingHead(2, ellipsis: "_"), "h")
		XCTAssertEqual("hello".trimmingHead(2, ellipsis: "_"), "he_")
	}
	
	func testTrimmingTail() {
		XCTAssertEqual("h".trimmingTail(2, ellipsis: "_"), "h")
		XCTAssertEqual("hello".trimmingTail(2, ellipsis: "_"), "_lo")
	}
	
	func testCase() {
		XCTAssertEqual(String.upperCase("hello"), "HELLO")
		XCTAssertEqual(String.camelCase("hello how are you"), "Hello How Are You")
	}
	
	func testSpaces() {
		XCTAssertEqual(String.underlineSpaces("hello how are you"), "hello_how_are_you")
		XCTAssertEqual(String.removeSpaces("hello how are you"), "hellohowareyou")
		XCTAssertEqual(String.removeTildeN("montaña"), "montana")
		XCTAssertEqual(String.removeDiacritics("móntáñá"), "montana")
		XCTAssertEqual(String.trimWhitespace("\thello \n"), "hello")
	}
	
	func testAlpha() {
		XCTAssertEqual(String.onlyAlphanumeric("hello123!_? $"), "hello123")
	}
	
	func testHTML() {
		XCTAssertEqual(String.htmlToPlain("<a href=\"https://www.duckduckgo.com\"><b>hello</b></a>"), "hello")
	}
	
	func testHTMLEmpty() {
		XCTAssertEqual(String.htmlToPlain("<html></html>"), "")
	}
}
