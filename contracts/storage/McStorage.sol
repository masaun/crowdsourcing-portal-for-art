pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import "./McObjects.sol";
import "./McEvents.sol";


// shared storage
contract McStorage is McObjects, McEvents {

    ///////////////////////////////////
    // @dev - Define as variable
    ///////////////////////////////////
    address admin;

    uint totalDepositedDai;

    //uint artWorkId;
    uint artWorkVotingRound;

    uint votingInterval;
    uint artWorkDeadline;

    uint[] topProjectArtWorkIds;



    //////////////////////////////////
    // @dev - Define as mapping
    ///////////////////////////////////
    mapping (address => uint) depositedDai;

    mapping(uint256 => address) public artWorkOwner;
    mapping(uint256 => string) public artWorkDetails;
    mapping(uint256 => ArtWorkState) public artWorkState; // Artwork Id to current state

    mapping(uint256 => mapping(address => uint256)) public usersNominatedProject; // Means user can only have one project.
    mapping(uint256 => mapping(uint256 => uint256)) public artWorkVotes;          // For calculate deposited amount of each artworkId
    mapping(uint256 => uint256) public topProject;

    mapping(uint256 => mapping(uint256 => uint256)) public artworkVoteCount;  // For counting vote of each artworkId
}
