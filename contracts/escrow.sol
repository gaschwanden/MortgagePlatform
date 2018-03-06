pragma solidity ^0.4.17;

contract Escrow {
    address public buyer;
    address public seller;
    address public arbiter;

    function Escrow(address _seller, address _arbiter) {
        buyer = msg.sender;
        seller = _seller;
        arbiter = _arbiter;
    }

    function payoutToSeller() {
        if(msg.sender == buyer || msg.sender == arbiter) {
            if(!seller.send(this.balance)) throw;
        }
    }

    function refundToBuyer() {
        if(msg.sender == seller || msg.sender == arbiter) {
            if(!buyer.send(this.balance)) throw;
        }
    }

      function getBalance() constant returns (uint) {
        return this.balance;
    }
}