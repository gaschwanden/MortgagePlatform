pragma solidity ^0.4.21;

import "./UserRegistration.sol";
import "./DocRegistration.sol";
import "./Application.sol";

contract HomeMortgage is UserRegistration, DocRegistration {

    Application[] public Applications;
    mapping(address => uint) ownerAppCount;
    mapping(uint =>address) appToOwner;

    function UserRegister(string name, UserType usertype) public {
        userRegister(name, usertype);
    }

    function UserVerify(address user) public onlyOwner {
        User memory verifier = Users[msg.sender];
        require(verifier.Type == UserType.Verifier);
        userVerify(user);
    }

    function DocRegister(string name, DocType doctype, string source) public {
        docRegister(name, doctype, source);
    }

    function DocVerify(uint docId) public {
        require(Users[msg.sender].Type == UserType.Verifier);
        docVerify(docId);
        
    }

    function GetDocs() public view returns(uint[]) {
        uint[] memory result = new uint[](ownerDocCount[msg.sender]);
        uint counter = 0;
        for (uint i = 0; i < documents.length; i++) {
            if (docToOwner[i] == msg.sender) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    function GetApplications() public view returns(uint[]) {
        uint[] memory result = new uint[](ownerAppCount[msg.sender]);
        uint counter = 0;
        for (uint i = 0; i < Applications.length; i++) {
            if (appToOwner[i] == msg.sender) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    function Apply(uint[] docs, uint totalAmount, uint duration, uint interests) public {
        require(checkQualification(docs));
        Application app = new Application(msg.sender, docs, totalAmount, duration, interests);
        Applications.push(app);
    }



    function checkQualification(uint[] docs) private view returns (bool) {
        Document memory doc;
        bool idChecked = false;
        bool financialChecked = false;
        bool propertyChecked = false;

        for (uint i = 0; i < docs.length; i++) {
            doc = documents[docs[i]];
            if (!doc.Verified) {
                return false;
            }
            if(doc.Type == DocType.Id){
                idChecked = true;
            }
            if(doc.Type == DocType.Financial){
                financialChecked = true;
            }
            if(doc.Type == DocType.Property){
                propertyChecked = true;
            }
        }
        if (idChecked && financialChecked && propertyChecked) {
            return true;
        }
        else {
            return false;
        }
    }
    
}