pragma solidity 0.7.5;
    
    contract Government {
        
        struct Transaction {
            address from;
            address to;
            uint amount;
            uint txId;
        }
        
        Transaction[] transactionLog;
    
        event transactionLogged (address sentFrom, address sentTo, uint amount, uint transactionId);
        
        function addTransaction(address _from, address _to, uint _amount) external {
                //Creating a new Transaction object saving it to a variable and push the variable directly into out transactionLog
            transactionLog.push( Transaction(_from, _to, _amount, transactionLog.length) );
            emit transactionLogged(_from, _to, _amount, transactionLog.length);
        }
        
        function getTransaction(uint _index) public view returns(address, address, uint) {
            return (transactionLog[_index].from, transactionLog[_index].to, transactionLog[_index].amount);
        }
    }
