//[6.ERC20 Token Sale]
//<Events As Return Variables>
//<Metamask, Web.js, And Event Listeners>
//  {SampleEvent.sol} <<<
//  {websiteExampleMetamask/HTML.html}
//  {websiteExampleMetamask/JS.js}

// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

contract EventExample {

    mapping(address=>uint) public tokenBalance;
    //매핑 배열

    event TokensSent(address _fromm, address _to, uint _amount);
    // 블록체인에 거래를 저장하기 위해 사용
    // string을 저장하는 것보다 
    // TokensSent(address,address,uint256) 를 Keccak-256 으로 해싱할 경우
    // e607861baff3d292b19188affe88c1a72bdcb69d3015f18bb2cd0bf5349cc3e1

    constructor(){
        tokenBalance[msg.sender] = 100;
    }
    // 우선 컨트랙트 생산자이자 sender는 매핑 배열에 100이라는 값이 저장됨
    // 이는 잔액이 100인 것으로 임의 설정되는 것

    function sendToken(address _to, uint _amount) public returns(bool){ // 토큰 전송 기능
        require(tokenBalance[msg.sender] >= _amount, "Not Enough tokens"); 
        // 매핑 배열 속 설정된 잔액보다 더 많이 전송하려하면 에러
        // 이하면 통과
        tokenBalance[msg.sender] -= _amount;
        // 통과한 이후에는 출금액만큼 잔액 감소
        tokenBalance[_to] += _amount;
        // 토큰을 입금받은 주소의 잔액 증가

        emit TokensSent(msg.sender, _to, _amount);
        // 아래의 return 으로는 정보표시를 할 수 없으므로 사용
        // logs에 from, topic event, args{} 등 요소가 출력된다.
        // *** decoded ouput이닌 logs에 나타남***
        //+event를 출력하기 위해 사용 / 블록체인에 거래를 저장하기 위해 event와 함께 사용

        return true;
        // return이 있으나 decoded output로 나타나지는 않음
        // 스마트 컨트랙트 간의 정보 전달을 위해 존재
    }

}
// 강의자는 메타마스크에서 직접 시험함
// 자기 자신에서 송금하면서 테스트 진행