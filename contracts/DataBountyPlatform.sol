pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

// Use original Ownable.sol
import "./lib/OwnableOriginal.sol";

// Storage
import "./storage/McStorage.sol";
import "./storage/McConstants.sol";

// idle.finance v3

import "./idle-contracts-v3/contracts/interfaces/IIdleTokenV3.sol";



/***
 * @notice - This contract is that ...
 **/
contract DataBountyPlatform is OwnableOriginal(msg.sender), McStorage, McConstants {
    using SafeMath for uint;

    IERC20 public dai;
    IIdleTokenV3 public idleTokenV3;

    constructor(address daiAddress) public {
        dai = IERC20(daiAddress);
        
    }

    /***
     * @notice - Join Pool (Deposit DAI into idle-contracts-v3) for getting right of voting
     **/
    function joinPool() public returns (bool) {
        
    }
    


    /***
     * @notice - Get balance
     **/
    function balanceOfContract() public view returns (uint balanceOfContract_DAI, uint balanceOfContract_ETH) {
        return (dai.balanceOf(address(this)), address(this).balance);
    }

}
