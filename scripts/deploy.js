const { ethers } = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    // Déploiement du token DAO
    const DAOToken = await ethers.getContractFactory("DAOToken");
    const daoToken = await DAOToken.deploy(ethers.parseEther("1000000"));
    await daoToken.waitForDeployment(); // Remplace .deployed()
    console.log("DAOToken deployed to:", await daoToken.getAddress());

    // Déploiement de la DAO
    const DAO = await ethers.getContractFactory("DAO");
    const dao = await DAO.deploy(
        await daoToken.getAddress(),  // Adresse du token ERC20
        1,                            // Délai de vote initial (1 bloc)
        10,                           // Durée de vote initiale (10 blocs)
        4,                            // Fraction de quorum (4%)
        await daoToken.getAddress()   // Token pour les récompenses
    );
    await dao.waitForDeployment(); // Remplace .deployed()
    console.log("DAO deployed to:", await dao.getAddress());
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
