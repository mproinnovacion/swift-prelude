import Foundation

@dynamicMemberLookup
public struct ChangeDetector<Value> {
	public var value: Value
	
	public var willChange: (String, String) -> Void
	public var didChange: (String, String) -> Void
	
	public init(
		value: Value,
		willChange: @escaping (String, String) -> Void,
		didChange: @escaping (String, String) -> Void
	) {
		self.value = value
		self.willChange = willChange
		self.didChange = didChange
	}
	
	public subscript<ChildValue>(
		dynamicMember keyPath: WritableKeyPath<Value, ChildValue>
	) -> ChildValue {
		get {
			value[keyPath: keyPath]
		}
		set {
			let root = String(describing: Value.self)
			let child = String(describing: ChildValue.self)
			
			willChange(root, child)
			value[keyPath: keyPath] = newValue
			didChange(root, child)
		}
	}
}
