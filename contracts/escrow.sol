pragma solidity ^0.4.21;

contract Escrow {

    address Borrower;
    uint TotalAmount;
    uint CurAmount;
    uint StartTime;
    uint Duration;
    uint Interests;
    mapping (address=>uint) InvestedAmount;

    constructor (address borrower, uint totalAmount, uint duration, uint interests) public {
        Borrower = borrower;
        TotalAmount = totalAmount;
        CurAmount = 0;
        StartTime = 0;
        Duration = duration;
    }

    function invest() internal {
        uint left = TotalAmount - CurAmount;
        if (msg.value > left) {
            uint invested = msg.value - left;
            InvestedAmount[msg.sender] += invested;
            CurAmount = TotalAmount;
            refundToBuyer(left);
        }
    }

    function start(uint appId) private {
        StartTime = now;

    }

    function refundToBuyer(uint amount) private {
        msg.sender.transfer(amount);
    }

    function getBalance() private returns (uint) {
        return this.balance;
    }
}