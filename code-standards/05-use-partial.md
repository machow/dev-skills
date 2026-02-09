# Use functools.partial for Variants

When you have context-specific variants of the same function, use partial to reduce duplication.

## Bad Example

```python
# Repetitive function definitions
def fmt_number_html(x, decimals=2):
    result = format_number(x, decimals)
    return f"<span>{result}</span>"

def fmt_number_latex(x, decimals=2):
    result = format_number(x, decimals)
    return f"\\num{{{result}}}"

def fmt_number_plain(x, decimals=2):
    result = format_number(x, decimals)
    return result

# Then later...
FormatFns(
    html=fmt_number_html,
    latex=fmt_number_latex,
    plain=fmt_number_plain,
)
```

## Good Example

```python
from functools import partial

def fmt_number_context(x, decimals=2, context="html"):
    result = format_number(x, decimals)
    if context == "html":
        return f"<span>{result}</span>"
    elif context == "latex":
        return f"\\num{{{result}}}"
    return result

# Create context-specific versions
FormatFns(
    html=partial(fmt_number_context, context="html"),
    latex=partial(fmt_number_context, context="latex"),
    plain=partial(fmt_number_context, context="plain"),
)
```

## Double Partial Pattern

For formatters with many shared parameters:

```python
pf_fmt = partial(
    fmt_scientific_context,
    data=self,
    decimals=decimals,
    n_sigfig=n_sigfig,
    # ... all shared params
)

FormatFns(
    html=partial(pf_fmt, context="html"),
    latex=partial(pf_fmt, context="latex"),
)
```
