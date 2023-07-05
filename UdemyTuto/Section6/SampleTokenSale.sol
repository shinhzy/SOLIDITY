//[6.ERC20 Token Sale]
//<The ERC20 Token Explained>
//  {SampleToken.sol}
//<Implementing An ERC20 Token Sale>
//  {SampleTokenSale.sol} <<<


//<1. {SampleToken.sol}, {SampleTokenSale.sol} 함께 테스트 >
// 가상 어카운트 A,B,C 가 있을 때,
// A 어카운트가 디플로이한 X(A){ SampleToken.sol > AccessControl } 컨트랙트가 있다.
// X(A) 컨트랙트에서 A 어카운트로 < to: B 주소, amount: 100 >로 mint 하였다.
// X(A) 컨트랙트에서 "         " < account: B 주소 >로 balanceOf로 토큰 잔액 확인하였다.
// B 어카운트로 Y(B) { SampleTokenSale.sol > TokenSale } 컨트랙트 디플로이하고자 할 때
//                                          컨트랙트 X(A) 주소를 넣으며 디플로이하였다.
// X(A) 컨트랙트에서 B 어카운트로 < spender: Y(B) 주소, addedValue: 5*10"^18 > 값을 increaseAllowance에 입력하여 트랜잭션하였다.
// "              " "         " < ownder: B 의 주소, spender: Y(B) 주소> 를 allowance 값에 넣고 출력을 확인하였다.
// C 어카운트로 < value: 1 ETH > 와 함께 Y(B) 컨트랙트에서 purchase 시도하였으며, 성공하였다.
// 이때 X(A) 컨트랙트에서 C 어카운트로 < ownder: B 의 주소, spender: Y(B) 주소> 를 allowance 값에 넣고 출력을 확인하면
// 값이 1 ETH 감소하여 4*10^18 이 된 것을 확인할 수 있다.



// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

// // 엄격한 추상 컨트랙트 __ 틀의 역할만 함
// //    모든 함수가 추상함수, 다른 컨트랙트나 인터페이스 피상속 불가
// //    자체 생성자, 변수, 구조체 및 나열형 정의 불가
// interface IERC20 {
//     function transfer(address to, uint amount) external;
//     //토큰 이체 기능
//     function decimals() external view returns(uint);
//     //
// }

// contract TokenSale {
//     uint tokenPriceInWei = 1 ether;
//     //변수에 1 Ether == 10^18 Wei 저장

//     IERC20 token; //추상 컨트랙트 인터페이스 참조

//     constructor(address _token) {
//         token = IERC20(_token);
//     } // 컨트랙트 배포될 때, 토큰 주소 입력 받음.

//     function purchase() public payable {
//         require(msg.value >= tokenPriceInWei, "Not enough money sent"); // 결제량 확인
//         uint tokensToTransfer = msg.value / tokenPriceInWei; //구매 가능한 토큰 수 계산
//         uint remainder = msg.value - tokensToTransfer * tokenPriceInWei; // 전송되지 않은 나머지 이더를 계산                                                                                       
//         token.transfer(msg.sender, tokensToTransfer * 10 ** token.decimals()); // 구매된 토큰 구매자에게 전송 __ Ether 단위
//         payable(msg.sender).transfer(remainder); //send the rest back // 구매후 남은 이더 구매자에게 반환

//     }
// }

//==Not refined version
// 추상 컨트랙트 __ 틀의 역할 + 자체 기능 존재
abstract contract ERC20{
    function transferFrom (address _from, address _to, uint256 _value) public virtual returns (bool success);
    function decimals() public virtual view returns (uint8);
}

contract TokenSale {
    uint public tokenPriceInWei = 1 ether;

    ERC20 public token;
    address public tokenOwner;

    constructor(address _token) {
        tokenOwner = msg.sender;
        token = ERC20(_token);
    }

    function purchase() public payable {
        require(msg.value >= tokenPriceInWei, "Not enough money sent");
        uint tokensToTransfer = msg.value / tokenPriceInWei;
        uint remainder = msg.value - tokensToTransfer * tokenPriceInWei;
        token.transferFrom(tokenOwner, msg.sender, tokensToTransfer * 10 ** token.decimals()); // Wei 단위
        payable(msg.sender).transfer(remainder); //send the rest back

    }
}