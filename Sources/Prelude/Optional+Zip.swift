import Foundation

public func zip<Input1, Input2>(_ left: Input1?, _ right: Input2?) -> (Input1, Input2)? {
	guard let left = left, let right = right else {
		return nil
	}
	
	return (left, right)
}

public func zip<Input1, Input2, Output>(
	_ left: Input1?,
	_ right: Input2?,
	with f: @escaping (Input1, Input2) -> Output
) -> Output? {
	zip(left, right).map(f)
}

public func zip3<Input1, Input2, Input3>(
	_ first: Input1?,
	_ second: Input2?,
	_ third: Input3?
) -> (Input1, Input2, Input3)? {
	guard
		let first = first,
		let second = second,
		let third = third
	else {
		return nil
	}
	
	return (first, second, third)
}

public func zip3<Input1, Input2, Input3, Output>(
	_ first: Input1?,
	_ second: Input2?,
	_ third: Input3?,
	with f: @escaping (Input1, Input2, Input3) -> Output
) -> Output? {
	zip3(first, second, third).map(f)
}

public func zip4<Input1, Input2, Input3, Input4>(
	_ first: Input1?,
	_ second: Input2?,
	_ third: Input3?,
	_ fourth: Input4?
) -> (Input1, Input2, Input3, Input4)? {
	guard
		let first = first,
		let second = second,
		let third = third,
		let fourth = fourth
	else {
		return nil
	}
	
	return (first, second, third, fourth)
}

public func zip4<Input1, Input2, Input3, Input4, Output>(
	_ first: Input1?,
	_ second: Input2?,
	_ third: Input3?,
	_ fourth: Input4?,
	with f: @escaping (Input1, Input2, Input3, Input4) -> Output
) -> Output? {
	zip4(first, second, third, fourth).map(f)
}
