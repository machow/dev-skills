# dev-skills

Claude Code skills for structured development workflows.

## `/dev-workflow` — the whole game

Run `/dev-workflow <task>` and it handles everything:

```
Plan → Refine → Refine → Approve → Implement → Review → Review → Report
```

1. **Plan** — researches the codebase and writes an implementation plan
2. **Refine x2** — sends the plan to OpenAI Codex (`/plan-refine-codex`) for a second opinion, twice
3. **Approve** — presents the refined plan; you decide whether to proceed
4. **Implement** — executes the plan (optionally headless so your session stays free)
5. **Review x2** — runs AI code review (`/roborev-review`) and fixes findings, twice
6. **Report** — summarizes commits, review verdicts, and overall status

You approve once at step 3. Everything else runs autonomously.

## Key skills

### `/plan-refine-codex`

Sends a plan file to OpenAI Codex for refinement. Catches edge cases, tightens error handling, simplifies where possible. Used by `/dev-workflow` but also useful standalone when you want a second opinion on any plan.

```
/plan-refine-codex .claude/plans/my-plan.md
```

### `/roborev-review`

AI-powered code review via [roborev](https://github.com/machow/roborev). Reviews HEAD, uncommitted changes, a branch, or a specific commit.

```
/roborev-review          # review HEAD
/roborev-review dirty    # review uncommitted changes
/roborev-review branch   # review all commits since main
/roborev-review abc123   # review a specific commit
```

## Other skills

| Skill | Description |
|-------|-------------|
| `/roborev-refine` | Automated review-fix loop — keeps iterating until reviews pass |
| `/roborev-show` | Display existing review results without re-running |
| `/roborev-address` | Fix specific findings from a review |
| `/roborev-respond` | Reply to reviewer questions |

## Setup

Each skill is a directory with a `SKILL.md` file. To install them for use across projects:

```bash
bash sync-skills.sh
```

This copies all skills to `~/.claude/skills/`.
