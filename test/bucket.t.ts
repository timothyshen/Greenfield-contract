import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("ebook", function () {
  let owner: any;
  let otherAccount: any;
  beforeEach(async function () {
    const [owner1, otherAccount1] = await ethers.getSigners();
    owner = owner1;
    otherAccount = otherAccount1;
    const Ebook = await ethers.getContractFactory("EbookShop");
    this.ebook = await Ebook.deploy();
    await this.ebook.initialize(
      "0xeEBe00Ac0756308ac4AaBfD76c05c4F3088B8883",
      "0x9CfA6D15c80Eb753C815079F2b32ddEFd562C3e4",
      "0x427f7c59ED72bCf26DfFc634FEF3034e00922DD8",
      "0x275039fc0fd2eeFac30835af6aeFf24e8c52bA6B",
      "0x0e1506Fc8EB4b429E5531DA653Ad2391b7E89a3b",
      21000,
      "0x0e1506Fc8EB4b429E5531DA653Ad2391b7E89a3b",
      4,
      "0x0e1506Fc8EB4b429E5531DA653Ad2391b7E89a3b",
      "0x10C6E9530F1C1AF873a391030a1D9E8ed0630D26",
      2
    );
  });

  describe("Deployment", function () {
    it("Should set the right owner", async function () {
      await this.ebook.initialize(
        "0xeEBe00Ac0756308ac4AaBfD76c05c4F3088B8883",
        "0x9CfA6D15c80Eb753C815079F2b32ddEFd562C3e4",
        "0x427f7c59ED72bCf26DfFc634FEF3034e00922DD8",
        "0x275039fc0fd2eeFac30835af6aeFf24e8c52bA6B",
        "0x0e1506Fc8EB4b429E5531DA653Ad2391b7E89a3b",
        210000,
        "0x0e1506Fc8EB4b429E5531DA653Ad2391b7E89a3b",
        4,
        "0x0e1506Fc8EB4b429E5531DA653Ad2391b7E89a3b",
        "0x10C6E9530F1C1AF873a391030a1D9E8ed0630D26",
        2
      );
      expect(await this.ebook.owner()).to.equal(owner.address);
    });
  });
});
