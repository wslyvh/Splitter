pragma solidity ^0.4.15;

import "./Terminable.sol";

contract Splitter is Terminable {

    address public recipientA; 
    address public recipientB; 
    mapping(address => uint) public recipientBalances;
    uint remaining;
    
    event LogSplit(address indexed sender, uint amount);
    event LogWithdrawal(address indexed sender, uint amount);

    function Splitter(address _recipientA, address _recipientB) public {
        require(recipientA != address(0));
        require(recipientB != address(0));
        
        recipientA = _recipientA;
        recipientB = _recipientB;
    }
    
    function split() payable public returns(bool success) {
        require(msg.value != 0);
        
        uint splitAmount = (remaining + msg.value) / 2;
        recipientBalances[recipientA] += splitAmount;
        recipientBalances[recipientB] += splitAmount;
        
        remaining += msg.value - splitAmount * 2;
        
        LogSplit(msg.sender, msg.value);
        return true;
    }
    
    function withdraw() public returns(bool success) {
        require(msg.sender == recipientA || msg.sender == recipientB);
        
        uint amount = recipientBalances[msg.sender];
        recipientBalances[msg.sender] -= amount;
        
        msg.sender.transfer(amount);

        LogWithdrawal(msg.sender, amount);
        return true;
    }
}
