pragma solidity ^0.4.21;

import "./UserRegistration.sol";
import "./DocRegistration.sol";
import "./Application.sol";

contract PropertyMortgage is UserRegistration, Document, Application {


    function UserRegister(UserType usertype) public {
        userRegister(userType);
    }

    function UserVerify(address user) public {
        User memory verifier = Users[msg.sender];
        require(verifier.Type == UserType.Verifier);
        userVerify(user);
    }

    function DocRegister(DocType doctype, string source) public {
        docRegister(msg.sender, doctype, source);
    }

    function DocVerify(uint userId, uint docId) public {
        require(Users[userId].Type == UserType.Verifier);
        docVerify(docId);
        
    }

    function GetDocs() public view returns(Document[]) {
        Document[] memory result = new Document[](ownerDocCount[msg.sender]);
        uint counter = 0;
        for (uint i = 0; i < documents.length; i++) {
            if (docToOwner[i] == msg.sender) {
                result[counter] = documents[i];
                counter++;
            }
        }
        return result;
    }

    function Apply(uint[] docs, uint totalMoney, uint interests) public {
        require(checkQualification(docs));
        apply(docs, totalAmount, interests);
    }

    function checkQualification(uint[] docs) private view returns (bool) {
        Document doc;
        bool idChecked = false;
        bool financialChecked = false;
        bool propertyChecked = false;

        for (uint i = 0; i < docs.length; i++) {
            doc = documents[docs[i]];
            if (!doc.verified) {
                return false;
            }
            if(doc.DocType == DocType.Id){
                idChecked = true;
            }
            if(doc.DocType == DocType.Financial){
                financialChecked = true;
            }
            if(doc.DocType == DocType.Property){
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