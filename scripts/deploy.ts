import { ethers } from "hardhat";

async function main() {
  const cUSD_CELO_MAINNET = "0x765DE816845861e75A25fCA122bb6898B8B1282a";

  console.log("\nDeploying MicroMindPayment to Celo Mainnet...");
  const [deployer] = await ethers.getSigners();
  console.log(`Deployer: ${deployer.address}`);

  const Factory = await ethers.getContractFactory("MicroMindPayment");
  const contract = await Factory.deploy(cUSD_CELO_MAINNET);
  await contract.waitForDeployment();
  console.log(`Contract: ${await contract.getAddress()}`);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
