pragma solidity ^0.4.21;

import "./Escrow.sol";
import "./DocRegistration.sol";

contract Application {

    struct Application {
        address Applicant;
        uint[] Docs;
        uint TotalAmount;
        uint Duration;
        uint Interests;
        Escrow escrow;
    }
    Application[] internal applications;

   function apply(address applicant, uint[] docs, uint totalAmount, uint duration, uint interests) public {
       applications.push(Application(applicant, docs, totalAmount, duration, interests, 
       new Escrow(applicant, totalAmount, duration,interests)));
    }

    function Invest() public {

    }

}