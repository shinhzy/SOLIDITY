//[6.ERC20 Token Sale]
//<Modifier And Inheritance>
//  {ExampleModifier_Seperated.sol} <<<
//  {Ownable_Seperated.sol}


//SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "./Ownable_Seperated.sol";

contract InheritanceModifierExample is Owner{

    mapping(address => uint) public tokenBalance;

    constructor() {
        tokenBalance[msg.sender] = 100;
    }

    uint tokenPrice = 1 ether;

    function createNewToken() public onlyOwner {
        tokenBalance[owner]++;
    }

    function burnToken() public onlyOwner {
        tokenBalance[owner]--;
    }

    function purchaseToken() public payable {
        require((tokenBalance[owner] * tokenPrice) / msg.value > 0, "not enough tokens");
        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }

    function sendToken(address _to, uint _amount) public {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;
    }

}
