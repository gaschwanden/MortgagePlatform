pragma solidity ^0.4.21;

import "./Escrow.sol";
import "./DocRegistration.sol";

//Also serve as escrow contract

contract Application {

    enum AppStatus {
        Funding,
        Failed,
        Repayment,
        Redeemed,
        Repossessed
    }

    struct Application {
        address Applicant;
        uint[] Docs;
        uint TotalAmount;   //wei
        uint CurAmount;     //wei
        uint CreatedTime;   //date.valueof()
        uint StartTime;     //
        uint Duration;      //second
        uint RepayDuration;  //second
        uint Interests;     // %%
        uint RepayedAmount;
        AppStatus Status;
        mapping (address=>uint) InvestedAmount;
        address[] InvestedAddress;
    }

    Application[] internal applications;

   function apply(address applicant, uint[] docs, uint totalAmount, uint startTime, uint duration, uint interests) internal {
       applications.push(Application(applicant, docs, totalAmount, 0, startTime, duration, interests, AppStatus.Funding));
    }

    function invest(Application app, uint amount) internal returns(uint) {
        app.CurAmount += amount;
        app.InvestedAmount[msg.sender] += amount;
        uint left = app.TotalAmount - app.CurAmount;
        if (left > 0) {
            app.Status = AppStatus.Repayment;
        }
    }

}