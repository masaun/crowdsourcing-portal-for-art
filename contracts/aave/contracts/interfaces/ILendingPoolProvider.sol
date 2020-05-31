pragma solidity 0.5.16;

interface ILendingPoolProvider {
    function getLendingPool() external view returns (address);
    function getLendingPoolCore() external view returns (address);
}
