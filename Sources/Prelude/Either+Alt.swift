import Foundation

extension Either {
	@inlinable
	public func orElse(
		_ right: @autoclosure () -> Either<A, B>
	) -> Either<A, B> {
		Self.alternative(self, right())
	}
	
	@inlinable
	public static func alternative(
		_ left: Either<A, B>,
		_ right: @autoclosure () -> Either<A, B>
	) -> Either<A, B> {
		left.isRight ? left : right()
	}
	
	@inlinable
	public static func alternative(
		_ left: Either<A, B>,
		_ defaultValue: B
	) -> B {
		left.right ?? defaultValue
	}
	
	@inlinable
	public func `default`(
		_ defaultValue: B
	) -> B {
		Self.alternative(self, defaultValue)
	}
}
