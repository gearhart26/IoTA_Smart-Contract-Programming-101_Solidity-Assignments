// "DESTROYABLE" CHILD CONTRACT //

import "./Ownable.sol";
    
pragma solidity 0.7.5;

    contract Destroyable is Ownable {
        
        function DESTROY() public onlyOwner {
            selfdestruct(msg.sender);
        }
    }
