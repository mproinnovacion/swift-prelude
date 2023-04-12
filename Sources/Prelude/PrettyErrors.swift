import Foundation

public struct PrettyPrintedError: Error, CustomStringConvertible, CustomDebugStringConvertible {
	public var message: String
	public var original: Error
	
	public init(message: String, original: Error) {
		self.message = message
		self.original = original
	}
	
	public var description: String {
		message
	}
	
	public var debugDescription: String {
		message
	}
}

extension PrettyPrintedError {
	public static func prettyPath(
		_ path: [CodingKey]
	) -> String? {
		let result = path.map { key in
			if let index = key.intValue {
				return "[\(index)]"
			}
			else {
				return ".\(key.stringValue)"
			}
		}.joined()
		
		return path.count > 0 ? result : nil
	}
	
	public static func from(
		_ error: Error
	) -> Self {
		var pretty: String = ""
		switch error {
			case let DecodingError.typeMismatch(_, context):
				pretty += "🚫 DecodingError: typeMismatch ♦️\n\(context.debugDescription)"
				
				if let path = prettyPath(context.codingPath) {
					pretty += "\nPath: \(path)"
				}
				
				if let underlying = context.underlyingError {
					pretty += "\nUnderlying error: \(underlying.localizedDescription)"
				}
				
			case let DecodingError.keyNotFound(key, context):
				pretty += "🚫 DecodingError: keyNotFound \"\(key.stringValue)\" 🔑"

				if let path = prettyPath(context.codingPath) {
					pretty += "\nPath: \(path)"
				}
				
				if let underlying = context.underlyingError {
					pretty += "\nUnderlying error: \(underlying.localizedDescription)"
				}
				
				pretty += "\n\n\(context.debugDescription)"
				
			case let DecodingError.dataCorrupted(context):
				pretty += "🚫 DecodingError: dataCorrupted 🧟"

				pretty += " \(context.debugDescription)\n"

				if let path = prettyPath(context.codingPath) {
					pretty += "\nPath: \(path)"
				}
				
				if let underlying = context.underlyingError {
					let nsError = underlying as NSError
					if let description = nsError.userInfo[NSDebugDescriptionErrorKey] {
						pretty += "\n\(description)"
					}
				}

			default:
				pretty = "\(error)"
		}
		
		pretty += "\n▵ 🔚\n"

		return .init(message: pretty, original: error)
	}
}

public func prettyErrors<Success>(
	_ f: @escaping () throws -> Success
) rethrows -> Success {
	do {
		return try f()
	} catch {
		throw PrettyPrintedError.from(error)
	}
}
