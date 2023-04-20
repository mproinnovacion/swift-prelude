# prettyError

An utility function that will catch any error, embed it into a PrettyPrintedError and format it for better legibility.

Example:

```
try prettyErrors {
	let user = try JSONDecoder().decode(User.self, from: data)
}
```

For now it only parses DecodingErrors, but it should be extended for other types.
