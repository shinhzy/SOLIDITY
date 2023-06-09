//[6.ERC20 Token Sale]
//<Web.js introduction>
//  {scripts/accounts.js} <<< 


// About web3 js
(async ()=>{
    // console.log("abc");
    let accounts = await web3.eth.getAccounts();
    console.log("-----")
    console.log(accounts, accounts.length); // 계정 전체 출력+그 길이
    //온라인(크롬 메타마스크)에서 동작 시킬 경우, 계정내의 지갑이 보임 (나의 경우 하나일 것)

    let balance = await web3.eth.getBalance(accounts[0]); // 첫번째 계정만 출력
    console.log(balance); // 지갑 잔액
    console.log("-----");

    // console.log(web3.utils.fromWei(balance, "ether"));//It should be "ether" not "eth" // OR other legacy units
    // 위와 같음
    let balanceInEth = web3.utils.fromWei(balance, "ether"); //balance.toString() is okay... / 여러 단위 중 ether라는 명칭의 단위를 정확히 입력
    console.log(balanceInEth); // 위에서 선언되었듯, 해당 지갑의 금액을 ether 단위로 변환하여 출력.

})();



// *위의 함수 형태에 대한 참조 ----------

// function main(){

// }
// main();

//--- ↑위 코드는 ↓아래 코드 와 같음 -----

// (()=>{

// })();
//-------------------------------------