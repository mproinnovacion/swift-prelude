import Foundation

extension Comparable {
	public func clamped(to limits: ClosedRange<Self>) -> Self {
		min(max(self, limits.lowerBound), limits.upperBound)
	}
	
	public func clamped(to limits: PartialRangeFrom<Self>) -> Self {
		max(self, limits.lowerBound)
	}
	
	public func clamped(to limits: Swift.PartialRangeThrough<Self>) -> Self {
		min(self, limits.upperBound)
	}
}
