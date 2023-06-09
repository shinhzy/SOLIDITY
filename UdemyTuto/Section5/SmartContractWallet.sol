//[5: [Project] SmartWallet]
//<Understanding The ABI Array>
//  {SmartContractWallet.sol}


// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;


// 주의할 점
// 간단한 지갑 구현체로 변수나 함수와의 상호작용은
// IDE의 Depolted Contracts와 직접 상호작용한다.
contract SmartContractWallet{
    

    address payable owner;

    mapping (address=>bool) public isAllowedToSend;
    // 송금이 허용된 사람인지 확인하기 위한 맵핑어레이 변수
    // 배열[특정주소] = 송금권한 예/아니오 

    mapping (address=>uint) public allowance;
    // 송금 허용된 사람의 한도를 정하기 위한 맵핑어레이 변수
    // 배열[특정주소] = 송금가능액수


    // ------------------------------------------------
    // // 위의 예제는
    // // 구조체를 만들지 않음 그냥 하는 것이 가스비가 저렴
    // struct PnL {
    //     bool PermissionToSend;
    //     uint LimitsToSend;
    // }
    // mapping (address=>PnL) public AddressPnL;
    // // 배열[주소] = {권한,한도}
    // ------------------------------------------------


    mapping (address=>bool) public guardians;
    // 지갑의 새 주인을 허가할 투표 권한을 가진 가디언

    address payable nextOwner;
    // 지갑의 새 주인을 위한 변수
    // 지갑 새 주인 변수는 여러 가디언의 투표 과정에서 변수의 기존 값을
    // 저장할 필요가 있어서 사용하는 것
    // 원래 0으로 리렛된 상태에서 가디언이 특정 주소에 대해
    // 새 주인 투표를 시도하면 그 값에서 추출하여 이 변수에 임시로
    // 저장하게 된다.

    // >>처음에 했던 잘못된 생각<<
    // 지갑 주인 변수는 컨트랙트 인터페이스에서 입력하는 것으로 보임 XXX
    // 다만 강의 내용처럼 지갑을 잃어버렸을 때는 이것으로는 불가능할 것 같음 XXX



    mapping (address=>mapping (address=>bool))nextOwnerGuardianVotedBool;
    // 가디언 투표 여부 확인
    // 사실상 2차원 배열이며 "[새로운 주인이 될 주소][투표중인 가디언] = 투표여부" 이다

    uint guardiansAgreementCount;
    // 아래의 변수와 비교하기 위한 변수
    // 찬성 투표한 가디언의 숫자를 세기위한 변수
    // 이 변수의 카운트가 올라가며, 다음 변수에 설정된 값에 해당할 때
    // 0으로 리세되며 특정 함수가 동작하게 된다. 
    uint public constant confirmationFromGuardiansForReset = 3;
    // 투표 통과하게 하기위한 찬성 투표의 개수 설정 = 3개


    constructor(){
        owner = payable (msg.sender);
    } // 주인>> 스마트계약 초기 설정


    // 본 함수는 주인이 사용(호출)하게 될 함수 이다.
    function setGuarding(address _guardian, bool _isGuarding) public {
        require(msg.sender == owner, "You are not the owner, aborting");
        guardians[_guardian] = _isGuarding;
    } // 주인>> 가디언 설정

    // 본 함수는 주인이 사용(호출)하게 될 함수 이다.
    function setAllowance(address _from, uint _amount) public {
        require(msg.sender == owner, "You are not the owner, aborting");
        
        isAllowedToSend[_from] = true; // 송금 권한 있는 주소
        allowance[_from] = _amount; // 송금 한도

        // 구조체를 안쓰는 게 더 저럼함
        // AddressPnL[_from].PermissionToSend = true;
        // AddressPnL[_from].LimitsToSend = _amount;

    }

    // 본 함수는 가디언이 사용(호출)하게 될 함수 이다.
    // 따라서 msg.sender를 통해 호출한 가디언의 주소가 자동으로 들어가게 된다.
    function proposeNewOwner(address payable _newOwner) public {
        require(guardians[msg.sender], "You are not guardian of this wallet, aborting");
        // 가디언 등록 여부 확인
        require(nextOwnerGuardianVotedBool[_newOwner][msg.sender]==false, "You already voted, aborting");
        // 해당 가디언 기투표 여부 확인

        if(nextOwner != _newOwner) {
            nextOwner = _newOwner;
            guardiansAgreementCount = 0;
        }
        // nextOwner는 기본적으로 0으로 초기화되어 있다.
        // 가디언이 새 주인 설정을 찬성하고자 할 때, 대상 주소를 지정하게 되는데
        // 입력한 주소(_newOwner)가 

        nextOwnerGuardianVotedBool[_newOwner][msg.sender] = true;
        // [새 주인이 되고자 하는 주소][가디언 주소] = 투표 여부 (예) 갱신
        guardiansAgreementCount++;
        // 동의한 가디언의 수

        if(guardiansAgreementCount >= confirmationFromGuardiansForReset) {
            owner = nextOwner;
            nextOwner = payable (address(0));
        }
        // 동의한 가디언의 수가 필요한 찬성표 개수 이상이면, 주인변경 동작
        // 주인의 주소 등록 변수 owner 값에 새 주인의 주소값 입력
        // 입력에 쓰인 임시 변수는 0으로 리셋

    } // 가디언 

    // 본 함수는 주인 또는 송금 권한자가 사용(호출)하게 될 함수 이다.
    function transfer(address payable _to, uint _amount ,  bytes memory _payload) public returns(bytes memory) {

        // require(msg.sender == owner, "You are not the owner, aborting.");
        if(msg.sender != owner){
            require(isAllowedToSend[msg.sender], "You are not allowed to send anything from this smart contract, aborting");
            // 허가된 사용자 여부 확인
            require(allowance[msg.sender] >= _amount, "You are trying to send more than you are allowed to, aborting");
            // 허가된 사용자의 한도 확인

            (bool success, bytes memory returnData) = _to.call{value:_amount}(_payload);
            require(success, "Aborting, call was not successful");
            allowance[msg.sender] -= _amount;
            // 허가된 사용자의 인출에 따른 한도 조정 
            // 성공하였으면
            return returnData;
            // 관련 데이터 반환

            // 기존 코드는 실패하였을 때도 allowance(한도)가 줄어들었다.
            // 이를 방지하고자 성공하였을 때에만 allowance가 감소하도록 순서를 변경하였다.

        } else {
            (bool success, bytes memory returnData) = _to.call{value:_amount}(_payload);
            require(success, "Aborting, call was not successful");
            // 성공하였으면
            return returnData;
            // 관련 데이터 반환
        }

        // 기존 코드를 변경하며 조금 코드가 증가하였다.

    }

    receive() external payable {}
}