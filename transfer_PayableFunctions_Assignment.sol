// TRANSFER _ PAYABLE FUNCTIONS //
//reusing code from PayableFunctions

pragma solidity 0.7.5;
    
    contract Bank_TransferFunctionExample{
        
        mapping(address => uint) balance;
        
        address owner;

        event depositDone (uint amount, address depositedTo);
        
        event balanceTransfered (address transferedFrom, uint amount, address transferedTo);
        
        modifier onlyOwner{
            require(msg.sender == owner);
            _;
        }
        
        constructor(){
            owner = msg.sender;
        }
        
        function deposit() public payable returns (uint) {
            balance[msg.sender] += msg.value; 
            emit depositDone(msg.value, msg.sender);
            return balance[msg.sender];
        }
        
//New code here; new withdraw function
        //Adding a require() condition, user balance update BRFORE withdrawl is carried out for security, and a return statement to return users reduced balance after withdrawl
        //This prevents someone from withdrawing someone elses deposits
        function withdraw(uint amount) public returns (uint) {
            require(balance[msg.sender] >= amount);
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
            assert(balance[msg.sender] == previousSenderBalance - amount);
            emit balanceTransfered(msg.sender, amount, recipient);
        }
        
        function _transfer(address from, address to, uint amount) private {
            balance[from] -= amount;
            balance[to] += amount;
        }
    }
