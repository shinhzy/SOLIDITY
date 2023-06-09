//SPDX-License-Identifier: MIT
pragma solidity <0.9.0;

contract WillThrow {
    error NotAllowedError(string); //For custom error

    function aFunction() public pure {
        // require(false, "Error message"); //For Error
        // assert(false); //For Panic
        revert NotAllowedError("You are not allowed"); //For custom error
    }
}

contract ErrorHandling {
    event ErrorLogging(string reason);
    event ErrorLogCode(uint code);
    event ErrorLogBytes(bytes lowLevelData);

    function catchError() public {
        WillThrow will = new WillThrow();
        try will.aFunction() {
            //here we could do something if it works
        } catch Error(string memory reason) {
            emit ErrorLogging(reason);
        } catch Panic(uint errorCode) {
            emit ErrorLogCode(errorCode);
        } catch (bytes memory lowLevelData) { //Custom Error
            emit ErrorLogBytes(lowLevelData);
        }
    }
}
