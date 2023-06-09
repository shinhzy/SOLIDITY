//SPDX-License-Identifier: MIT

pragma solidity <0.9.0;

contract SampleFallback {
    uint public lastValueSent;
    string public lastFunctionCalled;

    // ++
    uint public myUint;
    function setMyUint(uint _myNewUint) public {
        myUint = _myNewUint;
    }
    //
    // "setMyUint(uint256)"
    // 0x e492fd84 00000000 00000000 00000000 00000000 00000000 00000000 00000001
    // 0xe492fd8400000000000000000000000000000000000000000000000000000001
    // 0xe492fd84
    //
    // Interact with the function, typing 1
    //   > input(one of the data)
    // == typing that number in [ Low Level interaction > CALLDATA ]


    receive() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "receive";
    }

    fallback() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "fallback";
    }
}
