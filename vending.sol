// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4; 

/**
We are creating a vending machine contract:
1. State variables to store our key data in storagr
2. Constructo to set owner, and the inital vending balance
3. function to purchase, restock and get balance of the contract
4. Map the addresses that purchases using the vending to the anount.

*/

contract vendingMachine {

    address public owner;
    mapping(address => uint) public donutBalance;

    constructor() {
        owner = payable(msg.sender);
        donutBalance[address(this)] = 500;

    }
    receive() external payable {

    } 

    fallback() external payable {

    }

    function getBalance() public view returns(uint) {
        return donutBalance[address(this)];
    }

    function reStockDonuts(uint amount) public {
        require(msg.sender == owner, "Sorry, only the Owner can restock Donuts");
        donutBalance[address(this)] += amount;
    }

    function purchaseDonuts(uint amountPurchased) public payable {
        uint donutPrice = 1 ether;
        require(msg.value >= amountPurchased * donutPrice, "Insufficient Funds");
        require(donutBalance[address(this)] >= amountPurchased, "Insufficient Donuts");
        donutBalance[address(this)] -= amountPurchased;

        donutBalance[msg.sender] += amountPurchased;
        donutBalance[address(this)] += donutPrice;

        payable(owner).transfer(msg.value);
        
    }

     function getContractBalance() public view returns(uint) {
        return owner.balance;
    }


}