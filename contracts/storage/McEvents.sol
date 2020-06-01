pragma solidity ^0.5.16;

import "./McObjects.sol";


contract McEvents {

    event JoinPool(
        address indexed userWhoDeposited, 
        address depositedToken, 
        uint256 depositedAmount,
        uint256 totalDepositedDai
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
