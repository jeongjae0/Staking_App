// stake: Lock tokens into our smart contract
// withdraw: unlock tokens and pull out of the contract
// claimReward: users get their reward tokens
// what's a good reward math?

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

error Staking__TransferFailed();

contract Staking {
    IERC20 public s_stakingToken;

    mapping(address => uint256) public s_balances;

    uint256 public s_totalSupply;

    constructor(address stakingToken) {
        s_stakingToken = IERC20(stakingToken);
    }

    // any tokens? or just a specific token?
    // Chainlink stuff to convert prices - more than 2 tokens
    function stake(uint256 amount) external {
        s_balances[msg.sender] = s_balances[msg.sender] + amount;
        s_totalSupply = s_totalSupply + amount;
        bool success = s_stakingToken.transferFrom(msg.sender, address(this), amount);
        if (!success) {
            revert Staking__TransferFailed();
        }
    }
}