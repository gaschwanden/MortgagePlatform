pragma solidity ^0.4.21;

contract Escrow {

    struct EscrowContract {
        address Borrower;
        address Arbiter;
        uint TotalAmount;
        uint CurAmount;
        uint StartTime;
        uint Duration;
        mapping (address=>uint) InvestedAmount;
    }


    EscrowContract[] escrows;

    mapping (uint=>EscrowContract) appIdtoEscrow;

    function init(address borrower, address arbiter, uint totalAmount, uint duration, address id) internal {
        escrows.push(EscrowContract(borrower, arbiter, totalAmount, 0, 0, duration));
    }

    function invest(uint appId) internal{
        EscrowContract escrow = appIdtoEscrow[appId];
        uint left = escrow.TotalAmount - escrow.CurAmount;
        if (msg.value > left) {
            uint invested = msg.value - left;
            escrow.InvestedAmount[msg.sender] += invested;
            escrow.CurAmount = escrow.TotalAmount;
            refundToBuyer(appId);
        }
    }

    function start(uint appId) private {
        EscrowContract escrow = appIdtoEscrow[appId];
        escrow.StartTime = now;

    }

    function refundToBuyer(uint amount) private {
        msg.sender.transfer(amount);
    }

    function getBalance() private returns (uint) {
        return this.balance;
    }
}