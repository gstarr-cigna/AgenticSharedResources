
const { orchestrate } = require("./orchestrator");
module.exports = async function(input) {
  return await orchestrate(input.goal);
};
