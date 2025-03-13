// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract FallbackExample {
    uint256 public result;
    receive() external payable {
        result = 10;
    }
    // fallback - recieve + data
    fallback() external payable {
        result = 40;
     }

    //  recieve  - value
    // fallback - value + data
}
