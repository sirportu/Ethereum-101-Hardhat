const hre = require("hardhat");

async function main() {

  const [owner] = await hre.ethers.getSigners();
  const VGSContractFactory = await hre.ethers.getContractFactory("VideoGamesStore");
  const VGSContract = await VGSContractFactory.deploy();
  await VGSContract.deployed();

  console.log("VGSContract deployed to:", VGSContract.address);
  console.log("VGSContract owner address:", owner.address);
  console.log("VGSContract transact: ", VGSContract.deployTransaction.hash);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
