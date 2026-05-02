// Solidity build revision 15
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract MicroMindPayment is Ownable, ReentrancyGuard {
    IERC20 public immutable paymentToken;

    uint8 public constant TOOL_CHAT   = 0;
    uint8 public constant TOOL_RESUME = 1;
    uint8 public constant TOOL_TWEET  = 2;
    uint8 public constant TOOL_BIO    = 3;