# Test One Behavior Per Case

Each test case should test ONE specific behavior, with minimal inputs.

## Anti-patterns

- Testing many inputs when one would suffice
- Using many parameters that reset to defaults
- Asserting only that "output exists" vs checking specific values
- Running same inputs across all cases when differences aren't meaningful

## Bad Example

```python
# What's being tested? Many params reset to defaults.
@pytest.mark.parametrize(
    "currency,use_subunits,decimals,drop_trailing,use_seps,placement,x_out",
    [
        (None, True, None, True, True, "left", "$1,234.00"),
        ("USD", True, None, True, True, "left", "$1,234.00"),  # Same output?
        ("EUR", True, None, True, True, "left", "€1,234.00"),
        (None, False, None, True, True, "left", "$1,234"),
        (None, True, 4, True, True, "left", "$1,234.0000"),
    ],
)
def test_fmt_currency(currency, use_subunits, decimals, drop_trailing, use_seps, placement, x_out):
    ...
```

## Good Example

```python
# Each case tests ONE thing, only non-defaults specified.
@pytest.mark.parametrize("kwargs,x_out", [
    ({}, "$1,234.00"),                          # default behavior
    ({"currency": "EUR"}, "€1,234.00"),         # tests: currency symbol
    ({"use_subunits": False}, "$1,234"),        # tests: no cents
    ({"decimals": 4}, "$1,234.0000"),           # tests: decimal precision
    ({"placement": "right"}, "1,234.00$"),      # tests: symbol placement
])
def test_fmt_currency(kwargs, x_out):
    result = fmt_currency(1234, **kwargs)
    assert result == x_out
```

## Key Points

- Use kwargs dict to make it clear what each case tests
- Only specify parameters that differ from defaults
- Each case name/comment should explain what behavior is being tested
- If inputs are complex, consider separate test functions
