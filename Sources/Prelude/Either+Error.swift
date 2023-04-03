import Foundation

extension Either where A == Error {
	@inlinable
	public init(catching: @escaping () throws -> B) {
		do {
			self = .right(try catching())
		}
		catch let error {
			self = .left(error)
		}
	}
}
