const {
	assert,
	expect
} = require('chai');
const {
	BN,
	time,
	expectRevert,
	constants,
	balance
} = require('@openzeppelin/test-helpers');
const {
	artifacts,
	ethers
} = require('hardhat');

describe("BlueGear", function () {

	let Token;
	let contract;
	let owner;
	let addr1;
	let addr2;
	let addrs;

	before(async function () {

		Token = await ethers.getContractFactory("BlueGear");
		[owner, addr1, addr2, ...addrs] = await ethers.getSigners();

		contract = await Token.deploy();
		console.log("BlueGear deployed to:", contract.address);

	});

	describe("BlueGear Test", function () {

		it("pauseSale Function", async function () {

			await contract.connect(owner).pauseSale();

		});


		it("startSale Function", async function () {

			await contract.connect(owner).startSale();

		});

		it("setBaseURI Function", async function () {

			await contract.connect(owner).setBaseURI("URI");

		});


		it("giveawayMint Function", async function () {

			await contract.connect(owner).giveawayMint(addr2.address, 2);
			expect(await contract.totalSupply()).to.equal(2);

		});

		it("mintToken Function", async function () {

			await contract.connect(addr2).mintToken(50, {value: "2500000000000000000"});
			expect(await contract.totalSupply()).to.equal(52);

		});

		it("mintToken Function", async function () {

			await contract.connect(addr1).mintToken(1, {value: "50000000000000000"});

		});
	
		it("withdrawAll Function", async function () {

			await contract.connect(owner).withdrawAll();

		});
	});
});