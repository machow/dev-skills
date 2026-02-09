# Be Specific in Docstrings

Reference parameter names directly, not vague terms like "a pattern" or "a function".

## Bad Example

```python
def process_text(pattern, func, text):
    """
    Process text selectively.

    Uses a pattern to find matches and applies a function to transform them.
    """
    ...
```

## Good Example

```python
def process_text(pattern: str, func: Callable[[re.Match], str], text: str) -> str:
    """
    Apply func to every match of pattern within text.

    Parameters
    ----------
    pattern
        Regex pattern to match against text.
    func
        Function called for each match. Receives the Match object,
        returns the replacement string.
    text
        The input string to process.

    Returns
    -------
    str
        Text with all matches replaced by func's return values.

    Examples
    --------
    >>> process_text(r"\\d+", lambda m: str(int(m.group()) * 2), "a1b2")
    'a2b4'
    """
    return re.sub(pattern, func, text)
```

## Guidelines

- First sentence should clearly state what the function does
- Reference parameter names directly: "Apply `func` to matches of `pattern`"
- Use numpydoc style consistently
- Include concrete examples for complex functions
- When PR diffs are large but changes are small, add inline comments explaining what changed
