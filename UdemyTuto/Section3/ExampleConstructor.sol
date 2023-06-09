//SPDX-License-Identifier: MIT

pragma solidity <0.9.0;

contract ExampleConstructor {

    address public myAddress;

    constructor(address _someAddress) {
        myAddress = _someAddress;
    }

    function setMyAddress(address _myAddress) public {
        myAddress = _myAddress;
    }
    function setMyAddressToMsgSender() public {
        myAddress = msg.sender;
    }

}
