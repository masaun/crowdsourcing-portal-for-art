pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import "./McObjects.sol";
import "./McEvents.sol";


// shared storage
contract McStorage is McObjects, McEvents {

    ///////////////////////////////////
    // @dev - Define as memory
    ///////////////////////////////////
    uint256 artWorkId;

    
    //////////////////////////////////
    // @dev - Define as storage
    ///////////////////////////////////
    mapping (address => uint) depositedDai;

    mapping(uint256 => address) public artWorkOwner;
    mapping(uint256 => string) public artWorkDetails;
    mapping(uint256 => ArtWorkState) public artWorkState; // Artwork Id to current state

}
