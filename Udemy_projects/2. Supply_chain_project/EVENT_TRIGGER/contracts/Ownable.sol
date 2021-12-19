// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Ownable {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(isOwner(), "Caller is not the Owner!");
        _;
    }
    
    function isOwner() public view returns (bool){
        return (msg.sender == owner);
    }
}