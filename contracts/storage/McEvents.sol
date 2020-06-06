pragma solidity ^0.5.16;

import "./McObjects.sol";


contract McEvents {

    event JoinPool(
        address indexed userWhoDeposited, 
        address depositedToken, 
        uint depositedAmount,
        uint totalDepositedDai
    );

    event CreateArtWork(
        uint indexed newArtWorkId, 
        address artWorkOwner,
        McObjects.ArtWorkState artWorkState,
        string artWorkHash
    );

    event VoteForArtWork(
        uint artWorkVotes,      // For calculate deposited amount of each artworkId
        uint artworkVoteCount,  // For counting vote of each artworkId
        uint topProjectVoteCount,
        uint[] topProjectArtWorkIds
    );

    event DistributeFunds(
        uint redeemedAmount, 
        uint principalBalance, 
        uint currentInterestIncome
    );
    
    event InitializeAfterDistributeFunds(
        uint[] topProjectArtWorkIds,
        uint topProjectVoteCount
    );
    
    


    /***
     * @dev - Example
     **/
    event Example(
        uint256 indexed Id, 
        uint256 exchangeRateCurrent,
        address msgSender,
        uint256 approvedValue    
    );

}
