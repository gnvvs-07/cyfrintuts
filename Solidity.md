# Simple Contract
```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0;
contract SimpleStorage{
    // variable declaration
    uint256 storedData;
    function set(uint x) public{
        // setting the variable value
        storedData = x;
    }
    function get() public view returns (uint){
        return storedData;
    }
}
```
