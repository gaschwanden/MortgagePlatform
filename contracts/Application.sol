pragma solidity ^0.4.21;

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
        uint FundingDuration;  //second
        uint RepayDuration;
        uint Interests;     // %
        uint RepayedAmount;
        AppStatus Status;
        address[] InvestedAddress;
        mapping (address=>uint) InvestedAmount;
    }

    Application[] internal applications;

   function apply(address applicant, uint[] docs, uint totalAmount, uint createdTime, uint fundingDuration, 
                    uint repayDuration, uint interests) internal returns(uint){
       Application memory app;
       app.Applicant = applicant;
       app.Docs = docs;
       app.TotalAmount = totalAmount;
       app.CreatedTime = createdTime;
       app.FundingDuration = fundingDuration;
       app.RepayDuration = repayDuration;
       app.Interests = interests;
       app.Status = AppStatus.Funding;
       uint id = applications.push(app) - 1;
       return id;
    }

    function invest(Application storage app, uint amount, uint time) internal returns(uint) {
        app.CurAmount += amount;
        app.InvestedAmount[msg.sender] += amount;
        uint left = app.TotalAmount - app.CurAmount;
        if (left > 0) {
            app.StartTime = time;
            app.Status = AppStatus.Repayment;
        }
    }

}