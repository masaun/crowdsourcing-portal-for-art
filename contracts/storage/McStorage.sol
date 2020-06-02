pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import "./McObjects.sol";
import "./McEvents.sol";


// shared storage
contract McStorage is McObjects, McEvents {

    ///////////////////////////////////
    // @dev - Define as memory
    ///////////////////////////////////
    uint artWorkId;
    uint artWorkIteration;
    

    //////////////////////////////////
    // @dev - Define as storage
    ///////////////////////////////////
    mapping (address => uint) depositedDai;

    mapping(uint256 => address) public artWorkOwner;
    mapping(uint256 => string) public artWorkDetails;
    mapping(uint256 => ArtWorkState) public artWorkState; // Artwork Id to current state

    mapping(uint256 => mapping(address => uint256)) public usersNominatedProject; // Means user can only have one project.
    mapping(uint256 => mapping(uint256 => uint256)) public artWorkVotes;
    mapping(uint256 => uint256) public topProject;
}
