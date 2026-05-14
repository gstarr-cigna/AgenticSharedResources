---
description: Plan a task as ≤2-point sub-agent tasks and orchestrate them in parallel/serial waves
argument-hint: <goal, plan file path, or "continue">
---

You are orchestrating work across specialized sub-agents. Follow the operating model below exactly. This command is cross-tool — when run in Claude Code, "spawn a sub-agent" means use the `Agent` tool; when run in Cursor or another assistant, use that assistant's native sub-agent or multi-task mechanism. The pattern (parallel waves, ≤2-point self-contained tasks, required Agents.md reference) is identical either way.

## Input

The user's input is: **$ARGUMENTS**

Interpret it as one of:
- **A plan file path** (ends in `.md` and exists) → load it and resume from the first unchecked task
- **The word "continue"** → find the most recent plan file at the repo root matching `*PLAN*.md` or `*plan*.md` and resume
- **Anything else** → treat as a goal description and draft a new plan before executing

If ambiguous, ask one clarifying question, then proceed.

## Operating model (non-negotiable)

### Task sizing
- **Every sub-agent task is ≤ 2 points.** (1 pt ≈ a single small file; 2 pt ≈ one component + one story, or one config file with several settings.) If a task would exceed 2, split it.
- Each task must be **completable in isolation** — the prompt alone carries every reference, file path, line range, and acceptance criterion the sub-agent needs. Do not rely on conversation history the sub-agent can't see.

### Agents.md reference (required)
- Before launching **any** sub-agent, check for an `Agents.md` (or `AGENTS.md`) at the repo root. If it exists, **every** sub-agent prompt must open with:
  > `First read <absolute path to Agents.md> and follow its operating principles.`
- If no `Agents.md` exists, note it to the user and proceed without that line.

### Sub-agent type / task mode selection
- **Discovery only (no writes)** → read-only, exploratory search
- **Implementation** → default; sub-agent may write files per its deliverable
- **Architectural design** → only when the user asks for a deeper design pass on a specific subtask

Map these to your assistant's actual agent/task types (Claude Code: `Explore`, `general-purpose`, `Plan`; Cursor: whichever agent/task mode applies).

### Parallelism
- Within a wave of independent tasks, launch them **concurrently in a single batch** (in Claude Code: one message with multiple `Agent` tool calls).
- Never parallelize tasks that share write paths or that have a producer/consumer dependency.
- Between waves, wait for the current wave to finish before launching the next.

### The plan document
Write or update a plan file at the repo root (default: `PLAN.md`, or reuse whatever the user points at). Structure:

```markdown
# <Goal> — Execution Plan

## Goal
<1–3 sentences: what "done" looks like>

## Technical decisions
| Decision | Choice | Rationale |
|---|---|---|

## Status (<today's date>)
- `[x]` done  · `[~]` partial · `[ ]` not started
- One line per task

## Orchestration rules
(Copy the "Sub-agent prompt template" section below into the plan verbatim.)

## Phases & tasks
### Phase N — <name> (<count> tasks, <parallel|sequential>)

#### Task N.M — <title> · <points> pts · <agent type>

**Depends on:** <task ids or "none">

**References (sub-agent reads these first):**
- <absolute path>:<line range> — <what to look for>

**Deliverable:**
<exact file paths + component/spec + story spec if applicable>

**Acceptance criteria:**
- [ ] <criterion>
- [ ] <criterion>

**Verify:**
Run `<command>` and confirm <observable outcome>.

**Constraints:**
- Do not modify files outside those listed.
- Do not install packages beyond: <list or "none">.
- <Any version pins the project requires>
- If blocked, stop and report — do not improvise.

## Execution order
<ASCII graph showing sequential → parallel batches → sequential>
```

### Sub-agent prompt template (use verbatim)

```
First read <abs path to Agents.md> and follow its operating principles.

Working directory: <abs path>

TASK: <task id + name>

CONTEXT:
<1–3 sentences on why this task exists and how it fits>

REFERENCES (read these first):
- <abs path>:<line range> — <what to look for>

DELIVERABLE:
<exact file paths + specs>

ACCEPTANCE CRITERIA:
- [ ] <criterion>

VERIFY:
Run `<command>` and confirm <outcome>.

CONSTRAINTS:
- Do not modify files outside those listed above.
- Do not install packages beyond: <list or "none">.
- <version pins if any>
- If blocked, stop and report — do not improvise.
```

## Your procedure

1. **Resolve input** (plan file vs. continue vs. goal). State which path you chose in one sentence.
2. **Discover context** — read `Agents.md` if present; read `package.json` / `pyproject.toml` / etc. to learn the stack; list repo root.
3. **Draft or load the plan:**
   - If drafting: write `PLAN.md` following the structure above. Every task ≤ 2 pts. Every task self-contained. Identify parallel waves.
   - If loading: summarize current status and identify the next wave.
4. **Stop and confirm before spawning agents.** Show the user the plan summary (phases, task counts, parallelism, any open decisions) and ask: *"Proceed with wave <N>? (yes / edit plan / change scope)"* — wait for approval.
5. **On approval, execute one wave at a time:**
   - Launch the wave as a single batch of sub-agents using the prompt template.
   - When all agents in the wave return, verify their acceptance criteria yourself (read the files they wrote, run the verify commands). Do not take the agent's summary at face value.
   - Update the plan's status checkboxes.
   - Report the wave outcome in ≤ 5 lines and ask to proceed to the next wave.
6. **Final wave done:** summarize what shipped, what's uncommitted, and the recommended next step (often: commit, run full test suite, open PR). Do **not** commit or push unless the user asks.

## Guardrails

- Never skip the confirmation step before spawning agents, even if the plan seems obvious.
- Never let a task balloon past 2 pts mid-flight — split it and update the plan first.
- Never parallelize tasks that touch the same files.
- If an agent fails or returns ambiguous output, stop the wave, report, and ask — do not auto-retry or improvise around it.
- Destructive operations (deletes, force-push, schema drops, package downgrades) require explicit user approval even if they appear in the plan.
