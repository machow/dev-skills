---
name: code-standards
description: Code standards and patterns for great-tables development. Use when writing new code, reviewing PRs, or refactoring. Covers testing patterns, architecture, documentation, and API design.
---

# Great-Tables Code Standards

These standards are derived from PR review patterns. Apply them when writing or reviewing code.

## Principles

1. **Test one behavior per case** - Each test should verify exactly one thing
2. **Keep gt.py thin** - Delegate implementation to specialized modules
3. **Interface over isinstance** - Types implement methods instead of branching on type
4. **Be specific in docstrings** - Reference parameter names, not vague terms
5. **Use functools.partial for variants** - Reduce duplication for context-specific versions
6. **Use None for auto-detect defaults** - Allow override while enabling smart defaults
7. **Separate features from refactoring** - One PR = one logical change
8. **Co-locate and consolidate** - Avoid single-use imports, use existing methods, validate once

## Quick Reference

| Pattern | Key Technique |
|---------|---------------|
| Testing | `@pytest.mark.parametrize("kwargs,expected", [...])` - only non-defaults |
| Architecture | Attach functions from `_export.py` as methods on GT |
| Interfaces | Classes implement `.to_html()` / `.to_latex()` methods |
| Docstrings | "Apply `func` to matches of `pattern`" - use param names |
| Variants | `partial(fmt_context, context="html")` |
| Defaults | `def f(option=None):` where None means auto-detect |
| PRs | Feature PR + Refactor PR separately |
| Organization | Co-locate single-use code; use existing methods; validate once |

## Detailed Examples

See individual files for before/after examples:

- [01-test-one-behavior.md](01-test-one-behavior.md)
- [02-keep-gt-thin.md](02-keep-gt-thin.md)
- [03-interface-over-isinstance.md](03-interface-over-isinstance.md)
- [04-specific-docstrings.md](04-specific-docstrings.md)
- [05-use-partial.md](05-use-partial.md)
- [06-none-for-autodetect.md](06-none-for-autodetect.md)
- [07-separate-prs.md](07-separate-prs.md)
- [08-code-organization.md](08-code-organization.md)
