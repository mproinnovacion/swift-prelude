import Foundation

@inlinable
public func id<A>(_ a: A) -> A {
	a
}

@inlinable
public func absurd<A>(_ n: Never) -> A {}

@inlinable
public func discard<A, B>(_ f: @escaping (A) -> B) -> (A) -> Void {
	{ a in
		_ = f(a)
	}
}

@inlinable
public func const<A, B>(_ b: B) -> (_ a: A) -> B {
	{ _ in b }
}
