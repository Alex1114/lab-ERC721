// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BlueGear is ERC721, Ownable {

	using SafeMath for uint256;

	// Variables
	// ------------------------------------------------------------------------
	uint public MAX_Token = 1000;
	uint public PRICE = 0.05 ether;
	bool public hasSaleStarted = true;

	// Events
	// ------------------------------------------------------------------------
	event mintEvent(address owner, uint256 numPurchase, uint256 totalSupply);
	

	constructor() ERC721("BlueGear", "BG") {
		setBaseURI("http://api.katanansamurai.art/Metadata/");
	}

	// Giveaway functions
	// ------------------------------------------------------------------------
	function giveawayMint(address _to, uint256 numPurchase) public onlyOwner{
		require(totalSupply() < MAX_Token, "Sold out!!");
		require(numPurchase > 0 && numPurchase <= 50, "You can mint minimum 1, maximum 50.");
		require(totalSupply().add(numPurchase) <= MAX_Token, "Exceeds MAX_Token.");

		for (uint i = 0; i < numPurchase; i++) {
			uint mintIndex = totalSupply().add(1);
			_safeMint(msg.sender, mintIndex);
		}

		emit mintEvent(_to, numPurchase, totalSupply());
	}

	// Mint functions
	// ------------------------------------------------------------------------
	function mintToken(uint256 numPurchase) public payable {
		require(hasSaleStarted == true, "Sale hasn't started.");
		require(totalSupply() < MAX_Token, "Sold out!");
		require(numPurchase > 0 && numPurchase <= 50, "You can mint minimum 1, maximum 50.");
		require(totalSupply().add(numPurchase) <= MAX_Token, "Exceeds MAX_Token.");
		require(msg.value >= PRICE.mul(numPurchase), "Ether value sent is below the price.");

		for (uint i = 0; i < numPurchase; i++) {
			uint mintIndex = totalSupply().add(1);
			_safeMint(msg.sender, mintIndex);
		}

		emit mintEvent(msg.sender, numPurchase, totalSupply());
	}

	function tokensOfOwner(address _owner) external view returns(uint256[] memory ) {
		uint256 tokenCount = balanceOf(_owner);
		
		if (tokenCount == 0) {
			return new uint256[](0);
		} else {
			uint256[] memory result = new uint256[](tokenCount);
			uint256 index;
			for (index = 0; index < tokenCount; index++) {
				result[index] = tokenOfOwnerByIndex(_owner, index);
			}
			return result;
		}
	}

	// setting functions
	// ------------------------------------------------------------------------
	function setBaseURI(string memory baseURI) public onlyOwner {
		_setBaseURI(baseURI);
	}

	function setMAX_Token(uint _MAX_num) public onlyOwner {
		MAX_Token = _MAX_num;
	}

	function set_PRICE(uint _price) public onlyOwner {
		PRICE = _price;
	}

	function startSale() public onlyOwner {
		hasSaleStarted = true;
	}

	function pauseSale() public onlyOwner {
		hasSaleStarted = false;
	}

	// Withdrawal functions
	// ------------------------------------------------------------------------
	function withdrawAll() public payable onlyOwner {
		require(payable(msg.sender).send(address(this).balance));
	}
}
  