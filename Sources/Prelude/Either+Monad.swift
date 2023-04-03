import Foundation

extension Either {
	@inlinable
	public func flatMap<V>(_ f: (B) -> Either<A, V>) -> Either<A, V> {
		flatMapRight(f)
	}
	
	@inlinable
	public func flatMapLeft<V>(_ f: (A) -> Either<V, B>) -> Either<V, B> {
		biFlatMap(f, { (right) -> Either<V, B> in
			.right(right)
		})
	}
	
	@inlinable
	public func flatMapRight<V>(_ f: (B) -> Either<A, V>) -> Either<A, V> {
		biFlatMap({ (left) -> Either<A, V> in
			.left(left)
		}, f)
	}
	
	@inlinable
	public func biFlatMap<V, W>(_ f: (A) -> Either<V, W>, _ g: (B) -> Either<V, W>) -> Either<V, W> {
		switch self {
		case let .left(left):
			return f(left)
		case let .right(right):
			return g(right)
		}
	}
}
