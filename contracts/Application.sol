pragma solidity ^0.4.21;

import "./Escrow.sol";
import "./DocRegistration.sol";

contract Application is Escrow{

    Form[] applications;

    enum AppStatus {WaitforVerify, WaitForInvest, InProgress, Finished}

    struct Form {
        address Applicant;
        uint[] Docs;
        uint TotalAmount;
        uint Interests;
        AppStatus Status;
    }

    mapping(uint =>address) appToOwner;
    mapping(address => uint) ownerAppCount;
    mapping(uint => uint) appToEscrow;

    function apply(uint[] docs, uint totalAmount, uint interests) internal {
        uint id = applications.push(Form(msg.sender, docs, totalAmount, interests, AppStatus.WaitforVerify));
        appToOwner[id] = msg.sender;
        ownerAppCount[msg.sender]++;
    }

    function applicationVerify(uint appId) internal {
        applications[appId].Status = AppStatus.WaitForInvest;
        
    }

}