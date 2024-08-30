require("dotenv").config();
const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
const { ethers } = require("hardhat")
const { BigNumber, constants } = require('ethers');
// const { EtherSymbol } = constants;

require("@nomicfoundation/hardhat-chai-matchers");

const fromWei = (x) => ethers.formatEther(x.toString());
const toWei = (x) => ethers.parseEther(x.toString());
const fromWei8Dec = (x) => x / 100000000;
const toWei8Dec = (x) => x * 100000000;

const OracleEthUsd = "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419"

describe("Dex and Vault test", function (accounts) {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
it('system setup', async function () {
  [testOwner, other1, other2, other3] = await ethers.getSigners();

  const Token = await hre.ethers.getContractFactory("Token");
  token = await Token.deploy("DEXToken", "DEX", 1000000);
  await token.waitForDeployment();
  expect(await token.getAddress()).to.be.not.equal(ethers.ZeroAddress);
  expect(await token.getAddress()).to.match(/0x[0-9a-fA-F]{40}/);

  const SimpleDex = await hre.ethers.getContractFactory("SimpleDex");
  simpleDex = await SimpleDex.deploy(await token.getAddress(), OracleEthUsd);
  await simpleDex.waitForDeployment();
  expect(await simpleDex.getAddress()).to.be.not.equal(ethers.ZeroAddress);
  expect(await simpleDex.getAddress()).to.match(/0x[0-9a-fA-F]{40}/);

  const Oracle = await hre.ethers.getContractFactory("PriceConsumer");
  priceConsumerAddress = await simpleDex.ethUsdContract();
  pcContract = await Oracle.attach(priceConsumerAddress);
  console.log("priceConsumer @:" + priceConsumerAddress);

  const Treasury = await hre.ethers.getContractFactory("Treasury");
  treasury = await Treasury.deploy(await simpleDex.getAddress());
  await treasury.waitForDeployment();
  expect(await treasury.getAddress()).to.be.not.equal(ethers.ZeroAddress);
  expect(await treasury.getAddress()).to.match(/0x[0-9a-fA-F]{40}/);

  decimals = await pcContract.getPriceDecimals();
  console.log("ETH/USD decimals: " + decimals);
})


it("users change ethers for tokens in simple DEX", async function() {
  try {
    const ethUsdPrice = await pcContract.getLatestPrice();
    const formattedEthUsdPrice = ethers.formatUnits(ethUsdPrice, await pcContract.getPriceDecimals()); // Correct format for Chainlink price feeds
    console.log(`Latest ETH/USD Price: ${formattedEthUsdPrice}`);
  } catch (error) {
    console.log("Error while getting ETH/USD price:", error.message);
  }
  console.log("ETH/USD decimals: " + await simpleDex.ethPriceDecimals())
  console.log(await simpleDex.getAddress());
  await simpleDex.connect(testOwner).setTreasury(await treasury.getAddress())
  await token.connect(testOwner).setMinter(await simpleDex.getAddress())
})

it("users change ethers for tokens in simple DEX", async function(){
  token.transferOwnership(await simpleDex.getAddress());
  tx = await simpleDex.connect(other1).buyToken({value: toWei(1)})
  console.log("other1 token balance: " + fromWei(await token.balanceOf(other1)))
  tx = await simpleDex.connect(other2).buyToken({value: toWei(1.5)})
  console.log("other2 token balance: " + fromWei(await token.balanceOf(other2)))
  tx = await simpleDex.connect(other3).buyToken({value: toWei(2)})
  console.log("other3 token balance: " + fromWei(await token.balanceOf(other3)))
})

it("Simple DEX parameters", async function () {
  console.log("Token balance in dex contract: " + fromWei(await token.balanceOf(await simpleDex.getAddress())))
  console.log("ether balance in dex contract: " + fromWei(await ethers.provider.getBalance(await simpleDex.getAddress())))

  console.log("other1 token balance: " + fromWei(await token.balanceOf(other1)))
  console.log("other2 token balance: " + fromWei(await token.balanceOf(other2)))
  console.log("other3 token balance: " + fromWei(await token.balanceOf(other3)))

  console.log("ether balance in the treasury contract: " + fromWei(await ethers.provider.getBalance(await treasury.getAddress())))

  console.log("other1 ether balance: " + fromWei(await ethers.provider.getBalance(other1)))
  console.log("other2 ether balance: " + fromWei(await ethers.provider.getBalance(other2)))
  console.log("other3 ether balance: " + fromWei(await ethers.provider.getBalance(other3)))
})

it("Sell token to Simple DEX and parameters", async function () {
  tx = await simpleDex.connect(other1).sellToken(toWei(1000))
  tx = await simpleDex.connect(other2).sellToken(toWei(800))
  tx = await simpleDex.connect(other3).sellToken(toWei(1200))

  console.log("Token balance in dex contract: " + fromWei(await token.balanceOf(await simpleDex.getAddress())))
  console.log("ether balance in dex contract: " + fromWei(await ethers.provider.getBalance(await simpleDex.getAddress())))

  console.log("other1 token balance: " + fromWei(await token.balanceOf(other1)))
  console.log("other2 token balance: " + fromWei(await token.balanceOf(other2)))
  console.log("other3 token balance: " + fromWei(await token.balanceOf(other3)))

  console.log("ether balance in the treasury contract: " + fromWei(await ethers.provider.getBalance(await treasury.getAddress())))

  console.log("other1 ether balance: " + fromWei(await ethers.provider.getBalance(other1)))
  console.log("other2 ether balance: " + fromWei(await ethers.provider.getBalance(other2)))
  console.log("other3 ether balance: " + fromWei(await ethers.provider.getBalance(other3)))
})


})

