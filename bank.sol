// "BANK" CHILD CONTRACT //

import "./Destroyable.sol";

pragma solidity 0.7.5;

interface GovernmentInterface{
    function addTransaction(address _from, address _to, uint _amount) external;
}
