
const tools = require("./tools");

async function executorAgent(step) {
  const tool = tools[step.action];
  if (!tool) return { error: "Unknown tool" };

  try {
    return await tool(step.input);
  } catch (e) {
    return { error: e.message };
  }
}

module.exports = { executorAgent };
