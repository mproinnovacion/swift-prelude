import Foundation

public enum Failable<RawValue> {
	case valid(RawValue)
	case invalid(Error)
	
	public init(rawValue: RawValue) {
		self = .valid(rawValue)
	}
	
	public func map<B>(_ f: (RawValue) -> B) -> Failable<B> {
		switch self {
		case let .valid(value):
			return .valid(f(value))
		case let .invalid(error):
			return .invalid(error)
		}
	}
	
	public var rawValue: RawValue? {
		get {
			switch self {
			case let .valid(value):
				return value
			case .invalid:
				return nil
			}
		}
		
		set {
			guard let value = newValue else {
				return
			}
			
			switch self {
			case .valid:
				self = .valid(value)
			case .invalid:
				break
			}
		}
	}
	
	public var error: Error? {
		switch self {
		case .valid:
			return nil
		case let .invalid(error):
			return error
		}
	}
	
	public static func from(_ optional: RawValue?, error: Error) -> Failable<RawValue> {
		switch optional {
		case let .some(value):
			return .valid(value)
		case nil:
			return .invalid(error)
		}
	}
	
	public var either: Either<Error, RawValue> {
		switch self {
		case let .valid(value):
			return .right(value)
		case let .invalid(e):
			return .left(e)
		}
	}
}

extension Failable: CustomStringConvertible {
	public var description: String {
		String(describing: self.rawValue)
	}
}

extension Failable: CustomPlaygroundDisplayConvertible {
	public var playgroundDescription: Any {
		switch self {
		case let .valid(value):
			return value
		case let .invalid(error):
			return error
		}
	}
}

// MARK: - Conditional Conformances

extension Failable: Decodable where RawValue: Decodable {
	public init(from decoder: Decoder) throws {
		do {
			self.init(rawValue: try decoder.singleValueContainer().decode(RawValue.self))
		} catch let error {
			self = .invalid(error)
		}
	}
}

extension Failable: Encodable where RawValue: Encodable {
	public func encode(to encoder: Encoder) throws {
		guard let value = self.rawValue else {
			return
		}
		
		var container = encoder.singleValueContainer()
		try container.encode(value)
	}
}

extension Failable: Equatable where RawValue: Equatable {
	public static func == (lhs: Failable, rhs: Failable) -> Bool {
		return lhs.rawValue == rhs.rawValue
	}
}

extension Failable: Error where RawValue: Error {
}

extension Failable: ExpressibleByBooleanLiteral where RawValue: ExpressibleByBooleanLiteral {
	public typealias BooleanLiteralType = RawValue.BooleanLiteralType
	
	public init(booleanLiteral value: RawValue.BooleanLiteralType) {
		self.init(rawValue: RawValue(booleanLiteral: value))
	}
}

extension Failable: ExpressibleByExtendedGraphemeClusterLiteral
where RawValue: ExpressibleByExtendedGraphemeClusterLiteral {
	public typealias ExtendedGraphemeClusterLiteralType = RawValue.ExtendedGraphemeClusterLiteralType
	
	public init(extendedGraphemeClusterLiteral: ExtendedGraphemeClusterLiteralType) {
		self.init(rawValue: RawValue(extendedGraphemeClusterLiteral: extendedGraphemeClusterLiteral))
	}
}

extension Failable: ExpressibleByFloatLiteral where RawValue: ExpressibleByFloatLiteral {
	public typealias FloatLiteralType = RawValue.FloatLiteralType
	
	public init(floatLiteral: FloatLiteralType) {
		self.init(rawValue: RawValue(floatLiteral: floatLiteral))
	}
}

extension Failable: ExpressibleByIntegerLiteral where RawValue: ExpressibleByIntegerLiteral {
	public typealias IntegerLiteralType = RawValue.IntegerLiteralType
	
	public init(integerLiteral: IntegerLiteralType) {
		self.init(rawValue: RawValue(integerLiteral: integerLiteral))
	}
}

extension Failable: ExpressibleByStringLiteral where RawValue: ExpressibleByStringLiteral {
	public typealias StringLiteralType = RawValue.StringLiteralType
	
	public init(stringLiteral: StringLiteralType) {
		self.init(rawValue: RawValue(stringLiteral: stringLiteral))
	}
}

extension Failable: ExpressibleByUnicodeScalarLiteral where RawValue: ExpressibleByUnicodeScalarLiteral {
	public typealias UnicodeScalarLiteralType = RawValue.UnicodeScalarLiteralType
	
	public init(unicodeScalarLiteral: UnicodeScalarLiteralType) {
		self.init(rawValue: RawValue(unicodeScalarLiteral: unicodeScalarLiteral))
	}
}

extension Failable: LosslessStringConvertible where RawValue: LosslessStringConvertible {
	public init?(_ description: String) {
		guard let rawValue = RawValue(description) else { return nil }
		self.init(rawValue: rawValue)
	}
}

extension Failable: Hashable where RawValue: Hashable {
	public func hash(into hasher: inout Hasher) {
		rawValue?.hash(into: &hasher)
	}
}

public extension Failable {
	static func validItems(_ items: [Failable<RawValue>]) -> [RawValue] {
		items.compactMap { $0.rawValue }
	}
	
	static func errors(_ items: [Failable<RawValue>]) -> [Error] {
		items.compactMap { $0.error }
	}
}

public func mapFailable<A, B>(
	_ transform: @escaping (A) -> B
) -> (Failable<A>) -> Failable<B> {
	{ $0.map(transform) }
}

extension Array {
	public func failable() -> [Failable<Element>] {
		self.map(Failable.init(rawValue:))
	}
}
