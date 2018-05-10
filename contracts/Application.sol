pragma solidity ^0.4.21;

import "./Escrow.sol";
import "./DocRegistration.sol";

contract Application {

    Form[] applications;

    enum AppStatus {WaitforVerify, WaitForInvest, InProgress, Finished}

    struct Form {
        address Applicant;
        uint[] Docs;
        uint TotalAmount;
        uint Interests;
        AppStatus Status;
    }

    function apply(uint[] docs, uint totalAmount, uint interests) internal {
        applications.push(Form(msg.sender, docs, totalAmount, interests, AppStatus.WaitforVerify));
        
    }



}