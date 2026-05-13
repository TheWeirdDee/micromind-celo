// Test revision 138
import { expect } from "chai";
import { ethers } from "hardhat";

describe("MicroMindPayment", function () {
  it("Should set the correct payment token", async function () {
    const [owner, token] = await ethers.getSigners();
    const Factory = await ethers.getContractFactory("MicroMindPayment");
    const contract = await Factory.deploy(token.address);
    expect(await contract.paymentToken()).to.equal(token.address);