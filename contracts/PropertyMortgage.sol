pragma solidity ^0.4.21;

import "./UserRegistration.sol";
import "./DocRegistration.sol";

contract PropertyMortgage is UserRegistration, Document {


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

    function getDocs() public onlyOwner view returns(Document) {
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

    
}