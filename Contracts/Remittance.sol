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
    uint public deadline;
    bytes32 hash;
    
    function Remittance(uint _deadline, bytes32 _hash) {
        require(_deadline > 0);
        require(_hash > 0);
        
        hash = _hash;
    }
    
    function ReturnFunds() payable returns (bool success) {
        require(msg.sender == owner);
        require(block.timestamp > deadline);
        
        owner.transfer(this.balance);
        return true;
    }
    
    function Withdraw(uint _passwordA, uint _passwordB) payable returns (bool success) {
        require(block.timestamp < deadline);
        require(_passwordA > 0);
        require(_passwordB > 0);
        require(hash == keccak256(_passwordA == _passwordB));
        
        msg.sender.transfer(this.balance);
        
        return true;
    }
    
    function TakeCut() payable returns (bool success) {
        require(msg.sender == owner);
        
        return true;
    }
}