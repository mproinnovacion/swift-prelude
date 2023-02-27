import Foundation

extension Array {
	public subscript(safe index: Int) -> Element? {
		guard index >= 0, index < endIndex else {
			return nil
		}
		
		return self[index]
	}
	
	public func compact<A>() -> [A] where A? == Element {
		self.compactMap { $0 }
	}
	
	public func upsert(
		_ item: Element,
		isEqual: @escaping (Element, Element) -> Bool
	) -> Self {
		let firstIndex = self.firstIndex(where: { isEqual(item, $0) })
		
		guard let index = firstIndex else {
			return self + [item]
		}
		
		var copy = self
		copy.remove(at: index)
		copy.insert(item, at: index)
		return copy
	}
  
	public func upsert<Value: Equatable>(
		_ item: Element,
		keyPath: KeyPath<Element, Value>
	) -> Self {
		self.upsert(item) { left, right in
			left[keyPath: keyPath] == right[keyPath: keyPath]
		}
	}
	
	/// Update values from local data to new refreshed data. Works positionally. Makes a new copy.
	public func updateValues(
		from local: Array,
		update: @escaping (_ current: Element, _ from: Element) -> Element
	) -> Array {
		let matching = self.prefix(local.count)
		let rest = self.dropFirst(local.count)

		return zip(matching, local).map(update) + rest
	}
	
	/// Update values from local data to new refreshed data. Works positionally. Mutates values in place.
	public mutating func updateValues(
		from local: Array,
		update: @escaping (_ current: inout Element, _ from: Element) -> Void
	) {
		let matching = self.prefix(local.count)
		let rest = self.dropFirst(local.count)

		self = zip(matching, local).map { current, local in
			var copy = current
			update(&copy, local)
			return copy
		} + rest
	}
	
	public func removeDuplicatesByHash() -> [Element] where Element: Hashable {
		self.removeDuplicates(id: { $0.hashValue }, keep: { left, right in left })
	}
	
	@available(macOS 10.15, *)
	public func removeDuplicatesById() -> [Element] where Element: Identifiable {
		self.removeDuplicates(id: { $0.id }, keep: { left, right in left })
	}
	
	public func removeDuplicates<ID: Hashable>(
		id: @escaping (Element) -> ID,
		keep: @escaping (Element, Element) -> Element
	) -> [Element] {
		var buffer = [Element]()
		var added = Set<ID>()
		for elem in self {
			let elemId = id(elem)
			
			if
				added.contains(elemId),
				let elemIndex = buffer.firstIndex(where: { id($0) == elemId }) {
				buffer[elemIndex] = keep(buffer[elemIndex], elem)
			} else {
				buffer.append(elem)
				added.insert(id(elem))
			}
		}
		return buffer
	}
}
