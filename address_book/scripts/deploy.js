// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const AddressBook = await hre.ethers.getContractFactory("AddressBook");
  const addressBook = await AddressBook.deploy();

  const contractAddress = addressBook.address; 
  const contract = await hre.ethers.getContractAt("AddressBook", contractAddress);

  const accounts = hre.network.accounts;
  console.log(
    accounts
  );
  
  /*
  await contract.addAddress()
  const init_addresbook = await contract.getADdr

  console.log(
    `Address book deployed to ${addressBook.address}`
  );

  await addressBook.addAddress(
  */
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
