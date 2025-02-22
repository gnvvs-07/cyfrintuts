# Deploying a contract from another contract

## SimpleStorage and StorageFactory Contracts

### StorageFactory Contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {SimpleStorage} from "./SimpleStorage.sol";  //Destructuring the contracts import

contract StorageFactory{
        // creating a variable for SimpleStorage contract
        SimpleStorage public simpleStorage; // variable name is simpleStorage (small `s`) blue
        function createSimpleStorageContract() public {         // oragne
            simpleStorage = new SimpleStorage();                // blue
        }
}

```

### SimpleStorage contract

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract SimpleStorage {
    uint256 myFavoriteNumber;

    struct Person {
        uint256 favoriteNumber;
        string name;
    }
    // uint256[] public anArray;
    Person[] public listOfPeople;

    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public virtual {
        myFavoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return myFavoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}

contract SimepleStorage2 {}

contract SimepleStorage3 {}
```
