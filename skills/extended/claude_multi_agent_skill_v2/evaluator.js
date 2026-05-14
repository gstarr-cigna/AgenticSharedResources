
async function evaluatorAgent(goal, step, result) {
  if (result.error) {
    return { replan: true };
  }

  return {
    complete: false,
    replan: false
  };
}

module.exports = { evaluatorAgent };
