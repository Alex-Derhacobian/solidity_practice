// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";

/*
=============
ADDRESS BOOK
=============

This is a smart contract that allows one to save a list of Ethereum account addresses to the blockchain with an alias name. 

Learning objectives: 
- Never save sensitive or private data to the public blockchain
- Data stored on the blockchain is publicky read
*/
contract AddressBook{
    mapping (address => address[]) private addresses; // making it private for security reasons
    mapping (address => mapping(address =>string)) private aliases;


    /* get list of addresses saved by the caller of the function*/
    function getAddresses() public view returns (address[] memory) {
        return addresses[msg.sender];
    }

    function addAddress(address addr, string memory alia) public {
        addresses[msg.sender].push(addr);
        aliases[msg.sender][addr] = alia; 
    }

    function removeAddress(address addr) public {
        uint length = addresses[msg.sender].length;
        for (uint i = 0; i < length; i++) {
            if (addr == addresses[msg.sender][i]) {
                if (addresses[msg.sender].length > 1 && i < length - 1) {
                    addresses[msg.sender][i] = addresses[msg.sender][length - 1];
                }

                delete addresses[msg.sender][length - 1];
                delete aliases[msg.sender][addr];
                break; 
            }
        }
    }

    function getAlias(address addr) public view returns (string memory) {
        return aliases[msg.sender][addr];
    }
}