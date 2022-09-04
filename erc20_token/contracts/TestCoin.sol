// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";

interface ERC20 {
    function totalSupply() external pure returns (uint256); 
    function balanceOf(address _owner) external view returns (uint256 balance);
    function transfer(address _to, uint256 value) external returns (bool success);
    function approve(address _spender, uint256 _value) external returns (bool success);
    function allowance(address _owner, address _spender) external view returns (uint256);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
}


contract TestCoin is ERC20 {
    string public constant symbol = "TCN";
    string public constant name = "TestCoin"; 
    uint8 public constant decimals = 18; 
    uint256 public constant total = 1000000000000000000;
    address public owner; 
    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) public approvals; 

    event Transfer(address indexed _to, address indexed _from, uint256 _amount); 
    event Approval(address indexed _owner, address indexed _spender, uint256 _value); 

    constructor() payable {
        owner = msg.sender;
    }

    function getOwner() public view returns (address) {
        return owner; 
    }


    function totalSupply() public pure returns (uint256) {
        return total;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 value) public returns (bool success) {
        uint256 caller_balance = balances[msg.sender];
        require(caller_balance >= value);
        balances[msg.sender] = balances[msg.sender] - value;
        balances[_to] = balances[_to] + value; 

        emit Transfer(_to, msg.sender, value);

        success = true;
        return (success);
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        approvals[msg.sender][_spender] = _value; 
        success = true; 
        emit Approval(msg.sender, _spender, _value); 
        return success; 
    }

    function allowance(address _owner, address _spender) public view returns (uint256) {
        return approvals[_owner][_spender]; 
    }

    function isContract (address _addr) private view returns (bool) {
        uint codeSize;

        assembly {
            codeSize := extcodesize(_addr)
        }
        return codeSize > 0;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        if (approvals[_from][msg.sender] > 0 && 
        _value > 0 && 
        approvals[_from][msg.sender] >= _value && 
        !isContract(_to)) {
            balances[_from] -= _value; 
            balances[_to] += _value; 
            success = true; 
            emit Transfer(_to, _from, _value); 
        }
        return success; 
    }
}