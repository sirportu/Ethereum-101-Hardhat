const hre = require("hardhat");

async function main() {

  const [owner] = await hre.ethers.getSigners();
  const DTKContractFactory = await hre.ethers.getContractFactory("DinoToken");
  const DTKContract = await DTKContractFactory.deploy();
  await DTKContract.deployed();

  console.log("DTKContract deployed to:", DTKContract.address);
  console.log("DTKContract owner address:", owner.address);
  console.log("DTKContract transact: ", DTKContract.deployTransaction.hash);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
