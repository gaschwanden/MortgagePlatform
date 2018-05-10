pragma solidity ^0.4.21;

import "./UserRegistration.sol";
import "./DocRegistration.sol";
import "./Application.sol";

contract PropertyMortgage is UserRegistration, DocRegistration, Application {


    function UserRegister(UserType usertype) public {
        userRegister(usertype);
    }

    function UserVerify(address user) public {
        User memory verifier = Users[msg.sender];
        require(verifier.Type == UserType.Verifier);
        userVerify(user);
    }

    function DocRegister(DocType doctype, string source) public {
        docRegister(doctype, source);
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

    function Apply(uint[] docs, uint totalAmount, uint interests) public {
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