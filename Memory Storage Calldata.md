## Data Locations

1. **Calldata** - Temporary storage locations for variables during function execution (read-only).
2. **Memory** - Temporary storage locations for variables during function execution (read-write).
3. **Storage**
4. **Stack**
5. **Code**
6. **Logs**

To modify `calldata` variables, they must first be loaded into `memory`.

Most variable types default to `memory` automatically. However, for strings, you must specify either `memory` or `calldata` due to the way arrays are handled in memory.

```solidity
string memory variableName = "solidity";
```

### Calldata
"Cannot be manipulated"

```solidity
contract SimpleStorage {
    // Struct definition
    struct Person {
        string name;
        uint256 age;
    }
    
    // Defining an array for struct
    Person[] public listOfColleagues;
    
    // Method - 1:
    function addPerson(string calldata _name, uint256 _age) public {
        string memory tempName = _name; // Cannot modify calldata directly, so store in memory first
        tempName = "solidity";
        listOfColleagues.push(Person(tempName, _age)); // Items will be added from the 0 index
    }
}
```

### Storage
Variables stored in `storage` are persistent on the blockchain, retaining their values between function calls and transactions.

In Solidity, a `string` is recognized as an **array of bytes**. On the other hand, primitive types like `uint256` have built-in mechanisms that dictate how and where they are stored, accessed, and manipulated.

> You can't use the `storage` keyword for variables inside a function. Only `memory` and `calldata` are allowed here, as the variable only exists temporarily.

