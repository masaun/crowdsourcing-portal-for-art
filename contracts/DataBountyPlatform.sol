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
        uint newArtWorkId = artWorkId++;
        //uint newArtWorkId = artWorkId.add(1);

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
        // Can only vote if they joined a previous iteration round...
        // Check if the msg.sender has given approval rights to our steward to vote on their behalf
        uint currentArtWork = usersNominatedProject[artWorkIteration][msg.sender];
        if (currentArtWork != 0) {
            artWorkVotes[artWorkIteration][currentArtWork] = artWorkVotes[artWorkIteration][currentArtWork].sub(depositedDai[msg.sender]);
        }

        artWorkVotes[artWorkIteration][artWorkIdToVoteFor] = artWorkVotes[artWorkIteration][artWorkIdToVoteFor].add(depositedDai[msg.sender]);

        usersNominatedProject[artWorkIteration][msg.sender] = artWorkIdToVoteFor;

        uint topProjectVotes = artWorkVotes[artWorkIteration][topProject[artWorkIteration]];

        // TODO:: if they are equal there is a problem (we must handle this!!)
        if (artWorkVotes[artWorkIteration][artWorkId] > topProjectVotes) {
            topProject[artWorkIteration] = artWorkId;
        }
    }

    /***
     * @notice - Distribute fund into selected ArtWork by voting)
     **/
    function distributeFunds() public onlyAdmin(admin) {
        // On a *whatever we decide basis* the funds are distributed to the winning project
        // E.g. every 2 weeks, the project with the most votes gets the generated interest.
        require(artWorkDeadline < now, "current vote still active");

        if (topProject[artWorkIteration] != 0) {
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

        /// Set next voting deadline
        artWorkDeadline = artWorkDeadline.add(votingInterval);

        artWorkIteration = artWorkIteration.add(1);
        topProject[artWorkIteration] = 0;

        emit DistributeFunds(redeemedAmount, principalBalance, currentInterestIncome);
    }


    /***
     * @notice - Get balance
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
    }

}
