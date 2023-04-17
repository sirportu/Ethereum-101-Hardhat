// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Strings.sol";

contract VideoGamesStore {
    struct VideoGame {
        uint256 stock;
        uint256 price;
    }

    address public storeOwner;
    string[] private videoGames;
    mapping(string => VideoGame) private inventoryStore;
    mapping(address => string[]) private customerInventory;

    event Log(address indexed sender, string message);

    event personalLogger(
        string indexed trxDescription,
        string videoGame,
        VideoGame videoGameData,
        address sender
    );

    constructor() {
        storeOwner = msg.sender;
    }

    function deliverGame(string memory _videoGame) public payable {
        emit personalLogger("Deliver transaction", _videoGame, inventoryStore[_videoGame], msg.sender);
        require(msg.value == inventoryStore[_videoGame].price, "You need paid the correct value!");
        require(inventoryStore[_videoGame].stock >= 0, "Dont have more stock for this video game!");
        inventoryStore[_videoGame].stock -= 1;
        customerInventory[msg.sender].push(_videoGame);
        emit Log(msg.sender, "Deliver transaction is successful");
    }

    function receiveGame(address payable _to, string memory _videoGame) public {
        emit personalLogger("Receive transaction", _videoGame, inventoryStore[_videoGame], msg.sender);
        inventoryStore[_videoGame].stock += 1;
        for (uint256 i; i<customerInventory[msg.sender].length; i++) {
            if (keccak256(abi.encodePacked(customerInventory[msg.sender][i])) == keccak256(abi.encodePacked(_videoGame))) {
                delete customerInventory[msg.sender][i];
                break;
            }
        }
        _to.transfer(inventoryStore[_videoGame].price);
        emit Log(msg.sender, "Receive transaction is successful");
    }

    function addGame(string memory _videoGame, uint256 _stock, uint256 _price) external {
        require(
            msg.sender == storeOwner,
            "You must be the owner of the store to see add new video game to store."
        );

        VideoGame memory newGame = VideoGame({ stock: _stock, price: _price });
        
        emit personalLogger("Add transaction", _videoGame, newGame, msg.sender);

        inventoryStore[_videoGame] = newGame;
        videoGames.push(_videoGame);
        emit Log(msg.sender, "Add transaction is successful");
    }

    function getGamePrice(string memory _videoGame) external view returns (uint256) {
        return inventoryStore[_videoGame].price;
    }

    function getGameList() external view returns (string[] memory) {
        return videoGames;
    }

    function getCustomerGames() external view returns (string[] memory) {
        return customerInventory[msg.sender];
    }

    function getStoreBalance() public view returns (uint256) {
        require(
            msg.sender == storeOwner,
            "You must be the owner of the store to see the balance of store."
        );
        return address(this).balance;
    }
}