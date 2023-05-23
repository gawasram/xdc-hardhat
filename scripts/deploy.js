async function main() {
 // Deploy EggToken
const EggToken = await ethers.getContractFactory("contracts/EggToken.sol:EggToken");
const eggToken = await EggToken.deploy();
await eggToken.deployed();
console.log("EggToken deployed to:", eggToken.address);

// Deploy EggNFT
const EggNFT = await ethers.getContractFactory("contracts/EggNFT.sol:EggNFT");
const eggNFT = await EggNFT.deploy(eggToken.address);
await eggNFT.deployed();
console.log("EggNFT deployed to:", eggNFT.address);


  // Deploy Faucet
  const Faucet = await ethers.getContractFactory("contracts/Faucet.sol:Faucet");
  const faucet = await Faucet.deploy(eggToken.address);
  await faucet.deployed();
  console.log("Faucet deployed to:", faucet.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
