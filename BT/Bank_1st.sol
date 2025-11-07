// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank{
    // dpv
    mapping(address => uint) private balances;

    function createAccount() public {
        balances[msg.sender] = 0;
    }

    function depositeEth(uint amount) public {
        balances[msg.sender] += amount;
    }

    function withdrawEth(uint amount) public {
        require(amount <= balances[msg.sender], "Insufficient");
        balances[msg.sender] -= amount;
    }

    function transferEth(address receiver, uint amount) public {
        require(amount <= balances[msg.sender], "Insufficient");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
    }

    function getBalance() public view returns(uint eth) {
        return balances[msg.sender];
    }
}

Line-by-line & behavior

mapping(address => uint) private balances;
Stores a non-negative integer balance for each account (address → uint). Default for any address not yet set is 0.

createAccount()
Sets balances[msg.sender] = 0. Practically this is redundant because a new address already has a default balance of 0. It may be used to signal intent, but it doesn’t mark existence separately.

depositeEth(uint amount)
Adds the numeric amount to the caller’s stored balances. Important: this function is not payable and does not receive real Ether. It just updates the mapping with whatever number the caller passes. Example: depositeEth(100) sets their internal balance +100 — no ETH moved.

withdrawEth(uint amount)
Reduces the stored mapping balance if sufficient. Again, it does not send any Ether back. It just decrements the internal number.

transferEth(address receiver, uint amount)
Moves internal balance numbers from msg.sender to receiver by updating the mapping only. No real ETH transfer.

getBalance()
Returns the internal stored balance for msg.sender.


use this code 


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
contract Bank {
    mapping(address => uint) private balances;
    event Deposit(address indexed account, uint amount);
    event Withdrawal(address indexed account, uint amount);
    function deposit(uint amount) public {
        require(amount > 0, "Amount must be greater than zero.");
        balances[msg.sender] += amount;
        emit Deposit(msg.sender, amount);
    }
    function withdraw(uint amount) public {
        require(amount > 0, "Amount must be greater than zero.");
        require(balances[msg.sender] >= amount, "Insufficient balance.");
        balances[msg.sender] -= amount;
        emit Withdrawal(msg.sender, amount);
    }
    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }
}

What it does differently / improvements

Adds event Deposit and event Withdrawal. Events are great: they produce logs you can inspect in Remix or Etherscan; useful for off-chain UIs and auditing.

Has the same virtual balance model as the first contract: deposit(amount) accepts a numeric parameter, not Ether.

Adds validation require(amount > 0) — prevents zero-value nonsense.

Emits events on success so you can see deposit/withdraw transactions in logs.

Practical behavior

Call deposit(50) → internal mapping increased by 50, Deposit event emitted. No Ether moves.

Call withdraw(20) → mapping decreased by 20 if check passes, Withdrawal event emitted.