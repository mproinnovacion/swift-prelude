# zip for Optional

Free functions to zip values to a tuple or apply a function to multiple optionals only if we have all the values.

Example:

```swift
	let first: Int? = 1
	let second: Int? = 2

	zip(first, second) { $0 + $1 } // Will add both numbers if none of them is nil	
```
 
## Functions

2 parameters: zip, zip(_:,_:,with)
3 parameters: zip3, zip3(_:,_:,_:,with)
4 parameters: zip4, zip4(_:,_:,_:,_:,with)
