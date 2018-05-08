pragma solidity ^0.4.21;

import "./Escrow.sol";
import "./DocRegistration.sol";

contract Application {

    Form[] apllications;

    enum Status {WaitforVerify, WaitForInvest, InProgress, Finished}

    struct Form {
        address Applicant;
        uint[] Docs;
        uint TotalAmount;
        uint Interests;
        Status Status;
    }

    function apply(uint[] docs, uint totalAmount, uint interests) internal {
        applications.push(Form(msg.sender, docs, totalAmout, interests));
        
    }



}