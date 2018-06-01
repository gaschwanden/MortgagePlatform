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

    function docRegister(string name, uint curTime, DocType doctype, string source) internal returns(uint) {
        uint id = documents.push(Document(name, curTime, doctype, source, false)) - 1;
        docToOwner[id] = msg.sender;
        ownerDocCount[msg.sender]++;
        return id;
    }

    function docVerify(uint docId) internal {
        documents[docId].Verified = true;
    }

}