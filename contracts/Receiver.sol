// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This contract is used to test the TreeToken contact.

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

interface MyTreeToken {
    function transferFrom(address from, address to, uint256 tokenId) external;
}

contract Receiver is IERC721Receiver {
    MyTreeToken public testedContract;
    address public operator_;
    address public from_;
    uint256 public tokenId_;
    bytes public data_;

    constructor(MyTreeToken _testedContract){
        testedContract = _testedContract;
    }

    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external override returns (bytes4){
        operator_ = operator;
        from_ = from;
        tokenId_ = tokenId;
        data_ = data;
        return this.onERC721Received.selector;
    }

    function burn() public payable{
        testedContract.transferFrom(address(this), from_, tokenId_);
        selfdestruct(payable(msg.sender));
    }
 

}