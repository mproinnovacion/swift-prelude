#  String Utilities

## contains(_:)

Returns true if the parameter is found in the string. Case sensitive.

## containsIgnoringCase(_:)

Returns true if the parameter is found in the string. Case insensitive.

## equalsIgnoringCase(_:)

Checks if the current string is equal to the parameter. Case insensitive.

## containsDiacriticInsensitive(_:)

Checks if the string contains the parameter. Case and diacritic insensitive.

## isBlank(_:)

Static func to determine if a string value is nil, or empty by removing whitespaces and newlines.

## trimmingHead(_:ellipsis) 

Similar to prefix, but appends an ellipsis if the string was trimmed. If you omit the ellipsis, "…" will be used.

## trimmingTail(_:ellipsis) 

Same as the previous one, but for suffix instead of prefix.

## upperCase(_:)

Static func for uppercasing strings. Useful for composing functions.

## camelCase(_:)

Static func for formatting strings as camel case.

## underlineSpaces(_:)

Static func for replacing spaces with "_".

## removeSpaces(_:)

Removes spaces in a string.

## removeTildeN(_:)

Removes character "ñ", by replacing it with "n".

## removeDiacritics(_:)

Removes diacritics in a string.

## trimWhitespace(_:)

Trims whitespaces and newlines in a string.

## onlyAlphanumeric(_:)

Removes any non alphanumeric character in a string.

## htmlToPlain(_:)

Removes html tags to obtain a plaing string from an html.
