require("@nomicfoundation/hardhat-toolbox");
require('solidity-docgen');

/** @type import('hardhat/config').HardhatUserConfig */

module.exports = {
  solidity: "0.8.24",
  docgen: {
    sourcesDir: 'contracts',
    outputDir: 'documentation',
    templates: 'templates',
    pages: 'files',
    clear: 'true',
    runOnCompile: true,
  },
  
};
