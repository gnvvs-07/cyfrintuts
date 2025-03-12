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
    }
}
