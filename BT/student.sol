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