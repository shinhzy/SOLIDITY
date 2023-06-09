// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.15;


//Case 1. //External Function Call ---------------------------------
// 가스비 지정 위함

// contract ContractOne {
//     mapping(address => uint) public addressBalances;
//     function getBalance() public view returns(uint) {
//         return address(this).balance;
//     }
//     function deposit() public payable {
//         addressBalances[msg.sender] += msg.value;
//     }
// }

// contract ContractTwo {
//     // receive() external  payable {}
//     //?
//     function deposit() public payable {}
//     function depositOnContractOne(address _contractOne) public { 
//         ContractOne one = ContractOne(_contractOne);
//         one.deposit{value: 10, gas: 100000}(); 
//         // ContractOne을 부르고 금액을 전송할 예정
//     }
// }


//Case 2. //Low-Level Calls on Address-Type Variables -----------------------------------
//익명화 위함

// contract ContractOne {

//     mapping(address => uint) public addressBalances;
//     function getBalance() public view returns(uint) {
//         return address(this).balance;
//     }
//     function deposit() public payable {
//         addressBalances[msg.sender] += msg.value;
//     }
// }

// contract ContractTwo {
//     // receive() external  payable {}
//     //?
//     function deposit() public payable {}
//     function depositOnContractOne(address _contractOne) public { 
//         bytes memory payload = abi.encodeWithSignature("deposit()");
//         (bool success, ) = _contractOne.call{value: 10, gas: 100000}(payload);
//         require(success);
//     }
// }




//Case 2+. //Low-Level Calls on Address-Type Variables+ -----------------------------------
//어떤 함수가 있는지 정확히 몰라도 동작하기 위함

contract ContractOne {

    mapping(address => uint) public addressBalances;
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    receive() external payable {
        addressBalances[msg.sender] += msg.value;
    }
}

contract ContractTwo {
    // receive() external  payable {}
    //?
    function deposit() public payable {}
    function depositOnContractOne(address _contractOne) public { 
        (bool success, ) = _contractOne.call{value: 10, gas: 100000}("");
        require(success);
    }
}
