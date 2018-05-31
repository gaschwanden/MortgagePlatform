pragma solidity ^0.4.21;


contract DocRegistration {
    
    enum DocType {Id, Financial, Property}

    struct Document{
        string Name;
        uint TimeStamp;
        DocType Type;
        string SourceUrl;
        bool Verified;
    }
    
    Document[] documents;
    mapping(uint =>address) docToOwner;
    mapping(address => uint) ownerDocCount;

    function docRegister(string name, DocType doctype, string source) internal {
        uint id = documents.push(Document(name, now, doctype, source, false));
        docToOwner[id] = msg.sender;
        ownerDocCount[msg.sender]++;
    }

    function docVerify(uint docId) internal {
        documents[docId].Verified = true;
    }

}