
async function plannerAgent(goal, history = []) {
  // Replace with Claude API call
  return {
    steps: [
      { action: "fs.read", input: { path: "./test.txt" } }
    ]
  };
}
module.exports = { plannerAgent };
