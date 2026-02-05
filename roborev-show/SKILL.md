---
name: roborev-show
description: Show existing code review results for a commit or job. Use to check review status without re-running.
argument-hint: "[commit-sha|job-id]"
allowed-tools: Bash
---

# Roborev Show Skill

Display the results of an existing code review.

## Usage

| Argument | Command | Description |
|----------|---------|-------------|
| (none) | `roborev show` | Show review for HEAD |
| `status` | `roborev status` | List recent jobs with IDs |
| `<sha>` | `roborev show <sha>` | Show review for specific commit |
| `<job-id>` | `roborev show --job <id>` | Show review by job ID |
| `prompt <id>` | `roborev show --prompt <id>` | Show the prompt sent to the reviewer |

## Finding Job IDs

If the user doesn't know the job ID, run `roborev status` first to show recent jobs:

```
Recent Jobs:
  ID  SHA                Repo                 Agent  Status  Time
  9   dirty              buzzsprout-headless  codex  done    1m13s
  8   dirty              buzzsprout-headless  codex  done    2m5s
```

Then use the ID with `roborev show --job <id>`.

## Instructions

1. If user asks to see "recent reviews" or doesn't provide an ID, run `roborev status` first

2. Parse the argument: `$ARGUMENTS`

2. Run the appropriate command:
   - If empty: `roborev show`
   - If starts with "prompt ": `roborev show --prompt <rest>`
   - If numeric and user wants job ID: `roborev show --job $ARGUMENTS`
   - Otherwise: `roborev show $ARGUMENTS`

3. Present the review results, highlighting:
   - Verdict (pass/fail)
   - Findings by severity
   - Questions/assumptions

## Related Skills

- `/roborev-review` - Run a new review
- `/roborev-address` - Fix findings from a review
- `/roborev-refine` - Automated fix loop
