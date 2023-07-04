//[6.ERC20 Token Sale]
//<The ERC20 Token Explained>
//  {SampleToken.sol} <<<

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

//커피 토큰으로 커피를 구매하는 것에 비유
contract CoffeeToken is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    //커피 구매 이벤트
    event CoffeePurchased(address indexed receiver, address indexed buyer);

    //AccessControl
    //Roleable
    //미팅 가능한 주소를 추가로 지정가능
    constructor() ERC20("CoffeeToken", "CFE") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    //mintable 상태 == 스마트 컨트렉트 배포 후에 민팅 가능
    //특정 지갑에 토큰 제공
    //현 예제에서 10개 제공 예정
    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    //_msgSender() 는 msg.sender와 거의 같으나,
    //중간 컨트렉트에서 사용자의 요청을 받아서 대신 가스비를 소모하고 요청해주는 Gas Station Network구조에서,
    //  relayer(사용자의 요청을 받아 다시보낸 컨트렉트)가 아닌 end-user(요청 보낸 사용자)를
    //  MessageSender로 명확히 지정하기 위해 사용함.
    //
    //이를 통해 중간 다리인 컨트렉트가 msg.sender가 되는 것을 방지함
    //
    // User A -> Contract A -> Contract B 일 때, Contract B입장에서
    // msg.sender는 Contract A 이고 /  _msgSender()는 User A 임.


    //<<커피 구매>>
    //
    //<특정 지갑이 직접 커피를 구매하는 경우>
    //자신이 수령자이자 구매자
    function buyOneCoffee() public {
        _burn(_msgSender(), 1);
        emit CoffeePurchased(_msgSender(),_msgSender());
    }
    //
    //<특정 지갑이 다른 이의 지갑을 통해 커피를 구매하는 경우>
    //allowance를 통해 다른 지갑이 자신의 지갑에서 특정 개수의 토큰을 사용할 수 있게 허가해두면
    //나중에 그 다른 지갑이 나중에 자신의 지갑에서 토큰을 소모하며 커피를 사게 됨
    //구매 요청자가 수령자, allowance배포한 지갑이 실제 구매자
    function buyOneCoffeeFrom (address account) public {
        _spendAllowance(account, _msgSender(), 1);
        _burn(account, 1);
        emit CoffeePurchased(_msgSender(), account);
    }

}