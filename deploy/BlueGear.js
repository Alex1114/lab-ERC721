const { ethers } = require("hardhat");

const NFT = artifacts.require("BlueGear");

module.exports = async ({
  getNamedAccounts,
  deployments,
  getChainId,
  getUnnamedAccounts,
}) => {
  const {deploy, all} = deployments;
  const accounts = await ethers.getSigners();
  const deployer = accounts[0];
  console.log("");
  console.log("Deployer: ", deployer.address);

  nft = await deploy('BlueGear', {
    contract: "BlueGear",
    from: deployer.address,
    args: [
    ],
  });

  console.log("BlueGear address: ", nft.address);
};

module.exports.tags = ['BlueGear'];