pragma solidity ^0.4.21;

import "./UserRegistration.sol";
import "./DocRegistration.sol";
import "./Application.sol";
import "./Ownable.sol";

contract HomeMortgage is UserRegistration, DocRegistration, Application, Ownable {

    mapping(address => uint) ownerAppCount;
    mapping(uint =>address) appToOwner;

    function UserRegister(string name, UserType usertype) public returns (bool) {
        if (Users[msg.sender].Verified == true) {
            return false;
        }
        userRegister(name, usertype);
        return true;
    }

    function GetUser() public pure returns (string) {
        
    }

    function UserVerify(address user) public onlyOwner {
        User memory verifier = Users[msg.sender];
        require(verifier.Type == UserType.Verifier);
        userVerify(user);
    }

    function DocRegister(string name, uint curTime, DocType doctype, string source) public {
        docRegister(name, curTime, doctype, source);
    }

    function DocVerify(uint docId) public {
        require(Users[msg.sender].Type == UserType.Verifier);
        docVerify(docId);
        
    }

    function GetDocs(address uid) public view returns(uint[]) {
        uint[] memory result = new uint[](ownerDocCount[msg.sender]);
        uint counter = 0;
        for (uint i = 0; i < documents.length; i++) {
            if (docToOwner[i] == uid) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    function GetDoc(uint id) public view returns(string, uint, uint, string, bool) {
        Document memory doc = documents[id];
        return (doc.Name, doc.TimeStamp, uint(doc.Type), doc.SourceUrl, doc.Verified);
    }

    function GetDangerousApplications() public view returns(uint[]) {

    }

    //Get all applications that are still funding
    function GetAvailableApplications() public view returns(uint[]) {
        uint[] memory result = new uint[](ownerAppCount[msg.sender]);
        uint counter = 0;
        for (uint j = 0; j < applications.length; j++) {
            if(applications[j].Status == AppStatus.Funding && appToOwner[j] != msg.sender) {
                result[j] = j;
            }
        return result;
        }
    }

    //Get all applications of a user
    function GetApplications(address uid) public view returns(uint[]) {
        uint[] memory result = new uint[](ownerAppCount[msg.sender]);
        uint counter = 0;
        for (uint i = 0; i < applications.length; i++) {
            if (appToOwner[i] == uid) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    function GetApplication(uint id) public view returns(address, uint[], uint, uint, uint,uint, uint, uint, uint, address[]) {
        Application memory app = applications[id];
        return (app.Applicant, app.Docs, app.TotalAmount, app.CurAmount,
        app.CreatedTime, app.StartTime, app.Duration, app.Interests, uint(app.Status), app.InvestedAddress);
    }

    function Apply(uint[] docs, uint totalAmount, uint curTime, uint duration, uint interests) public {
        uint id = apply(msg.sender, docs, totalAmount, curTime, duration, interests);
        ownerAppCount[msg.sender]++;
        appToOwner[id] = msg.sender;
    }

    function Invest(uint appId, uint curTime) public payable {
        Application storage app = applications[appId];
        if(app.Status == AppStatus.Funding) {
            if (curTime - app.StartTime > app.Duration) {
                app.Status = AppStatus.Failed;
                refundToBuyer(msg.value, msg.sender);
            }
            else {
                invest(app, msg.value, curTime);
            }
        }
    }

    //Only owner of the contract can fail an application because of out of time.
    function FailApplication(uint appId) public onlyOwner {
        Application storage app = applications[appId];
        app.Status = AppStatus.Failed;
        for (uint i = 0; i < app.InvestedAddress.length; i++) {
                refundToBuyer(app.InvestedAmount[app.InvestedAddress[i]], app.InvestedAddress[i]);
            }
    }

    function RepossessProperty(uint appId) public onlyOwner {
        Application storage app = applications[appId];
        app.Status = AppStatus.Repossessed;
    }

    function Repay(uint appId) public payable {
        Application storage app = applications[appId];
        if (app.Applicant == msg.sender) {

        }
    }

    function refundToBuyer(uint amount, address to) private {
        to.transfer(amount);
    }
    
}