# Keep gt.py Thin

The main GT class file should be a thin wrapper. Move implementation to specialized modules.

## Bad Example

```python
# gt.py contains rendering logic
# gt.py
class GT:
    def as_latex(self):
        # 200 lines of LaTeX rendering logic here...
        heading = self._create_latex_heading()
        body = self._create_latex_body()
        return f"\\begin{{table}}\n{heading}\n{body}\n\\end{{table}}"

    def _create_latex_heading(self):
        ...  # more implementation

    def _create_latex_body(self):
        ...  # more implementation
```

## Good Example

```python
# gt.py delegates to specialized module
# gt.py
from great_tables._export import as_latex

class GT:
    as_latex = as_latex  # attach as method


# _export.py
def as_latex(self: GT) -> str:
    """Get LaTeX representation of table."""
    from great_tables._utils_render_latex import render_latex
    return render_latex(self._build_data(context="latex"))


# _utils_render_latex.py
def render_latex(data: GTData) -> str:
    """All LaTeX rendering logic lives here."""
    ...
```

## Guidelines

- `gt.py` should mostly contain method assignments and the class definition
- Implementation goes in `_utils_*.py` or `_export.py`
- Don't expose internal methods to users (use underscore prefix or move to utils)
- Use `TYPE_CHECKING` imports to avoid circular dependencies:

```python
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from great_tables._gt_data import GTData
```
