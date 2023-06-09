//SPDX-License-Identifier: MIT

pragma solidity <0.9.0;

contract SampleContract {
    string public myString = "Hello World";

    // previous part of SampleContract
    // function updateString(string memory _newString) public {
    //     myString = _newString;
    // }

    // new part
    function updateString(string memory _newString) public payable {
        if(msg.value == 1 ether) {
            myString = _newString;
        } else {
            payable(msg.sender).transfer(msg.value);
        }
    }
}

// On the online Remix IDE (in Chrome)
// > Deploy & run transcations
// > ENVIRONMENT
// > Remix VM --> Injected Web3

// It will work on real blockchian test network
// on yout account
// Deploy > consume gas
// Read value > free gas
// Interact with the function > consume gas 