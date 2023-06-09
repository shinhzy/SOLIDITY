//[6.ERC20 Token Sale]
//<Destroying Smart Contracts With Self-Destruct>
//  {SampleSelfdestruct.sol} <<<

//SPDX-License-Identifier: MIT
pragma solidity >=0.8.16;

contract StartStopUpdateExample {

    receive() external payable {}

    function destroySmartContract() public {
        selfdestruct(payable(msg.sender));
    } // Warning: not recommended
    
}
