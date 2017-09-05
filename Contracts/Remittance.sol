pragma solidity ^0.4.16;

contract Owned {
    address public owner; 

    function Owned() {
        owner = msg.sender;
    }
}

contract Mortal is Owned {
    
    function kill() { 
        if (msg.sender == owner) 
            suicide(owner); 
    }
}

contract Remittance is Mortal {
    
    function Remittance() {
        
    }
}