//[6.ERC20 Token Sale]
//<Modifier And Inheritance>
//  {ExampleModifier_OneCode.sol} <<<


//SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
contract InheritanceModifierExample {

    mapping(address => uint) public tokenBalance;

    uint tokenPrice = 1 ether;

    //================================================================
    address owner;

    constructor() {
        owner = msg.sender;
        tokenBalance[owner] = 100;
    } //owner has 100

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not allowed");
        _;
    }
    // createNewToken 와 burnToken 에서 재사용하기 위한 모디파이어
    //================================================================

    
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
