// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
contract FundMe {
    // for funding
    uint256 public myValue   = 1;
    function fund() public payable {
        // Here if the value send is less than 1ETH myValue remains as 1 but gas will still be spent since its executing the myValue and fund 
        myValue = myValue+1;
        require(msg.value > 1e18,"Didnot send enough tokens");
    }
    // for withdraawing
    function withdraw() public {}
}
