// SPDX-License-Identifier: MIT
pragma solidity  0.8.19; //version information

// ^0.8.18 means 0.8.18 or grater versions of solidity
// (>=0.8.18,<0.9.0) means range

// SPDX-License-Identifier : MIT

// contract
contract SimpleStorage {
    uint256 public myNum;
    function store(uint256 _favNum) public{
        myNum = _favNum;
    }
    // 0xd9145CCE52D386f254917e481eB44e9943F39138
    // view,pure - read state from the chain(DOESNOT REQUIRE ANY GAS)
    // store - updates state 

    // ERROR
    // function store(uint256 _favNum) view public{
    //     myNum = _favNum;
    // }

    function retrieve() public view returns (uint256) { //it costs some gas b/z it's associated with store 
        return myNum;
    }
}
