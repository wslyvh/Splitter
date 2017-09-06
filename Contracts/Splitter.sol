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
    mapping(address => uint) public recipientBalances;
    
    function Splitter(address _recipientA, address _recipientB) {
        require(recipientA != 0x0);
        require(recipientB != 0x0);
        
        recipientA = _recipientA;
        recipientB = _recipientB;
    }
    
    function Split() payable returns(bool success) {
        require(msg.value != 0);
        
        uint splitAmount = msg.value / 2;
        recipientBalances[recipientA] += splitAmount;
        recipientBalances[recipientB] += splitAmount;
        
        uint remainder = msg.value - splitAmount * 2;
        owner.transfer(remainder);

        return true;
    }
    
    function Withdraw() payable returns(bool success) {
        require(msg.sender == recipientA || msg.sender == recipientB);
        
        uint amount = recipientBalances[msg.sender];
        recipientBalances[msg.sender] -= amount;
        
        msg.sender.transfer(amount);

        return true;
    }
}
