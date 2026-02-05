---
name: roborev-review
description: Run roborev code review on commits or uncommitted changes. Use to get AI-powered code review feedback.
argument-hint: "[dirty|branch|commit-sha]"
allowed-tools: Bash
---

# Roborev Review Skill

Run an AI-powered code review using roborev.

## Usage

Based on the argument provided, run one of these commands:

| Argument | Command | Description |
|----------|---------|-------------|
| `dirty` | `roborev review --dirty --wait` | Review uncommitted changes |
| `branch` | `roborev review --branch --wait` | Review all commits on current branch since main |
| (none) | `roborev review --wait` | Review HEAD commit |
| `<sha>` | `roborev review <sha> --wait` | Review specific commit |

## Instructions

1. Parse the argument: `$ARGUMENTS`

2. Run the appropriate roborev command:
   - If argument is "dirty": `roborev review --dirty --wait`
   - If argument is "branch": `roborev review --branch --wait`
   - If argument is empty or not provided: `roborev review --wait`
   - Otherwise, treat argument as a commit SHA: `roborev review $ARGUMENTS --wait`

3. Wait for the review to complete (the `--wait` flag handles this)

4. Report the review results to the user, summarizing:
   - Overall verdict (pass/fail)
   - Key findings (high/medium/low severity)
   - Any questions or assumptions from the reviewer

## Example Invocations

- `/roborev-review` - Review the current HEAD commit
- `/roborev-review dirty` - Review uncommitted changes
- `/roborev-review branch` - Review the current branch
- `/roborev-review abc123` - Review a specific commit

## Next Steps After Review

Based on the review verdict, suggest appropriate next steps:

| Verdict | Suggested Action |
|---------|------------------|
| Pass | No action needed |
| Fail (minor) | Use `/roborev-address` to fix specific findings |
| Fail (multiple) | Use `/roborev-refine` for automated fix loop |
| Questions | Use `/roborev-respond` to answer reviewer questions |

## Related Skills

- `/roborev-show` - View existing review without re-running
- `/roborev-address` - Fix findings from a failed review
- `/roborev-respond` - Reply to reviewer questions
- `/roborev-refine` - Automated review-fix-repeat loop
