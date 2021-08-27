// MULTI SIGNATURE WALLET ASSIGNMENT //

// ASSIGNMENT:
// 1) Anyone should be able to deposit ether into smart contract
// 2) Only the owner of the contract should be able to input: 
//  (A)the addresses of the owners; 
//  (B)the numbers of approvals required for a transfer, put this in the constructor; So basically need to require 2/3 signatures for outgoing transactions to be approved
// 3) Anyone of the owners should be able to create a transfer request. The creator of the transfer request will specify what amount and to what address the transfer will be made.
// 4) Owners should be able to approve transfer requests.
// 5) When a transfer request has the required approvals, the transfer should be sent. 

pragma solidity 0.7.5;

contract Permissions {
        
        //Variable to hold contract creator
    address private creator;
    
        //Constructor to set contract creator and give them owner permissions
    constructor(){
        creator = msg.sender;
        owners[creator] = true;
    }
    
        //mapping to remember what addresses actually have owner permissions
    mapping(address => bool) private owners;
    
        //variable to set how many approval votes are needed for transactions to be approved
    uint votesNeeded = 2;
    
        //Modifier set creator permissions
     modifier onlyCreator{
        require(msg.sender == creator, "Not contract creator, permission denied");
        _;
    }
        
        //Modifier set creator & owner permissions
    modifier onlyOwners{
        require(msg.sender == creator || owners[msg.sender] == true, "Not authorized owner, permission denied");
        _;
    }
    
        //Events for adding or removing owners
    event ownerAdded (address NewOwner);
    event ownerRemoved (address RemovedOwner);
        
        //Function that allows the contract creator to assign owner status to other addresses and throws if owner has already been added
    function addOwner(address _owner) public onlyCreator {
        require(owners[_owner] == false, "Owner already added");
        owners[_owner] = true;
        emit ownerAdded(_owner);
    }

        //Function that allows the contract creator to revoke owner status from other addresses
    function removeOwner(address _owner) public onlyCreator {
        owners[_owner] = false;
        emit ownerRemoved(_owner);
    }
    
}
