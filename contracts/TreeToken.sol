// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract TreeToken is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private idCounter;
    address public owner;

    event Plant(uint256 indexed tokenId, address indexed planter, uint256 tokenIndex);

    struct Coordinate{
        string latitute;
        string longitute;
    }

    struct Tree {
        uint256 id;
        string name;
        Coordinate location;
        address planter;
        uint256 plantTime;
    }

    Tree[] public trees;

    constructor() ERC721("TreeToken", "TT") {
        owner = msg.sender;
    }

    
    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner can operate.");
        _;
    }

    function plant_tree(
        address planter,
        string memory name,
        string memory latitute,
        string memory longitute
    ) public onlyOwner {
        uint256 tree_id = idCounter.current();
        uint256 time = block.timestamp;
        uint256 index = trees.length;
        idCounter.increment();
        _mint(planter, tree_id);
        Coordinate memory coordinate = Coordinate({
            latitute: latitute,
            longitute: longitute
        });
        Tree memory tree = Tree({
            id: tree_id,
            name: name,
            location: coordinate,
            planter: planter,
            plantTime: time
        });
        trees.push(tree);
        emit Plant(tree_id, planter, index);
    }

}