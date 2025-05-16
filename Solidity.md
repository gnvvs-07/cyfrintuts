`using remix-ide`
https://remix.ethereum.org/

visit [solidity by example](https://solidity-by-example.org/) for more info

`SimpleStorage.sol`

```sol
//SPDX-License-Identifier: MIT
//solidity version 
pragma solidity ^0.8.19
```

creating a simple contract

```sol
contract SimpleStorage{
	//contract content------
}
```

basic types > 
1. boolean 
```sol
bool hasGot = false;
```
2. address
```sol
address myAddress = _myAddress_
```
3. uint(256 or 128 or 64 or 32 or 16 or 8)`positive only`
```sol
uint favNumber = 120;
```
4. int(positive or negative )
```sol
int favNumber = -120;
```
5. bytes(maximum is `bytes32`)
```sol
bytes32 fav = "love"
```
6. string
```sol
string fav = "kala"
```

>default values
>0,""

`Basic solidity functions`

`SimpleStorage.sol`

```sol
contract SimpleStorage{
	uint256 public favNumber;
	function store(uint256 _favNumber) public{
		favNumber = _favNumber
	}
}
```

>methods : store() , variables : favNumber(publicly available)

[^1]visibility specifiers

[^1]: public : visible internally and externally 
	private : only visible to current contract
	external : only visible externally(only for functions)
	internal(default) : only visible internally


```sol
contract SimpleStorage{
	uint256 public favNumber;
	function store(uint256 _favNumber) public{
		favNumber = _favNumber;
	}
	function retrive() public view returns(uint256){
		return favNumber;
	}
}
```


>special gestures

| view                                               | pure                   |
| -------------------------------------------------- | ---------------------- |
| just read state of a block chain + disallow update | disallow update + read |

>Arrays and structs

```sol
contract SimpleStorage{
	uint256 public favNumber;
	uint 256 listOfFavNumbers; //declaring an array of list of fav Numbers
	function store(uint256 _favNumber) public{
		favNumber = _favNumber;
	}
	function retrive() public view returns(uint256){
		return favNumber;
	}
}

```

```sol
contract SimpleStorage{
	uint256 public myfavNumber;
	struct Person{
		uint256 favNumber;
		string name;
	}
	//person
	Person public myFriend = Person(110,"kavya");
							//or//
	Person public myLove = Person({
		favNumber : 110,//index = 0
		name : "kala"  //index = 1
		
	});

	Person public myFriend = Person({
		favNumber : 140,//index = 0
		name : "sravanthi"  //index = 1
		
	});

	//............ what if there are a lot of people (create a list of persons)

	Person[] public listOfPeople; // [] : dynamic array
	// for static array `Person[3] public listOfPeople;`

	function store(uint256 _favNumber) public{
		myfavNumber = _favNumber;
	}
	function retrive() public view returns(uint256){
		return myfavNumber;
	}
}
```

>addPerson()

```sol
contract SimpleStorage{
	struct Person{
		uint256 favNumber;
		string name;
	}
	Person[] public listOfPeople;
	function addPerson(uint256 _favNumber,string memory _name) public{
		listOfPeople.push(Person(_favNumber,_name));
	}
}
```

*Note : use [^2]AI tools for understanding the errors and warnings*

[^2]: ChatGPT
	Claude
	Phind
	Perplexity


>**Data Location**
>Data location can only be given to array,struct,mapping not for primitive data types

function addPerson(uint256 _favNumber,string **memory** _name) public{
	listOfPeople.push(Person(_favNumber,_name));
}

1. calldata(variable exists only for function call i.e temporarily) *non-mutable variables inside the function*

$$
incorrect
$$

```sol
function addPerson(string calldata _name){
	_name = "muzan";
}
```

2. memory(default functional variables) *mutable variables inside function*
$$
correct
$$

```sol
function addPerson(string memory _name){
	_name = "muzan";
}
```

3. storage : `out of function but inside the contract`

>Mapping

```sol
mapping(string=>uint256) public nameToFavNumber;
function addPerson(uint256 _favNumber,string memory _name) public{
	listOfPeople.push(Person(_favNumber,_name));
	nameToFavNumber[_name] = _favNumber
}
```




$$
REMIX STORAGE FACTORY
$$

>Smart contracts are composable 

`SimpleStorage.sol`

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage{
	uint256 myfavNumber;//default = 0
	
	struct Person{
		uint256 favNumber;
		string name;
	}
	
	Person[] public listOfPeople;
	
	mapping(string=>uint256) public nameToFavNumber;
	
	function addPerson(uint256 _favNumber,string memory _name) public{
		listOfPeople.push(Person(_favNumber,_name));
		nameToFavNumber[_name] = _favNumber
	}
	
	function store(uint256 _favNumber) public{
		myfavNumber = _favNumber;
	}
	
	function retrive() public view returns(uint256){
		return myfavNumber;
	}
}
```

`StorageFactory.sol`

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage{
	uint256 myfavNumber;//default = 0
	
	struct Person{
		uint256 favNumber;
		string name;
	}
	
	Person[] public listOfPeople;
	
	mapping(string=>uint256) public nameToFavNumber;
	
	function addPerson(uint256 _favNumber,string memory _name) public{
		listOfPeople.push(Person(_favNumber,_name));
		nameToFavNumber[_name] = _favNumber
	}
	
	function store(uint256 _favNumber) public{
		myfavNumber = _favNumber;
	}
	
	function retrive() public view returns(uint256){
		return myfavNumber;
	}
}

contract StorageFactory{

	SimpleStorage public simpleStorage;//SimpleStorage obj
	
	function createSimpleStorageContract() public {
		//accessing and deploying `SimpleStorage.sol`
		simpleStorage = new SimpleStorage();
		// `new` makes SimpleStorage also getting deployed returns a 
		address of the SimpleStorage transaction address
		
		
	}
}
```

>Using `import`

`StorageFactory.sol`

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./SimpleStorage.sol";

contract StorageFactory{

	SimpleStorage public simpleStorage;//SimpleStorage obj
	
	function createSimpleStorageContract() public {
		simpleStorage = new SimpleStorage();
	}
}
```

*Note : solidity version check*

*Note : use named imports instead of default imports*

```sol
import {SimpleStorage} from "./SimpleStorage.sol";
//import {SimpleStorage2} from "./SimpleStorage.sol"
```


>ABI

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {SimpleStorage} "./SimpleStorage.sol";

contract StorageFactory{

	SimpleStorage[] public listOfSimpleStorageContracts;
	function createSimpleStorageContract() public {
		SimpleStorage newSimpleStorageContract = new SimpleStorage();
		listOfSimpleStorageContract.push(newSimpleStorageContract);
	}
	
}
```

interacting the functions in the `SimpleStorage.sol` using `StorageFactory.sol` 

```sol
import {SimpleStorage} "./SimpleStorage.sol";

contract StorageFactory{
	SimpleStorage[] public listOfSimpleStorageAddresses;
	
	function createSimpleStorageContract() public {
		SimpleStorage newSimpleStorageAddresses = new SimpleStorage();
		listOfSimpleStorageAddresses.push(newSimpleStorageContract);
	}
	
	//requirements : address , ABI
	function sfStore(uint256 _simpleStorageIndex,uint256 _newSimpleStorageNumber) public {
		SimpleStorage mySimpleStorage = SimpleStorage(listOfSimpleStorageAddresses[_simpleStorageIndex]);
		//SimpleStorage(address)
		mySimpleStorage.store(_newSimpleStorageNumber)
	}

	function sfGet(uint256 _simpleStorageIndex) public view returns (uint256){
		SimpleStorage mySimpleStorage = SimpleStorage(listOfSimpleStorageAddresses[_simpleStorageIndex]);
		return mySimpleStorage.retrive();
	}
	
}
```


`AddFive.sol`

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
//child contract of `SimpleStorage`
import {SimpleStorage} from "./SimpleStorage.sol";
contract AddFiveStorage is SimpleStorage{
	//override
	function store(uint256 _favNumber) public override{
		myfavNumber = _favNumber+5;
	}
}
```

`SimpleStorage.sol`

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage{
	uint256 myfavNumber;//default = 0
	
	struct Person{
		uint256 favNumber;
		string name;
	}
	
	Person[] public listOfPeople;
	
	mapping(string=>uint256) public nameToFavNumber;
	
	function addPerson(uint256 _favNumber,string memory _name) public{
		listOfPeople.push(Person(_favNumber,_name));
		nameToFavNumber[_name] = _favNumber
	}
	
	function store(uint256 _favNumber) public virtual{
		myfavNumber = _favNumber;
	}
	
	function retrive() public view returns(uint256){
		return myfavNumber;
	}
}
```

now we can use `AddFive` contract instead of `SimpleStorage` in `StorageFcatory.sol`

$$
Fund Me - remix
$$
`FundMe.sol`

- get funds from users
- withdraw funds
- minimum funding value in USD
```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
contract FundMe{
	function fund() public{}
	function withdraw() public{}
}
```

*fund*

```sol
function fund() public payable {
	require(msg.value > 1e18,"Minimum amount should be 1ETH");
}
```

[eth-converter](https://eth-converter.com/)

![[Pasted image 20250510111146.png]]

>Revert undo any actions have been done and sends the gas back 

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
contract FundMe{
	uint256 minimumUsd = 5;//5$
	function fund() public{
		require(msg.value >= minimumUsd,"Minimum abount is not enough");
	}
	function withdraw() public{}
}
```

>`minimumUsd` is in `USD` where as `msg.value` is in `ETH` or `WEI`

- solution is [[oracles]]

Deploying a contract to a test net 
![[Screenshot from 2025-05-10 11-47-02.png]]

![[Screenshot from 2025-05-10 11-47-25.png]]

`The above images consost the code from reading data feeds`

real time data feed from chain link data feeds

`DataConsumerV3.sol` uses `Sepolia`

```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

/**
 * THIS IS AN EXAMPLE CONTRACT THAT USES HARDCODED
 * VALUES FOR CLARITY.
 * THIS IS AN EXAMPLE CONTRACT THAT USES UN-AUDITED CODE.
 * DO NOT USE THIS CODE IN PRODUCTION.
 */

/**
 * If you are reading data feeds on L2 networks, you must
 * check the latest answer from the L2 Sequencer Uptime
 * Feed to ensure that the data is accurate in the event
 * of an L2 sequencer outage. See the
 * https://docs.chain.link/data-feeds/l2-sequencer-feeds
 * page for details.
 */

contract DataConsumerV3 {
    AggregatorV3Interface internal dataFeed;

    /**
     * Network: Sepolia
     * Aggregator: BTC/USD
     * Address: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
     */
    constructor() {
        dataFeed = AggregatorV3Interface(
            0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
        );
    }

    /**
     * Returns the latest answer.
     */
    function getChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundId */,
            int256 answer,
            /*uint256 startedAt*/,
            /*uint256 updatedAt*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }
}

```

*Going through [[chain-link-functions]] can be helpful*

>[chain-link GitHub repository](https://github.com/smartcontractkit/chainlink/tree/develop)

`FundMe.sol`

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
contract FundMe{
	uint256 minimumUsd = 5;//5$
	function fund() public{
		require(msg.value >= minimumUsd,"Minimum abount is not enough");
	}
	function getPrice() public{
		//needs Address(0x694AA1769357215DE4FAC081bf1f309aDC325306) , ABI
		
		
	}
	function getConoversionRate() public{}
	function withdraw() public{}
}
```


for `ABI`

`AggregatorV3Interface.sol`  from the [github repo](https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol)

```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface AggregatorV3Interface {
	function decimals() external view returns (uint8);
	
	function description() external view returns (string memory);

	function version() external view returns (uint256);

	function getRoundData(uint80 _roundId) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

	function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}
```

`FundMe.sol`

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface AggregatorV3Interface {
	function decimals() external view returns (uint8);
	
	function description() external view returns (string memory);

	function version() external view returns (uint256);

	function getRoundData(uint80 _roundId) external view returns 
	(
	uint80 roundId, 
	int256 answer, 
	uint256 startedAt, 
	uint256 updatedAt, 
	uint80 answeredInRound
	);

	function latestRoundData() external view returns 
	(
	uint80 roundId, 
	int256 answer, 
	uint256 startedAt, 
	uint256 updatedAt, 
	uint80 answeredInRound
	);
}

contract FundMe{
	uint256 minimumUsd = 5;//5$
	function fund() public{
		require(msg.value >= minimumUsd,"Minimum abount is not enough");
	}
	function getPrice() public{
		//needs Address(0x694AA1769357215DE4FAC081bf1f309aDC325306) , ABI
		
		
	}
	function getVersion() public view returns (uint256){
		return AggregatorV3Interface
		(0x694AA1769357215DE4FAC081bf1f309aDC325306).version()
		//------------address-----------------------,methods
	}
	function getConoversionRate() public{}
	function withdraw() public{}
}
```

>importing the Aggregator. Interface from GitHub

from 
`DataConsumerV3.sol` 

```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
//,,,,,,,,,,,,,,remaining code ,..........
```

the import will be 

```sol
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
```

before using it we need to add an `npm` package `chainlink smart contracts` from [npm-chainlink](https://www.npmjs.com/package/@chainlink/contracts)

```bash
npm install @chainlink/contracts --save
```



`FundMe.sol`

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{
	uint256 minimumUsd = 5;//5$
	function fund() public payable{
		require(msg.value >= minimumUsd,"Minimum abount is not enough");
	}
	function getPrice() public{
		//needs Address(0x694AA1769357215DE4FAC081bf1f309aDC325306) , ABI
		
		
	}
	function getVersion() public view returns (uint256){
		return AggregatorV3Interface
		(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
		//------------address-----------------------,methods
	}
	function getConoversionRate() public{}
	function withdraw() public{}
}
```

>getting real-time pricing information

`getPrice`

```sol
function getPrice() public view returns (uint256){    //ETH-USD
		//needs Address(0x694AA1769357215DE4FAC081bf1f309aDC325306) , ABI
		AggregatorV3Interface priceFeed = AggregatorV3Interface
		(
		0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43 //address of contract
		);
		(,int256 price,,,) = priceFeed.latestRoundData();
	    return uint256(price*1e10);
	}
```

`FundMe.sol`

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{
	uint256 minimumUsd = 5;//5$
	
	function fund() public payable{
		require(msg.value >= minimumUsd,"Minimum abount is not enough");
	}
	
	function getPrice() public view returns (uint256){    //ETH-USD
		//needs Address(0x694AA1769357215DE4FAC081bf1f309aDC325306) , ABI
		AggregatorV3Interface priceFeed = AggregatorV3Interface
		(
		0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43 //address of contract
		);
		(,int256 price,,,) = priceFeed.latestRoundData();
	    return uint256(price*1e10);
	}
	function getConoversionRate() public{}
	function withdraw() public{}
}
```

why 
```sol
return uint256(price*1e10);
```

==*The Reason for Multiplying by 1e10==*
*==Price Feed Decimals vs. Ethereum Decimals==*

*==Chainlink Price Feed Format:==*

*==The Chainlink ETH/USD price feed returns the price with 8 decimal places==*
*==For example, if ETH is worth $3,000, the returned value would be 300000000000 (3000 * 10^8)==*


*==Ethereum's Standard:==*

*==Ethereum typically works with 18 decimal places for ETH (1 ETH = 10^18 wei)==*
*==To standardize calculations, it's common to convert the price feed to 18 decimals==*


*==Making Decimals Match:==*

*==10^18 ÷ 10^8 = 10^10 (or 1e10)==*
*==Multiplying by 1e10 converts the 8-decimal price to 18 decimals*

>Solidity math

`getConversionRate`

```sol
function getConversionRate(uint256 ethAmount) public view returns (uint256){
	//current ETH value in USD
	uint256 ethPrice = getPrice();
	//conversion of value to usd
	uint256 ethAmountInUsd = (ethPrice*ethAmount)/1e18;
	return ethAmountInUsd;
}
```

`FundMe.sol`

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{
	uint256 minimumUsd = 5e18;//5$
	
	function fund() public payable{
		require(getConversionRate(msg.value) >= minimumUsd,"Minimum abount is not enough");
	}
	
	function getPrice() public view returns (uint256){    //ETH-USD
		//needs Address(0x694AA1769357215DE4FAC081bf1f309aDC325306) , ABI
		AggregatorV3Interface priceFeed = AggregatorV3Interface
		(
		0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43 //address of contract
		);
		(,int256 price,,,) = priceFeed.latestRoundData();
	    return uint256(price*1e10);
	}
	
	function getConversionRate(uint256 ethAmount) public view returns (uint256){
		//current ETH value in USD
		uint256 ethPrice = getPrice();
		//conversion of value to usd
		uint256 ethAmountInUsd = (ethPrice*ethAmount)/1e18;
		return ethAmountInUsd;
	}
	function withdraw() public{}
}
```


>making an array to store the senders address 

```sol
address[] public funders;
mapping(address=>uint256) public addressToAmountFunded;
function fund() public payable{
	//..............req.....
	funders.push(msg.sender);
	addressToAmountFunded[msg.sender]+=msg.value;
}
```

using library for the functions

`PriceConverter.sol`

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
	function getPrice() internal view returns (uint256){    //ETH-USD
		//needs Address(0x694AA1769357215DE4FAC081bf1f309aDC325306) , ABI
		AggregatorV3Interface priceFeed = AggregatorV3Interface
		(
		0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43 //address of contract
		);
		(,int256 price,,,) = priceFeed.latestRoundData();
	    return uint256(price*1e10);
	}
	
	function getConversionRate(uint256 ethAmount) internal view returns (uint256){
		//current ETH value in USD
		uint256 ethPrice = getPrice();
		//conversion of value to usd
		uint256 ethAmountInUsd = (ethPrice*ethAmount)/1e18;
		return ethAmountInUsd;
	}
}
```


`FundMe.sol`

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

improt {PriceConverter} from "./PriceConverter.sol";

contract FundMe{

	//using library for functions
	using PriceConverter for uint256;   //all uint256 can access this lib

	uint256 minimumUsd = 5e18;//5$
	address[] public funders;
	mapping(address=>uint256) public addressToAmountFunded;
	
	function fund() public payable{
		require
		(
		msg.value.getConversionRate() >= minimumUsd,
		"Minimum abount is not enough"
		);
		funders.push(msg.sender);
		addressToAmountFunded[msg.sender]+=msg.value;
	}
	
	function withdraw() public{}
}
```

>Parameters in functions within libraries

```txt
msg.value.getConversionRate()
```

is same as

```txt
getConversionRate(msg.value)
```

and for second parameters 

```txt
msg.value.getConversionRate(a)
```

is same as 

```txt
getConversionRate(msg.value,a)
```


Safe math for coding in solidity [repository](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/Math.sol) but no longer followed after `solidity 0.8.0`


now for `withdraw` function

`withdraw`

```sol
function withdraw() public {
	for(uint256 funderIndex=0;funderIndex < funders.length;funderIndex++){
		address funder = funders[funderIndex];
		addressToAmountFunded[funder] = 0;
	}
	//reset funders
	funders = new address[](0);
	// withdraw funds(transfer,send,call)

	//transfer
	payable(msg.sender).transfer(address(this).balance);//this : contract
	
	//send
	bool sendStatus = payable(msg.sender).send(address(this).balance);
	//manual error handling
	require(sendStatus,"Transfer failed");
	
	//call(important)
	//{bool callSuccess,bytes memory dataReturned}=payable(msg.sender).call{value:address(this).balance}("")

	{bool callStatus}=payable(msg.sender).call{value:address(this).balance}("");
	require(callStatus,"Transfer failed");
	
}
```

[[sending and receiving methods]] 


`FundMe.sol`

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

improt {PriceConverter} from "./PriceConverter.sol";

contract FundMe{

	//using library for functions
	using PriceConverter for uint256;   //all uint256 can access this lib

	uint256 minimumUsd = 5e18;//5$
	address[] public funders;
	mapping(address=>uint256) public addressToAmountFunded;
	
	function fund() public payable{
		require
		(
		msg.value.getConversionRate() >= minimumUsd,
		"Minimum abount is not enough"
		);
		funders.push(msg.sender);
		addressToAmountFunded[msg.sender]+=msg.value;
	}
	function withdraw() public {
		for(uint256 funderIndex=0;funderIndex < funders.length;funderIndex++){
			address funder = funders[funderIndex];
			addressToAmountFunded[funder] = 0;
		}
		//reset funders
		funders = new address[](0);
		{bool callStatus}=payable(msg.sender).call{value:address(this).balance}("");
		require(callStatus,"Transfer failed");
	}
}
```

setting up the owner to withdraw the funds from the contracts

```sol
address public owner;
constructor(){
	owner = msg.sender;
}
```

```sol
function withdraw() public{
	require(msg.sender == owner ,"Only the owner can withdraw the funds");
}
```

>using modifiers

```sol
modifier onlyOwner(){
	require(msg.sender == owner ,"Only the owner can withdraw the funds");
	_;
	//goes to continue the next codes
}
```

```sol
function withdraw() public onlyOwner{
	//withdraw code 
}
```

*Note : if the `onlyOwner` is satisfied then the `withdraw` function part is continued by using `_;` in the modifier `onlyOwner` *

`withdraw`

```sol
function withdraw() public onlyOwner {
		for(uint256 funderIndex=0;funderIndex < funders.length;funderIndex++){
			address funder = funders[funderIndex];
			addressToAmountFunded[funder] = 0;
		}
		//reset funders
		funders = new address[](0);
		{bool callStatus}=payable(msg.sender).call{value:address(this).balance}("");
		require(callStatus,"Transfer failed");
}
```


Final `FundMe.sol`

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

improt {PriceConverter} from "./PriceConverter.sol";

contract FundMe{

	//using library for functions
	using PriceConverter for uint256;   //all uint256 can access this lib

	uint256 minimumUsd = 5e18;//5$
	address[] public funders;
	mapping(address=>uint256) public addressToAmountFunded;
	
	function fund() public payable{
		require
		(
		msg.value.getConversionRate() >= minimumUsd,
		"Minimum abount is not enough"
		);
		funders.push(msg.sender);
		addressToAmountFunded[msg.sender]+=msg.value;
	}
	
	function withdraw() public onlyOwner{
		for(uint256 funderIndex=0;funderIndex < funders.length;funderIndex++){
			address funder = funders[funderIndex];
			addressToAmountFunded[funder] = 0;
		}
		//reset funders
		funders = new address[](0);
		{bool callStatus}=payable(msg.sender).call{value:address(this).balance}("");
		require(callStatus,"Transfer failed");
	}

	modifier onlyOwner(){
		require(msg.sender == owner ,"Only owner can withdraw the funds");
		_;
		//goes to continue the next codes
	}
}
```

`PriceConverter.sol`

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
	function getPrice() internal view returns (uint256){    //ETH-USD
		//needs Address(0x694AA1769357215DE4FAC081bf1f309aDC325306) , ABI
		AggregatorV3Interface priceFeed = AggregatorV3Interface
		(
		0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43 //address of contract
		);
		(,int256 price,,,) = priceFeed.latestRoundData();
	    return uint256(price*1e10);
	}
	
	function getConversionRate(uint256 ethAmount) internal view returns (uint256){
		//current ETH value in USD
		uint256 ethPrice = getPrice();
		//conversion of value to usd
		uint256 ethAmountInUsd = (ethPrice*ethAmount)/1e18;
		return ethAmountInUsd;
	}
}
```

[`AggregatorV3Interface.sol`](https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol)


**Deployment**

![[Pasted image 20250510172338.png]]

>[Optimizing for Gas minimization:](https://claude.ai/public/artifacts/134d774f-b5ef-4aeb-adc1-2440cbec9135)

`FundMe.sol`

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

improt {PriceConverter} from "./PriceConverter.sol";

contract FundMe{

	//using library for functions
	using PriceConverter for uint256;   //all uint256 can access this lib

	uint256 public constant MINIMUM_USD = 5e18;//5$
	address[] public funders;
	mapping(address=>uint256) public addressToAmountFunded;
	address public immutable i_owner;

	constructor(){
		i_owner = msg.sender;
	}
	
	function fund() public payable{
		require
		(
		msg.value.getConversionRate() >= MINIMUM_USD,
		"Minimum abount is not enough"
		);
		funders.push(msg.sender);
		addressToAmountFunded[msg.sender]+=msg.value;
	}
	
	function withdraw() public onlyOwner{
		for(uint256 funderIndex=0;funderIndex < funders.length;funderIndex++){
			address funder = funders[funderIndex];
			addressToAmountFunded[funder] = 0;
		}
		//reset funders
		funders = new address[](0);
		{bool callStatus}=payable(msg.sender).call{value:address(this).balance}("");
		require(callStatus,"Transfer failed");
	}

	modifier onlyOwner(){
		require(msg.sender == i_owner ,"Only owner can withdraw the funds");
		_;
		//goes to continue the next codes
	}
}
```

- Custom Errors (much more efficient than `require`)

```sol
error NotOwner();

modifier onlyOwner(){
	if(msg.sender != i_owner){revert NotOwner();}
	_;
}
```

- receive() , fallback()

`FallbackExample.sol`

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
contract FallbackExample{
	uint256 public result;
	receive() external payable{
		result = 1;
	}
	fallback() external payable{
		ressult = 2;
	}
}
```

>Adding receive and fallback in `FundMe.sol`

`FundMe.sol`

```sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

improt {PriceConverter} from "./PriceConverter.sol";

contract FundMe{

	//using library for functions
	using PriceConverter for uint256;   //all uint256 can access this lib

	uint256 public constant MINIMUM_USD = 5e18;//5$
	address[] public funders;
	mapping(address=>uint256) public addressToAmountFunded;
	address public immutable i_owner;

	constructor(){
		i_owner = msg.sender;
	}
	
	function fund() public payable{
		require
		(
		msg.value.getConversionRate() >= MINIMUM_USD,
		"Minimum abount is not enough"
		);
		funders.push(msg.sender);
		addressToAmountFunded[msg.sender]+=msg.value;
	}
	
	function withdraw() public onlyOwner{
		for(uint256 funderIndex=0;funderIndex < funders.length;funderIndex++){
			address funder = funders[funderIndex];
			addressToAmountFunded[funder] = 0;
		}
		//reset funders
		funders = new address[](0);
		{bool callStatus}=payable(msg.sender).call{value:address(this).balance}("");
		require(callStatus,"Transfer failed");
	}

	modifier onlyOwner(){
		require(msg.sender == i_owner ,"Only owner can withdraw the funds");
		_;
		//goes to continue the next codes
	}
	receive() external payable{fund();}
	callback() external payable{fund();}
}
```

---
$$
COMPLETED
$$
---
Go to [[Foundry - smart contract framework]]
