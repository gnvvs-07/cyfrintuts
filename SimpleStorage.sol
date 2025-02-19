// SPDX-License-Identifier: MIT
pragma solidity  0.8.19; //version information

// ^0.8.18 means 0.8.18 or grater versions of solidity
// (>=0.8.18,<0.9.0) means range

// SPDX-License-Identifier : MIT

// contract
contract SimpleStorage {

    // arrays and struct
    struct Person{
        string name;
        uint256 age;
    }

    // defining arrays for struct
    Person [] public listOfCollegues;

    // Method - 1:
    function addPerson(string memory name , uint256 age) public {
        Person memory Friend = Person(name,age);
        // push the created person to the list
        listOfCollegues.push(Friend);   // items will be added from the 0 index
    }

    // Method - 2:
    function addPersonType2(string memory name , uint256 age) public {
        listOfCollegues.push(Person(name,age));
    }
}
