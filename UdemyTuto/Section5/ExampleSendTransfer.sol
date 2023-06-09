//SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;


contract Sender {
    receive() external payable {}

    function withdrawTransfer(address payable _to) public {
        _to.transfer(10);
    }

    function withdrawSend(address payable _to) public {
        bool sentSuccessful = _to.send(10);
        // _to.send(10);
        require(sentSuccessful, "Sending the funcds was unsuccessful");
    }
}

//-----
contract ReceiverNoAction {

    function balance() public view returns(uint) {
        return address(this).balance;
    }

    receive() external payable {}
    // only to receive money
}


//-----
contract ReceiverAction {

    uint public balanceReceived; // storage variable

    function balance() public view returns(uint) {
        return address(this).balance;
    }

    receive() external payable {
        balanceReceived += msg.value;
    }
}
