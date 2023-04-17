// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LuisCoin is ERC20, ERC20Burnable, Ownable {
    
    event personalLogger(
        address indexed sender,
        uint256 amount,
        string description
    );
    
    constructor() ERC20("LuisCoin", "LSC") {
        _mint(msg.sender, 1000 * 10 ** decimals());
        emit personalLogger( msg.sender, 1000 * 10 ** decimals(), "Begin of super LuisCoin!!!");
    }

    function mint(address to, uint256 amount) public onlyOwner {
        require(amount >= 0, "Amount cannot be 0!");
        _mint(to, amount);
        emit personalLogger( msg.sender, amount, "Token Minted Trx");
    }

    function burn(uint256 amount) public override onlyOwner {
        require(amount >= 0, "Amount cannot be 0!");
        _burn(msg.sender, amount);
        emit personalLogger( msg.sender, amount, "Token Burned Trx");
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        require(amount >= 0, "Amount cannot be 0!");
        _transfer(msg.sender, to, amount);
        emit personalLogger( msg.sender, amount, "Token Transfered Trx");
        return true;
    }
}