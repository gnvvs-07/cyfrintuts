// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
contract FundMe {
    // for funding
    function fund() public payable {
        require(msg.value > 1e18,"Didnot send enough tokens");
    }
    // for withdraawing
    function withdraw() public {}
}
