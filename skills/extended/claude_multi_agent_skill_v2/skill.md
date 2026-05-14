
# Multi-Agent Orchestrator Skill

## Purpose
Production-grade Claude-compatible multi-agent system with planning, execution, evaluation, and tool plugins.

## Agents
- Planner: Generates structured steps
- Executor: Executes steps via tools
- Evaluator: Decides completion, retry, or replan
- Orchestrator: Coordinates full loop

## Execution Loop
1. Plan
2. Execute
3. Evaluate
4. Replan if needed
5. Repeat until complete

## Input
{
  "goal": "string"
}

## Output
{
  "goal": "string",
  "results": []
}

## Constraints
- Safe execution required
- Structured JSON outputs only
