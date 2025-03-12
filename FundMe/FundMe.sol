// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUsd = 5e18;
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    AggregatorV3Interface private immutable priceFeed;
    
    // creating a construcotor for price feed for saving gas

    constructor(){
        priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    function fund() public payable {
        require(getConversionRate(msg.value) >= minimumUsd,"Didnot send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender]+ msg.value;
    }

    function getPrice() public view returns (uint256){
        // address and ABI
        (,int256 price,,,) = priceFeed.latestRoundData();
        // Convert price from 8 to 18 decimal places
        return uint256(price*1e10);
        
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        // converting to usd
        uint256 ethAmountInUsd = (ethPrice * ethAmount)/1e18;
        return ethAmountInUsd;
    }
}
