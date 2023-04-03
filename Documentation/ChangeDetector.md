# ChangeDetector

Utility wrapper that detects any changes in the properties of the wrapped value. Useful for detecting mocks in an Environment, for example.


The following code will take a live environment, wrap it in a ChangeDetector, and pass it to a debugMocks function for applying mocks in debug mode. Any modified property will be logged to the console.

```
var env = Environment.live

var wrapper = ChangeDetector(
	value: env,
	willChange: { print("🧰 MOCKED: \($0).\($1)") },
	didChange: { _, _ in }
)

debugMocks(&wrapper)

env = wrapper.value
```

