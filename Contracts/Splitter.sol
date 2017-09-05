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

contract Splitter is Mortal {
    address public recipientA; 
    address public recipientB; 
    
    function Splitter(address _recipientA, address _recipientB) {
        require(recipientA != 0x0);
        require(recipientB != 0x0);
        
        recipientA = _recipientA;
        recipientB = _recipientB;
    }
    
    function Split() payable returns(bool success) {
        require(msg.value != 0);
        
        uint splitAmount = msg.value / 2;
        uint remainder = msg.value - splitAmount * 2;
        
        recipientA.transfer(splitAmount);
        recipientB.transfer(splitAmount);
        
        owner.transfer(remainder);

        return true;
    }    
}
