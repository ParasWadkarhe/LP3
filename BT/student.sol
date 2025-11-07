// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract studentRegistry{
    struct Student{
        string  name; 
        uint256  age;
    }

    Student[] public students;

    event ReceivedEther(address sender, uint amount);

    receive() external payable {emit ReceivedEther(msg.sender, msg.value);}
    fallback() external payable {emit ReceivedEther(msg.sender, msg.value);}

    function addStudent(string memory name, uint age) public {
        students.push(Student(name, age));
    }

    function getStudent(uint index) public view returns(string memory name, uint256 age) {
        require(index < students.length, "invalid index");
        return (students[index].name, students[index].age);
    }

    function countStudent() public view returns(uint studentCount) {
        return students.length;
    }
}


// SPDX-License-Identifier: MIT
License identifier required by many tools.

pragma solidity ^0.8.0;
Compiler directive: requires Solidity compiler version 0.8.0 or newer (but <0.9.0).

contract studentRegistry{ ... }
Declares the contract named studentRegistry. (Style note: Solidity convention is StudentRegistry in PascalCase.)

struct Student{ string name; uint256 age; }
Defines a Student data structure with two fields:

name — a dynamic string.

age — a uint256 (unsigned integer).

Student[] public students;
A dynamic array stored in contract storage that holds Student structs. Declared public so the compiler creates an automatic getter:

students(uint256 index) getter returns the tuple (string, uint256) for that index.

There is no automatic function that returns the whole array; you query elements by index.

event ReceivedEther(address sender, uint amount);
Declares an event that will be emitted whenever the contract receives Ether. Events are recorded in the transaction logs (useful for off-chain listeners/UIs).

receive() external payable { emit ReceivedEther(msg.sender, msg.value); }
The special receive function:

Triggered when Ether is sent to the contract without any calldata (plain transfer).

Marked payable so it can accept Ether.

Emits the ReceivedEther event with msg.sender and msg.value (amount in wei).

fallback() external payable { emit ReceivedEther(msg.sender, msg.value); }
The fallback function:

Called when calldata does not match any existing function signatures or when someone deliberately calls a non-existent function.

Because it is payable, it also accepts Ether sent with unknown calldata.

Here it also emits the same event.

function addStudent(string memory name, uint age) public { students.push(Student(name, age)); }
Adds a new Student to the students array:

name is a string passed in memory (temporary during call).

age is a uint (same as uint256 in this compiler).

students.push(...) writes the struct into contract storage (this operation consumes gas, especially because string storage is expensive).

function getStudent(uint index) public view returns(string memory name, uint256 age) { require(index < students.length, "invalid index"); return (students[index].name, students[index].age); }

view function (doesn’t change state) that returns the name and age of the student at index.

require(index < students.length, "invalid index") protects against out-of-bounds access (reverts the call if invalid).

Returns a string memory and uint256.

function countStudent() public view returns(uint studentCount) { return students.length; }
Returns the number of students stored. (Naming: countStudents() or getStudentCount() is more idiomatic.)

Call addStudent("abc", 21)

In the function input box type: abc, 21 or "abc", 21 (strings should be quoted).

Click transact. The transaction will store the student and consume gas.

Call countStudent()

Returns 1.

Call getStudent(0)

Input 0. Returns ("abc", 21).

Calling getStudent(1) (when only index 0 exists)

Reverts with "invalid index".

Send Ether to contract (to hit receive()):

In Remix top right “Value” put 0.1 Ether, select the account, then click the Transact button (without selecting a function). The receive() function will be called and ReceivedEther event will appear in logs.

Call an unknown function (to hit fallback()):

Use the low-level interface or invoke a non-existent function signature — because fallback is payable, it will accept Ether (if provided) and emit ReceivedEther.

Viewing gas & tx info:

After each transaction, click the transaction link in Remix console. You will see gasUsed, effectiveGasPrice, transactionCost etc.