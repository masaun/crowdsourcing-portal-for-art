pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

// Use original Ownable.sol
import "./lib/OwnableOriginal.sol";

// Storage
import "./storage/McModifier.sol";  /// McStorage.sol is inherited
import "./storage/McConstants.sol";

// idle.finance v3
//import "./idle-contracts-v3/contracts/interfaces/IIdleTokenV3.sol";

// AAVE
import "./aave/contracts/interfaces/ILendingPool.sol";
import "./aave/contracts/interfaces/ILendingPoolCore.sol";
import "./aave/contracts/interfaces/ILendingPoolAddressesProvider.sol";
import "./aave/contracts/interfaces/IAToken.sol";


/***
 * @notice - This contract is that ...
 **/
contract DataBountyPlatform is OwnableOriginal(msg.sender), McModifier, McConstants {
    using SafeMath for uint;

    IERC20 public dai;
    ILendingPool public lendingPool;
    ILendingPoolCore public lendingPoolCore;
    ILendingPoolAddressesProvider public lendingPoolAddressesProvider;
    IAToken public aDai;

    constructor(address daiAddress, address _lendingPool, address _lendingPoolCore, address _lendingPoolAddressesProvider, address _aDai) public {
        admin = address(this);  /// Temporary
        //admin = msg.sender;

        dai = IERC20(daiAddress);
        lendingPool = ILendingPool(_lendingPool);
        lendingPoolCore = ILendingPoolCore(_lendingPoolCore);
        lendingPoolAddressesProvider = ILendingPoolAddressesProvider(_lendingPoolAddressesProvider);
        aDai = IAToken(_aDai);

        /// every 1 weeks, voting deadline is updated
        votingInterval = 10;         /// For testing (Every 10 second, voting deadline is updated)
        //votingInterval = 1 weeks;  /// For actual 
        artWorkDeadline = now.add(votingInterval);
    }


    /***
     * @notice - Join Pool (Deposit DAI into idle-contracts-v3) for getting right of voting
     **/
    function joinPool(address _reserve, uint256 _amount, uint16 _referralCode) public returns (bool) {
        /// Transfer from wallet address
        dai.transferFrom(msg.sender, address(this), _amount);

        /// Approve LendingPool contract to move your DAI
        dai.approve(lendingPoolAddressesProvider.getLendingPoolCore(), _amount);

        /// Deposit DAI
        lendingPool.deposit(_reserve, _amount, _referralCode);

        /// Save deposited amount each user
        depositedDai[msg.sender] = _amount;
        totalDepositedDai.add(_amount);
        emit JoinPool(msg.sender, _reserve, _amount, totalDepositedDai);
    }

    /***
     * @notice - Create artwork and list them.
     * @return - New artwork id
     **/
    function createArtWork(string memory artWorkHash) public returns (uint newArtWorkId) {
        // The first artwork will have an ID of 1
        uint newArtWorkId = artWorkId.add(1);

        artWorkOwner[newArtWorkId] = msg.sender;
        artWorkState[newArtWorkId] = ArtWorkState.Active;
        artWorkDetails[newArtWorkId] = artWorkHash;

        emit CreateArtWork(newArtWorkId, 
                           artWorkOwner[newArtWorkId], 
                           artWorkState[newArtWorkId], 
                           artWorkDetails[newArtWorkId]);
    }
    
    
    /***
     * @notice - Vote for selecting the best artwork (voter is only user who deposited before)
     **/
    function voteForArtWork(uint256 artWorkIdToVoteFor) public {
        /// Can only vote if they joined a previous iteration round...
        /// Check if the msg.sender has given approval rights to our steward to vote on their behalf
        uint currentArtWork = usersNominatedProject[artWorkVotingRound][msg.sender];
        if (currentArtWork != 0) {
            artWorkVotes[artWorkVotingRound][currentArtWork] = artWorkVotes[artWorkVotingRound][currentArtWork].sub(depositedDai[msg.sender]);
        }

        /// "artWorkVotingRound" is what number of voting round are.
        /// Save what voting round is / who user voted for / how much user deposited
        artWorkVotes[artWorkVotingRound][artWorkIdToVoteFor] = artWorkVotes[artWorkVotingRound][artWorkIdToVoteFor].add(depositedDai[msg.sender]);

        /// Save who user voted for  
        usersNominatedProject[artWorkVotingRound][msg.sender] = artWorkIdToVoteFor;

        /// Update voting count of voted artworkId
        artworkVoteCount[artWorkVotingRound][artWorkIdToVoteFor] = artworkVoteCount[artWorkVotingRound][artWorkIdToVoteFor].add(1);

        /// Update current top project (artwork)
        uint currentArtWorkId = artWorkId;
        uint topProjectVoteCount;
        for (uint i=0; i < currentArtWorkId; i++) {
            if (artworkVoteCount[artWorkVotingRound][i] >= topProjectVoteCount) {
                topProjectVoteCount = artworkVoteCount[artWorkVotingRound][i];
            } 
        }

        uint[] memory topProjectArtWorkIds;
        getTopProjectArtWorkIds(artWorkVotingRound, topProjectVoteCount);
        topProjectArtWorkIds = returnTopProjectArtWorkIds();

        // TODO:: if they are equal there is a problem (we must handle this!!)
        // if (artWorkVotes[artWorkVotingRound][artWorkId] > topProjectVotes) {
        //     topProject[artWorkVotingRound] = artWorkId;
        // }

        emit VoteForArtWork(artWorkVotes[artWorkVotingRound][artWorkIdToVoteFor],
                            artworkVoteCount[artWorkVotingRound][artWorkIdToVoteFor],
                            topProjectVoteCount,
                            returnTopProjectArtWorkIds());
    }

    /// Need to execute for-loop in frontend to get TopProjectArtWorkIds
    function getTopProjectArtWorkIds(uint _artWorkVotingRound, uint _topProjectVoteCount) public {
        uint currentArtWorkId = artWorkId;
        for (uint i=0; i < currentArtWorkId; i++) {
            if (artworkVoteCount[_artWorkVotingRound][i] == _topProjectVoteCount) {
                topProjectArtWorkIds.push(artworkVoteCount[artWorkVotingRound][i]);
            } 
        } 
    }

    function returnTopProjectArtWorkIds() public view returns(uint[] memory _topProjectArtWorkIdsMemory) {
        uint topProjectArtWorkIdsLength = topProjectArtWorkIds.length;

        uint[] memory topProjectArtWorkIdsMemory = new uint[](topProjectArtWorkIdsLength);
        topProjectArtWorkIdsMemory = topProjectArtWorkIds;
        return topProjectArtWorkIdsMemory;
    }
    
    


    /***
     * @notice - Distribute fund into selected ArtWork by voting)
     **/
    function distributeFunds(address _reserve, uint16 _referralCode) public onlyAdmin(admin) {
        // On a *whatever we decide basis* the funds are distributed to the winning project
        // E.g. every 2 weeks, the project with the most votes gets the generated interest.
        require(artWorkDeadline < now, "current vote still active");

        if (topProject[artWorkVotingRound] != 0) {
            // TODO: do the payout!

        }

        /// Redeem
        address _user = address(this);
        uint redeemAmount = aDai.balanceOf(_user);
        uint principalBalance = aDai.principalBalanceOf(_user);
        aDai.redeem(redeemAmount);

        /// Calculate current interest income
        uint redeemedAmount = dai.balanceOf(_user);
        uint currentInterestIncome = redeemedAmount - principalBalance;

        /// Count voting every ArtWork

        /// Select winning address
        address winningAddress;
        winningAddress = 0x8Fc9d07b1B9542A71C4ba1702Cd230E160af6EB3;  /// Wallet address for testing

        /// Transfer redeemed Interest income into winning address
        dai.approve(winningAddress, currentInterestIncome);
        dai.transfer(winningAddress, currentInterestIncome);

        /// Re-lending principal balance into AAVE
        dai.approve(lendingPoolAddressesProvider.getLendingPoolCore(), principalBalance);
        lendingPool.deposit(_reserve, principalBalance, _referralCode);        

        /// Set next voting deadline
        artWorkDeadline = artWorkDeadline.add(votingInterval);

        /// "artWorkVotingRound" is number of voting round
        /// Set next voting round
        /// Initialize the top project of next voting round
        artWorkVotingRound = artWorkVotingRound.add(1);
        topProject[artWorkVotingRound] = 0;

        emit DistributeFunds(redeemedAmount, principalBalance, currentInterestIncome);
    }


    /***
     * @notice - Getter Function
     **/
    function balanceOfContract() public view returns (uint balanceOfContract_DAI, uint balanceOfContract_ETH) {
        return (dai.balanceOf(address(this)), address(this).balance);
    }

    /***
     * @notice - Test Functions
     **/    
    function getAaveRelatedFunction() public view returns (uint redeemAmount, uint principalBalance) {
        /// Redeem
        address _user = address(this);
        uint redeemAmount = aDai.balanceOf(_user);
        uint principalBalance = aDai.principalBalanceOf(_user);

        return (redeemAmount, principalBalance);
    }

}
