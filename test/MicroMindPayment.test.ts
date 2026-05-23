// Test revision 125
import { expect } from "chai";
import { ethers } from "hardhat";

describe("MicroMindPayment", function () {
  it("Should set the correct payment token", async function () {
    const [owner, token] = await ethers.getSigners();