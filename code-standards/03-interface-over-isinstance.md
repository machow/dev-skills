# Interface Over isinstance

Instead of branching on type with isinstance checks, give types a common interface.

## Bad Example

```python
def render_text(text, context):
    if isinstance(text, Markdown):
        if context == "html":
            return markdown_to_html(text.content)
        elif context == "latex":
            return markdown_to_latex(text.content)
    elif isinstance(text, Html):
        if context == "html":
            return text.content
        elif context == "latex":
            return html_to_latex(text.content)
    elif isinstance(text, PlainText):
        if context == "html":
            return escape_html(text.content)
        elif context == "latex":
            return escape_latex(text.content)
```

## Good Example

```python
from abc import ABC, abstractmethod

class BaseText(ABC):
    @abstractmethod
    def to_html(self) -> str: ...

    @abstractmethod
    def to_latex(self) -> str: ...


class Markdown(BaseText):
    def __init__(self, content: str):
        self.content = content

    def to_html(self) -> str:
        return markdown_to_html(self.content)

    def to_latex(self) -> str:
        return markdown_to_latex(self.content)


class Html(BaseText):
    def __init__(self, content: str):
        self.content = content

    def to_html(self) -> str:
        return self.content

    def to_latex(self) -> str:
        return html_to_latex(self.content)


# Usage is uniform - no isinstance needed
def render_text(text: BaseText, context: str) -> str:
    if context == "html":
        return text.to_html()
    return text.to_latex()
```

## Benefits

- Adding new text types doesn't require modifying render_text()
- Adding new contexts only requires adding methods to each type
- Reduces branching complexity
- Makes the interface explicit and discoverable
