#  Array Utilities

##	 subscript(safe index: Int)

Useful for retrieving and modifying values in a safe way.

```swift
array[safe: -1] // Will produce nil
```

##	 compact

Convert an array of optional values to an array of values by removing all the nils.

```swift
array.compact()

// Equivalent to this
array.compactMap { $0 }
```

##	 upsert(_:isEqual:)

Updates the item in place if found, appends it if it wasn't there.

```swift
array.upsert(user) { $0.id == $1.id }
```
##	 upsert(_:keyPath:)

Same as the one before, but uses a property of the Element for to determine equality.

```swift
array.upsert(user, keyPath: \.id)
```

## updateValues(from:update:)

Updates values from one array to another positionally. Makes a new copy. Accepts a closure that performs the update.

This function is useful, for example, to apply local data to data refreshed remotely, or to update only some fields of some data.

There is also a mutating version of this function.

## removeDuplicatesByHash()

Remove duplicate values in an array, where equality is determined by their hash values.

## removeDuplicatesById()

Remove duplicate values in an array of Identifiable elements, where equality is determined by their id.

## removeDuplicates(id:keep:)

Remove duplicate values, specifying how to identify them, and which one we want to keep.
