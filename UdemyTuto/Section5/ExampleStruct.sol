//SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

//----------------------------------------------------------------

//[Child Contracts way]
//These are contract & child contract

// <First Step>
// You need to "Deploy" the CONTRACT 'Wallet'
// In this situation, you can interact with the 'payment' of deployed contract.
// In this example, you need to set the VALUE to 1(Wei);
// When you interact with it, it will call the child contract 'PaymentReceived'.
// After it, it will return the address.
// You need to copy the address for afterward.

// <Second Step>
// You need to select the second CONTRACT 'PaymentReceived'.
// Paste what you copied into the AtAddress section and click it.
// In this situation, you can interact with the new contract.
// From now on, you can interact with the variables 'from' and 'amount'.
// I the 'from', there is address of the sender.
// In the 'amount', there is amount of Ether[Wei] the 'from' sent.
// You can check the amount of it which should be 1(Wei) as the <First Step>'s example.


contract Wallet {
    PaymentReceived public payment;
    // address sender;
    // uint valueSent;

    function payContract() public payable {
        payment = new PaymentReceived(msg.sender, msg.value);
        // sender = msg.sender;
        // value = msg.value;
    }
}
contract PaymentReceived {
    address public from;
    uint public amount;

    constructor(address _from, uint _amount) {
        from = _from;
        amount = _amount;
    }
}

//----------------------------------------------------------------


//[Structs way]
//Simple Way & economical gas usage

// In this way, you only need to "Deploy" this 'Wallet2' once.
// You can interact with the 'payment'.
// You can check it returns 'from(sender)' and 'amount(value)'.

contract Wallet2 {
    struct PaymentReceivedStruct {
        address from;
        uint amount;
    }

    PaymentReceivedStruct public payment;

    function payContract() public payable {
        payment = PaymentReceivedStruct(msg.sender, msg.value);
        // payment.from = msg.sender;
        // paymnet.amount = msg.value;

    }
}

//----------------------------------------------------------------