//SPDX-License-Identifier: MIT

pragma solidity 0.6.12; // 0.7.0

contract ExceptionExample {

    mapping(address => uint) public balanceReceived;

    function receiveMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    // function withdrawMoney(address payable _to, uint _amount) public {
    //     if(_amount <= balanceReceived[msg.sender]) {
    //         balanceReceived[msg.sender] -= _amount;
    //         _to.transfer(_amount);
    //     }
    // }

    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= balanceReceived[msg.sender], "Not Enough Funds, aborting");
        //revert, error(String)
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}
