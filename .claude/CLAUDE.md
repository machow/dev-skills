# Dev Skills

Claude Code skills for development workflows. Each skill is a directory with a `SKILL.md` file.

## Project Structure

```
<skill-name>/
  SKILL.md            # Skill definition (YAML frontmatter + markdown)
  report-template.md  # Optional supporting files
sync-skills.sh        # Copies all skills to ~/.claude/skills/
```

## Skills

- `dev-workflow` — Orchestrator: plan → refine x2 → approve → implement (headless) → review x2 → verify
- `plan-refine-codex` — Sends a plan file to OpenAI Codex for refinement
- `roborev-review` — AI code review (HEAD/dirty/branch/sha)
- `roborev-refine` — Automated review-fix loop
- `roborev-show` — Display existing review results

## Adding/Editing Skills

1. Create or edit `<skill-name>/SKILL.md`
2. Run `bash sync-skills.sh` to deploy to `~/.claude/skills/`
3. Sync requires sandbox bypass (writes outside the project)

## Conventions

- Skill names are kebab-case
- Skills should specify `allowed-tools` to restrict scope where possible
- Use `$ARGUMENTS` for user input, `${CLAUDE_SESSION_ID}` for session-scoped files
- Ephemeral files (plans, reports) go in `.claude/plans/` — gitignored

## Ephemeral Files

`.claude/plans/` contains session-scoped artifacts:
- `<session-id>.md` — plans
- `<session-id>-report.md` — filled-in reports from headless sessions

These should not be committed.
