# Failable

A utility so that an error parsing a property doesn't make the whole parsing fail. For example, we can have an array of News, and if we can't parse one of them the parsing will still succeed.

```
struct NewsResponse: Codable {
	var news: [Failable<News>]
}
```

We can later log all the errors and display only the valid news.
