pragma solidity ^0.4.4;
import "mortal"

contract Splitter is mortal {
    
    address public owner;

    function Splitter(){
        owner = msg.sender;
    }
    
}