# Code Organization

Co-locate code with its usage. Avoid indirection that doesn't earn its keep.

## Rules

1. **Avoid single-use functions in separate files.** If a function is only called in one place, define it next to its caller. Importing a helper from another module for a single use adds indirection without benefit.

2. **Use existing methods instead of reimplementing behavior.** If a class provides a method for something, call it — don't bypass it with lower-level logic that does the same thing differently. This keeps behavior consistent and avoids divergent code paths.

3. **Validate once, not everywhere.** If a field is required, make it non-optional or validate in `__init__`/`__post_init__`. Don't repeat the same guard in every method.

## Bad Example

```python
# _utils.py — helper used in exactly one place
def _extract_pattern_columns(pattern: str) -> list[str]:
    return re.findall(r"\{(\d+)\}", pattern)


# _cols_merge.py — imports it for a single use
from ._utils import _extract_pattern_columns

class ColMergeInfo:
    @property
    def pattern_columns(self) -> list[str]:
        return _extract_pattern_columns(self.pattern)

    # replace_na() exists on this class, but internal code calls is_na() directly
    def _apply(self, body, tbl_data):
        for col in self.vars:
            val = _get_cell(body, row, col)
            if is_na(tbl_data, val):  # bypasses self.replace_na()
                ...

    # same guard repeated in every method
    def validate(self):
        if self.pattern is None:
            raise ValueError("Pattern required")
        ...

    def merge(self, *values):
        if self.pattern is None:
            raise ValueError("Pattern required")
        ...

    def merge_values(self, col_values, col_is_missing):
        if self.pattern is None:
            raise ValueError("Pattern required")
        ...
```

## Good Example

```python
# _cols_merge.py — helper lives next to its only caller
import re

class ColMergeInfo:
    pattern: str  # required, not Optional — no need for None guards

    @property
    def pattern_columns(self) -> list[str]:
        # inline — no reason for this to be in a separate file
        return re.findall(r"\{(\d+)\}", self.pattern)

    def _apply(self, body, tbl_data):
        # uses the class's own method
        values = self.replace_na(*raw_values, tbl_data=tbl_data)
        return self.merge(*values)

    def merge(self, *values):
        # no None guard needed — pattern is required
        ...
```

## Key Questions

When reviewing, ask:
- Is this function imported from elsewhere but only used here? **Move it.**
- Does a method exist on the class that does this? **Call it.**
- Is the same check repeated in multiple methods? **Validate once or make the field required.**
