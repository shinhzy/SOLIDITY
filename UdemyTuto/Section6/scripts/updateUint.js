//[6.ERC20 Token Sale]
//<Understanding The ABI Array>
//  {SampleDebugging.sol}
//  {scripts/updateUint.js} <<< 

(async ()=>{
    //--- Copied Section about these strings

    const address = "0xd9145CCE52D386f254917e481eB44e9943F39138"
    // 지갑이 아닌 Depoly한 스마트 컨트랙트의 주소
    const abiArray = [
        {
            "inputs": [],
            "name": "myUint",
            "outputs": [
                {
                    "internalType": "uint256",
                    "name": "",
                    "type": "uint256"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "newUint",
                    "type": "uint256"
                }
            ],
            "name": "setMyUint",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
        }
    ];
    //--- Copied Section about these strings
    const contractInstance = new web3.eth.Contract(abiArray, address);
    // 스마트 컨트랙트 정보 입력 -- 주소와 ABI배열 입력
    // 생성된 컨트랙트 인스턴스의 정보 받아 새 변수로 만들기
    // web3가 스마트 컨트랙트 내의 함수 이름을 알 수 없기 때문에 ABI를 통해 제공
    console.log("----");
    console.log(await contractInstance.methods.myUint().call()); // 이더리움 잔액 확인
    // console.log(await contractInstance);
    console.log("----");

    let accounts = await web3.eth.getAccounts(); // 내 지갑 전체 불러오기
    let txResult = await contractInstance.methods.setMyUint(345).send({from: accounts[0]});
    // 내 지갑 1번째에 대하여, 이미 선언한 setMyUint를 통해 myUint값을 직접 345로 바꿈
    // 이 트랜젝션 비용 지불을 위해 send사용 / call()은 reading operation로 사용되므로?
    // 그 결과를 저장
    console.log(await contractInstance.methods.myUint().call()); // 이더리움 잔액 확인 
    console.log("----");
    console.log(txResult); // 저장된 결과 출력

})()