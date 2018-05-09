pragma solidity ^0.4.21;

import "./ERC721BasicToken.sol";

contract DocRegistration is ERC721BasicToken{
    
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
        uint id = Documents.push(Document(owner, doctype, source, false));
        docToOwner[id] = msg.sender;
        ownerDocCout[msg.sender]++;
    }

    function docVerify(uint docId) internal {
        documents[docId].Verified = true;
    }

}