const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("DonationCollection", function () {
  it("Should return the new greeting once it's changed", async function () {
    const DonationCollection = await ethers.getContractFactory("DonationCollection");
    const donationCollection = await DonationCollection.deploy();
    await donationCollection.deployed();
    [owner, giver, recever] = await ethers.getSigners();

    const tx = await donationCollection.connect(giver).giveDonation({value: 1}); // Проверяем то что можем перевести деньги на контракт
    await tx.wait();

    const tx1 = await donationCollection.connect(owner).withdrawalOfFunds(1, recever.address); // Проверяем что можем перевести с контракта
    await tx1.wait();
  });
});
