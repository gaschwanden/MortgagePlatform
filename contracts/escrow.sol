pragma solidity ^0.4.21;

import "./Document.sol";

contract Escrow {
    address public buyer;
    address public seller;
    address public arbiter;

    mapping (uint=>bool) documents_verified;

    function Escrow(address _seller, address _arbiter) public {
        buyer = msg.sender;
        seller = _seller;
        arbiter = _arbiter;
    }

    function payoutToSeller() private {
        if(msg.sender == buyer || msg.sender == arbiter) {
            if(!seller.send(this.balance)) throw;
        }
    }

    function refundToBuyer() private{
        if(msg.sender == seller || msg.sender == arbiter) {
            if(!buyer.send(this.balance)) throw;
        }
    }

    function getBalance() private returns (uint) {
        return this.balance;
    }
}