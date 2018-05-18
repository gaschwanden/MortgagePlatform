pragma solidity ^0.4.21;

import "./Escrow.sol";
import "./DocRegistration.sol";

contract Application {

    
    enum AppStatus {WaitforVerify, WaitForInvest, InProgress, Finished}

    address public Applicant;
    uint[] public Docs;
    uint public TotalAmount;
    uint public Duration;
    uint public Interests;
    AppStatus public Status;
    Escrow public escrow;

    constructor(address applicant, uint[] docs, uint totalAmount, uint duration, uint interests) public {
        Applicant = applicant;
        Docs = docs;
        TotalAmount = totalAmount;
        Duration = duration;
        Interests = interests;
        Status = AppStatus.WaitforVerify;
        new Escrow(applicant, msg.sender, totalAmount, duration, interests);
    }

    function Invest() public {

    }

}