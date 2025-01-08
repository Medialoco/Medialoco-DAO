require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200, // Ajustez cette valeur pour le compromis entre taille et coût du gas
      },
    },
  },
};
