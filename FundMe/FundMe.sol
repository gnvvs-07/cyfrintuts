// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {

    uint256 public minimumUsd = 5e18;
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    using PriceConverter for uint256;
    
    function fund() public payable {
        require(msg.value.getConversionRate() >= minimumUsd,"Didnot send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }
    // for withdawing money 
    function withdraw() public{
        // for (/*starting index , ending index,  increment*/){}
        for(uint256 funderIndex = 0;funderIndex<funders.length;funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // resetting the funders 
        funders = new address[](0);
        // sending ETH from contracts
        // 1. transfer
        payable(msg.sender).transfer(address(this).balance); //making the type from address to payable for transactions
        // 2. send
        bool sendSuccess = payable (msg.sender).send(address(this).balance);
        require(sendSuccess, "failed to send ETH");
        // 3. call
        // (bool callSuccess,bytes memory dataReturned) = payable(msg.sender).call{value : address(this).balance}("");
        (bool callSuccess,) = payable(msg.sender).call{value : address(this).balance}("");
        require(callSuccess,"Call failed");
        
    }


}
