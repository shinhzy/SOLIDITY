//[6: [Project] ERC20 Token Sale]
//<Understanding The ABI Array>
//  {SampleDebugging.sol} <<< 디버깅을 통해 EVM 동작 확인 + ABI
//  {scripts/updateUint.js}


// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;


contract MyContract {
    uint public myUint = 123; // stateMutability:view (in ABI array)

    function setMyUint(uint newUint) public { //stateMutability:nonpayable (in ABI array)
        myUint = newUint;
    }

    //web3.utils.sha3("setMyUint(uint256)") 를 통해
    //Keccack-256 으로 setMyUint(uint256) 라는 문자열을 해싱할 경우
    //e492fd842fb25dc4b3c624c80776108b452a545c682a78e4252b5560c6537b79 를 출력
    //여기서 앞 4바이트 e492fd84 를 EVM 내에서 이 함수를 구별할 때 사용함
    
}
