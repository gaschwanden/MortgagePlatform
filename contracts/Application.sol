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
        uint Duration;      //second
        uint Interests;     // %%
        uint RepayedAmount;
        AppStatus Status;
        address[] InvestedAddress;
        mapping (address=>uint) InvestedAmount;
    }

    Application[] internal applications;

   function apply(address applicant, uint[] docs, uint totalAmount, uint createdTime, uint duration, uint interests) internal {
       Application memory app;
       app.Applicant = applicant;
       app.Docs = docs;
       app.TotalAmount = totalAmount;
       app.CreatedTime = createdTime;
       app.Duration = duration;
       app.Interests = interests;
       app.Status = AppStatus.Funding;
       applications.push(app);
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