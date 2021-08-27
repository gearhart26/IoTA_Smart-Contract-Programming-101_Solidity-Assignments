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
