// SPDX-License-Identifier: MIT
pragma solidity  0.8.19; //version information

// ^0.8.18 means 0.8.18 or grater versions of solidity
// (>=0.8.18,<0.9.0) means range

// SPDX-License-Identifier : MIT

// contract
contract SimpleStorage {
    // arrays and struct
    
    // Dynamic array - length is dynamic
    uint256[] arrayData;
    // Stateic array - length = 6
    uint256[6] arrayDataStatic;

    struct Person{      // type : Person
        // empty structs are not allowed
        uint256 age;
        string name;
    }
    // defining arrays for struct
    Person [] public listOfCollegues;
}
