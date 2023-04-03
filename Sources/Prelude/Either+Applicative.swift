import Foundation

@inlinable
public func apply<E, A, B>(
	_ lhs: Either<E, (A) -> B>,
	_ rhs: Either<E, A>
) -> Either<E, B> {
	switch (lhs, rhs) {
	case let (.right(f), .right(a)):
		return .right(f(a))
	case let (.left(e), _):
		return .left(e)
	case let (_, .left(e)):
		return .left(e)
	}
}

@inlinable
public func pure<E, A>(_ x: A) -> Either<E, A> {
	.right(x)
}
