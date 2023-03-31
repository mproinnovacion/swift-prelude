import XCTest
import Prelude

class ArrayUtilsTests: XCTestCase {
	func testSafe() {
		let values: [Int] = [1, 2]
		
		XCTAssertEqual(values[safe: -1], nil)
		XCTAssertEqual(values[safe: 0], 1)
		XCTAssertEqual(values[safe: 1], 2)
		XCTAssertEqual(values[safe: 2], nil)
	}
	
	func testCompact() {
		let values: [Int?] = [1, nil, 2]
		XCTAssertEqual(values.compact(), [1, 2])
	}
	
	func testUpsert() {
		let values = [1, 2, 3]
		
		XCTAssertEqual(values.upsert(4, isEqual: { $0 == $1 }), [ 1, 2, 3, 4])
		
		let values2 = [ Pair(1, 1), Pair(2, 2), Pair(3, 3)]
		
		XCTAssertEqual(values2.upsert(Pair(2, 5), isEqual: { $0.left == $1.left }), [ Pair(1, 1), Pair(2, 5), Pair(3, 3) ])
	}
	
	func testUpsertKeyPath() {
		let values = [1, 2, 3]
		
		XCTAssertEqual(values.upsert(4, keyPath: \.self), [ 1, 2, 3, 4])
		
		let values2 = [ Pair(1, 1), Pair(2, 2), Pair(3, 3)]
		
		XCTAssertEqual(values2.upsert(Pair(2, 5), keyPath: \.left), [ Pair(1, 1), Pair(2, 5), Pair(3, 3) ])
	}
	
	func testsUpdateValues() {
		let local = [ Pair(1, "bla"), Pair(2, "blih"), Pair(3, "bluh")]
		let loaded = [ Pair(1, ""), Pair(2, ""), Pair(3, "")]

		XCTAssertEqual(
			loaded.updateValues(from: local) { current, local in
				var copy = current
				copy.right = local.right
				return copy
			},
			local
		)
	}
	
	func testsUpdateValuesMutating() {
		let local = [ Pair(1, "bla"), Pair(2, "blih"), Pair(3, "bluh")]
		var loaded = [ Pair(1, ""), Pair(2, ""), Pair(3, "")]

		loaded.updateValues(from: local) { current, local in
			current.right = local.right
		}
		
		XCTAssertEqual(
			loaded,
			local
		)
	}
	
	func testRemoveDuplicates() {
		let empty: [TestData] = []
		
		XCTAssertEqual(
			empty.removeDuplicates(id: { $0.id }, keep: { left, right in left }),
			[]
		)
		
		let single: [TestData] = [
			TestData(id: "1", value: 1),
		]
		
		XCTAssertEqual(
			single.removeDuplicates(id: { $0.id }, keep: { left, right in left }),
			[
				TestData(id: "1", value: 1),
			]
		)
		
		let withDups = [
			TestData(id: "1", value: 1),
			TestData(id: "1", value: 1),
			TestData(id: "1", value: 3),
			TestData(id: "2", value: 3),
			TestData(id: "3", value: 3),
			TestData(id: "4", value: 0),
			TestData(id: "1", value: 0)
		]
		
		XCTAssertEqual(
			withDups.removeDuplicates(id: { $0.id }, keep: { left, right in left }),
			[
				TestData(id: "1", value: 1),
				TestData(id: "2", value: 3),
				TestData(id: "3", value: 3),
				TestData(id: "4", value: 0)
			]
		)
		
		XCTAssertEqual(
			withDups.removeDuplicates(id: { $0.id }, keep: { left, right in right }),
			[
				TestData(id: "1", value: 0),
				TestData(id: "2", value: 3),
				TestData(id: "3", value: 3),
				TestData(id: "4", value: 0)
			]
		)
		
		XCTAssertEqual(
			withDups.removeDuplicatesById(),
			[
				TestData(id: "1", value: 1),
				TestData(id: "2", value: 3),
				TestData(id: "3", value: 3),
				TestData(id: "4", value: 0)
			]
		)
		
		XCTAssertEqual(
			withDups.removeDuplicatesByHash(),
			[
				TestData(id: "1", value: 1),
				TestData(id: "1", value: 3),
				TestData(id: "2", value: 3),
				TestData(id: "3", value: 3),
				TestData(id: "4", value: 0),
				TestData(id: "1", value: 0)
			]
		)
	}
	
	func testInterspersing() {
		XCTAssertEqual(
			[1,3,5].interspersing(2),
			[1,2,3,2,5]
		)
		
		XCTAssertEqual(
			[1].interspersing(2),
			[1]
		)
		
		XCTAssertEqual(
			[].interspersing(2),
			[]
		)
	}
	
	func testInterspersingArray() {
		XCTAssertEqual(
			[1,3,5].interspersing([2]),
			[1,2,3,5]
		)

		XCTAssertEqual(
			[1,3,5].interspersing([]),
			[1,3,5]
		)
		
		XCTAssertEqual(
			[1,3,5].interspersing([2,4]),
			[1,2,3,4,5]
		)
		
		XCTAssertEqual(
			[1,3,5].interspersing([2,4,6,8]),
			[1,2,3,4,5]
		)
		
		let empty: [Int] = []
		
		XCTAssertEqual(
			empty.interspersing([2,4,6,8]),
			[]
		)
	}
}

// MARK: Helper Models
struct Pair<Left, Right> {
	var left: Left
	var right: Right
	
	init(
		_ left: Left,
		_ right: Right
	) {
		self.left = left
		self.right = right
	}
}

struct TestData: Equatable, Hashable, Identifiable {
	var id: String
	var value: Int
}

extension Pair: Equatable where Left: Equatable, Right: Equatable {}
