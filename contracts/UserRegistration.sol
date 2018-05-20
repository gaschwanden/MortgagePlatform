pragma solidity ^0.4.21;

import "./Ownable.sol";

contract UserRegistration is Ownable {


    enum UserType {Borrower, Investor, Verifier}

    struct User{
        string Name;
        UserType Type;
        bool Verified;
    }
    mapping(address => User) public Users;


    function userRegister(string name, UserType usertype) internal {
        Users[msg.sender] = User(name, usertype, true);
    }
    
    function userVerify(address user) internal {
        Users[user].Verified = true;
    }
    
}