// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./TreeToken.sol";

contract TokenFactory {
    mapping(address=>mapping(string=>TreeToken)) public contracts;
    address public owner;
    uint256 fee;
    
    constructor(uint256 fee_){
        owner = msg.sender;
        fee = fee_;
    }
    
    function deployContract(string memory contract_name) public payable {
        require(msg.value >= fee, "Not enought fee");
        contracts[msg.sender][contract_name] = new TreeToken();
        if(msg.value > fee){
            payable(owner).transfer(msg.value - fee);
        }
    }

    function withdrawFee() public payable{
        require(msg.sender == owner, "Only owner can withdraw fee.");
        payable(owner).transfer(address(this).balance);
    }
    
}