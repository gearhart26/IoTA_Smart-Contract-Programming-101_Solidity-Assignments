// DATA LOCATION ASSIGNMENT //

// Find what is wrong with this codes data location settings in the function. 
// Need to find what is causing the updateBalance function to malfunction

pragma solidity 0.7.5;
contract MemoryAndStorage {

    mapping(uint => User) users;

    struct User{
        uint id;
        uint balance;
    }

    function addUser(uint id, uint balance) public {
        users[id] = User(id, balance);
    }

    function updateBalance(uint id, uint balance) public {
         //User memory user = users[id];  <= old code
         //user.balance = balance;        <= old code 
         
         //One solution is to change memory to storage 
         //Below is instructor comments on my submission explaining whats happening here much better than I could
         
         //"This assignes users[id] to a local storage variable which allows us to create a local “pointer” called user"
         //"This points to (references) the User instance in the mapping which is mapped to the id parameter input into the function"
         //"Any value assigned to this local “pointer” variable is effectively updating the instance stored persistently in the mapping."
         //"The local variable user creates a temporary “bridge” to the mapping during execution of the function, so that the amount ( balance ) can be added to a specific user’s balance stored persistently in the mapping, before this “bridge” is lost when the function finishes executing."
         User storage user = users[id];   // new code
         user.balance = balance;
         
         //The other solution shown was to replace the two previous lines of code with this one line that accomplishes the same thing
         //users[id].balance = balance;
    }

    function getBalance(uint id) view public returns (uint) {
        return users[id].balance;
    }

}
