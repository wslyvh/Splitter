pragma solidity ^0.4.16;


contract Owned {
    address public owner; 

    modifier fromOwner {
        require(msg.sender == owner);
        _;
    }
    
    function Owned() public {
        owner = msg.sender;
    }
}

contract Terminable is Owned {
    
    function terminate() fromOwner public { 
        selfdestruct(owner); 
    }
}

contract Splitter is Terminable {

    address public recipientA; 
    address public recipientB; 
    mapping(address => uint) public recipientBalances;
    uint remaining;
    
    function Splitter(address _recipientA, address _recipientB) public {
        require(recipientA != address(0));
        require(recipientB != address(0));
        
        recipientA = _recipientA;
        recipientB = _recipientB;
    }
    
    function Split() payable public returns(bool success) {
        require(msg.value != 0);
        
        uint splitAmount = (remaining + msg.value) / 2;
        recipientBalances[recipientA] += splitAmount;
        recipientBalances[recipientB] += splitAmount;
        
        remaining += msg.value - splitAmount * 2;

        return true;
    }
    
    function Withdraw() public returns(bool success) {
        require(msg.sender == recipientA || msg.sender == recipientB);
        
        uint amount = recipientBalances[msg.sender];
        recipientBalances[msg.sender] -= amount;
        
        msg.sender.transfer(amount);

        return true;
    }
}
