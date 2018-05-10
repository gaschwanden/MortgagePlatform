pragma solidity ^0.4.21;

import "./ERC721BasicToken.sol";

contract DocRegistration{
    
    enum DocType {Id, Financial, Property}

    struct Document{
        uint TimeStamp;
        DocType Type;
        string SourceUrl;
        bool Verified;
    }
    
    Document[] documents;
    mapping(uint =>address) docToOwner;
    mapping(address => uint) ownerDocCount;

    constructor() public{
        
    }

    function docRegister(DocType doctype, string source) internal {
        uint id = documents.push(Document(now, doctype, source, false));
        docToOwner[id] = msg.sender;
        ownerDocCount[msg.sender]++;
    }

    function docVerify(uint docId) internal {
        documents[docId].Verified = true;
    }

}