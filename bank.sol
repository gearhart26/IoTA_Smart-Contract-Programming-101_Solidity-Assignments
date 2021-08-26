// "BANK" CHILD CONTRACT //

import "./Destroyable.sol";

pragma solidity 0.7.5;

interface GovernmentInterface{
    function addTransaction(address _from, address _to, uint _amount) external;
}
        
    contract Bank is Destroyable {
        
        GovernmentInterface governmentInstance = GovernmentInterface(0x41c4c4e7ed7800e18B7CEEEF4Cb5d24BF315655A);
        
        mapping(address => uint) balance;
        
        event depositDone (uint amount, address depositedTo);
        
        event balanceTransfered (address transferedFrom, uint amount, address transferedTo);
        
        function deposit() public payable returns (uint) {
            balance[msg.sender] += msg.value; 
            emit depositDone(msg.value, msg.sender);
            return balance[msg.sender];
        }
        
        function withdraw(uint amount) public returns (uint) {
            require(balance[msg.sender] >= amount, "Insufficent Balance");
            balance[msg.sender] -= amount;
            msg.sender.transfer(amount);
            return balance[msg.sender];
       }
        
        function getBalance() public view returns (uint){
            return balance[msg.sender];
        }
        
        function transfer(address recipient, uint amount) public {
            require(balance[msg.sender] >= amount, "Insufficent Balance");
            require(msg.sender != recipient, "You cannot send funds to yourself");
            uint previousSenderBalance = balance[msg.sender];
            _transfer(msg.sender, recipient, amount);
             governmentInstance.addTransaction(msg.sender, recipient, amount);
            assert(balance[msg.sender] == previousSenderBalance - amount);
            emit balanceTransfered(msg.sender, amount, recipient);
        }
        
        function _transfer(address from, address to, uint amount) private {
            balance[from] -= amount;
            balance[to] += amount;
        }
    }
