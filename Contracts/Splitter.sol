pragma solidity ^0.4.16;

contract Mortal {
    address owner;

    function mortal() { owner = msg.sender; }

    function kill() { if (msg.sender == owner) suicide(owner); }
}

contract Owned {
    address public owner; 

    function Owned() {
        owner = msg.sender;
    }
}

contract Splitter is Mortal, Owned {
    
}
