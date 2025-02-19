// SPDX-License-Identifier: MIT
pragma solidity  0.8.19; //version information

// ^0.8.18 means 0.8.18 or grater versions of solidity
// (>=0.8.18,<0.9.0) means range

// SPDX-License-Identifier : MIT

// contract
contract SimpleStorage {
    // arrays and struct
    uint256[] arrayData;
    // struct : personalize our custom data type
    struct Person{      // type : Person
        // empty structs are not allowed
        uint256 age;
        string name;
    }
    // creating a Person variable
    Person public Collegue = Person(30,"Ava");
    // or
    Person public Collegue2 = Person({age:22,name:"John"});
    
}
