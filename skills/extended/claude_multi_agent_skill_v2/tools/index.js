
const fs = require("fs/promises");

module.exports = {
  "fs.read": async ({ path }) => {
    const content = await fs.readFile(path, "utf-8");
    return { content };
  }
};
