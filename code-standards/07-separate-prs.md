# Separate Features from Refactoring

Don't mix new features with sweeping refactors in the same PR.

## Bad Example

```
# PR title: "Add LaTeX export"

Changes:
- Add as_latex() method (the feature)
- Rename Text -> BaseText in 47 files (refactor)
- Update all imports (refactor)
- Add type hints to unrelated functions (refactor)
```

## Good Example

```
# PR 1: "Add LaTeX export"
- Add as_latex() method
- Add _utils_render_latex.py
- Add tests for LaTeX export

# PR 2: "Refactor: Rename Text to BaseText" (after PR 1 merges)
- Rename Text -> BaseText
- Update imports
- (Now easy to review in isolation)

# PR 3: "Add type hints to _helpers.py" (independent)
- Add type annotations
- (Can be reviewed/merged independently)
```

## Why This Matters

- **Easier to review**: Focused changes are faster to understand
- **Easier to revert**: If something breaks, you know which change caused it
- **Fewer merge conflicts**: Smaller PRs merge faster
- **Clear git history**: Each commit tells a clear story

## Guidelines

- One PR = one logical change
- Note refactoring opportunities during feature work, do them after
- If you find yourself saying "while I'm here...", stop and make a separate PR
