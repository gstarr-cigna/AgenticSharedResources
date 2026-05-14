
const { plannerAgent } = require("./planner");
const { executorAgent } = require("./executor");
const { evaluatorAgent } = require("./evaluator");

async function orchestrate(goal) {
  let plan = await plannerAgent(goal);
  let results = [];
  let stepIndex = 0;

  while (stepIndex < plan.steps.length) {
    const step = plan.steps[stepIndex];
    const result = await executorAgent(step);
    results.push({ step, result });

    const decision = await evaluatorAgent(goal, step, result);

    if (decision.complete) break;
    if (decision.replan) {
      plan = await plannerAgent(goal, results);
      stepIndex = 0;
      continue;
    }

    stepIndex++;
  }

  return { goal, results };
}

module.exports = { orchestrate };
