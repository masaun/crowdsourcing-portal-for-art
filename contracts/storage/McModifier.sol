pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import "./McStorage.sol";


contract McModifier is McStorage {

    modifier onlyAdmin(address setAdminAddress) {
        require(setAdminAddress == admin, "Not admin");
        //require(msg.sender == admin, "Not admin");
        _;
    }

}
