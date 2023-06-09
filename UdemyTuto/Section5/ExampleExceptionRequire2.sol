//SPDX-License-Identifier: MIT

pragma solidity 0.6.12; //0.7.0

contract ExceptionExample {

    mapping(address => uint8) public balanceReceived;

    function receiveMoney() public payable {
        assert(msg.value==uint8(msg.value));
        //Example, if overflow it will stop in here. // PANIC
        //And, It will consume the all gas(to the GAS LIMIT)
        balanceReceived[msg.sender] += uint8(msg.value);
    
        // +
        assert(balanceReceived[msg.sender] >= uint8(msg.value));
    }

    function withdrawMoney(address payable _to, uint8 _amount) public {
        require(_amount <= balanceReceived[msg.sender], "Not Enough Funds, aborting");
        //revert, error(String)
        
        // +
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}
//SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

contract ExceptionExample {

    mapping(address => uint8) public balanceReceived;

    function receiveMoney() public payable {
        assert(msg.value == uint8(msg.value));
        balanceReceived[msg.sender] += uint8(msg.value);
        assert(balanceReceived[msg.sender] >= uint8(msg.value));
    }

    function withdrawMoney(address payable _to, uint8 _amount) public {
        require(_amount <= balanceReceived[msg.sender], "Not Enough Funds, aborting");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}
