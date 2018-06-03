pragma solidity ^0.4.21;


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
       app.RepayedAmount = 0;
       app.StartTime = 0;
       app.Interests = interests;
       app.Status = AppStatus.Funding;
       uint id = applications.push(app) - 1;
       return id;
    }

    function invest(Application storage app, uint amount, uint time) internal returns(uint) {
        bool invested = false;
        for (var i = 0; i < app.InvestedAddress.length; i++) {
            if (app.InvestedAddress[i] == msg.sender) {
                invested = true;
                break;
            }
        }
        if (!invested) {
            app.InvestedAddress.push(msg.sender);
        }
        uint left = app.TotalAmount - app.CurAmount;
        if (amount >= left) {
            app.CurAmount = app.TotalAmount;
            app.InvestedAmount[msg.sender] += left;
            app.Status = AppStatus.Repayment;
            app.StartTime = time;
            return amount - left;
        }
        else {
            app.CurAmount += amount;
            app.InvestedAmount[msg.sender] += amount;
            return 0;
        }
    }

    function repay(Application storage app, uint amount) internal returns(bool, uint) {
        uint total = app.TotalAmount + app.TotalAmount*app.Interests/100;
        uint left = total - app.RepayedAmount;
        if (amount >= left) {
            app.RepayedAmount = total;
            app.Status = AppStatus.Redeemed;
            return (true, amount - left);
        }
        else {
            app.RepayedAmount += amount;
            return (false, 0);
        }
    }

}