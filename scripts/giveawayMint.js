// We require the Hardhat Runtime Environment explicitly here. This is optional 
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

const NFT = artifacts.require("BlueGear");

async function main() {


  let nftAddress = "0xFbd87C5A144dd178771e8b37403d8F443908e63D";
  let nft = await NFT.at(nftAddress);


  let numPurchase = 1;

  await nft.giveawayMint("0xbd42A2035D41b450eE7106C9F9C0C736fb546226", numPurchase);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
