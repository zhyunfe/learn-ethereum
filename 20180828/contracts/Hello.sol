pragma solidity ^0.4.24;
contract Hello {
    string greeting;

    constructor(string _greeting) public {
        greeting = _greeting;
    }

    function say() constant public returns (string) {
        return greeting;
    }
}
