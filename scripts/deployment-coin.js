const hre = require("hardhat");

async function main() {

  const [owner] = await hre.ethers.getSigners();
  const LSCContractFactory = await hre.ethers.getContractFactory("LuisCoin");
  const LSCContract = await LSCContractFactory.deploy();
  await LSCContract.deployed();

  console.log("LSCContract deployed to:", LSCContract.address);
  console.log("LSCContract owner address:", owner.address);
  console.log("LSCContract transact: ", LSCContract.deployTransaction.hash);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
