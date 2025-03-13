// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {

    uint256 public minimumUsd = 5e18;
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    using PriceConverter for uint256;
    address public owner;

    constructor(){
        owner = msg.sender;
    }
    
    function fund() public payable {
        require(msg.value.getConversionRate() >= minimumUsd,"Didnot send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    // modifier
    modifier onlyOwner(){
        require(msg.sender == owner,"Must be owner to withdraw");
        _;      //can be anything after this line 
    }

    // for withdawing money 
    function withdraw() public onlyOwner{
        
        // for (/*starting index , ending index,  increment*/){}
        for(uint256 funderIndex = 0;funderIndex<funders.length;funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // resetting the funders 
        funders = new address[](0);
        //  call
        (bool callSuccess,) = payable(msg.sender).call{value : address(this).balance}("");
        require(callSuccess,"Call failed");
        
    }


}
