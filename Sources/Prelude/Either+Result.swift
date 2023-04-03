import Foundation

extension Either where A: Error {
	public static func from(
		_ result: Result<B, A>
	) -> Self {
		switch result {
			case let .success(value):
				return .right(value)
			case let .failure(error):
				return .left(error)
		}
	}
	
	public var result: Result<B, A> {
		switch self {
			case let .left(error):
				return .failure(error)
			case let .right(value):
				return .success(value)
		}
	}
}
