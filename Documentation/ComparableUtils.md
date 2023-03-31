# Comparable Utilities

## clamped(to:)

Pass a closed range to clamp the comparable value to that range:

```swift
11.clamped(to: 0...10) // Will produce 10
```

## clamped(to:)

Pass a partially closed range to clamp the comparable value:

```swift
11.clamped(to: ...10) // Will produce 10
11.clamped(to: 20...) // Will produce 20
```
