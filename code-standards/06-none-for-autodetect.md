# Use None for Auto-Detect Defaults

Use `None` to mean "figure it out automatically" while still allowing explicit override.

## Bad Example

```python
# User must explicitly set make_page
def render_html(table, make_page: bool):
    """
    Parameters
    ----------
    make_page
        If True, wrap in full HTML page. If False, return fragment.
    """
    if make_page:
        return f"<html><body>{table}</body></html>"
    return table

# User must always decide, even when there's an obvious default
render_html(table, make_page=True)   # in standalone script
render_html(table, make_page=False)  # in Jupyter
```

## Good Example

```python
# None means auto-detect, explicit values override
def render_html(table, make_page: bool | None = None):
    """
    Parameters
    ----------
    make_page
        If True, wrap in full HTML page. If False, return fragment.
        If None (default), auto-detect based on environment.
    """
    if make_page is None:
        # Auto-detect: use fragment in notebooks, full page elsewhere
        make_page = not is_notebook_environment()

    if make_page:
        return f"<html><body>{table}</body></html>"
    return table

# Auto-detection just works
render_html(table)  # Does the right thing automatically

# But user can override when needed
render_html(table, make_page=True)  # Force full page in notebook
```

## When to Use

- Environment-dependent behavior (notebooks, Quarto, terminal)
- Options that have sensible defaults most of the time
- Parameters where "figure it out" is a valid choice
