// SPDX-License-Identifier: MIT
pragma solidity  0.8.19; //version information

// ^0.8.18 means 0.8.18 or grater versions of solidity
// (>=0.8.18,<0.9.0) means range

// SPDX-License-Identifier : MIT
contract SimpleStorage {
    struct Person{
        string name;
        uint256 age;
    }
    Person [] public listOfCollegues;
    // careating a mapping function from name to age 
    // default value of a mapping is 0
    mapping (string => uint256) public nameMapsAge;
    // function---
    function addPerson(string calldata _name , uint256 _age) public {
        listOfCollegues.push(Person(_name,_age));   // items will be added from the 0 index
        // adding mapping functionality by name to age
        nameMapsAge[_name] = _age;
    }
}
