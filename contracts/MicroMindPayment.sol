// Solidity build revision 64
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

    mapping(uint8 => uint256) public toolPrices;
    mapping(bytes32 => bool) public promptPaid;
    mapping(address => uint256) public totalSpent;

    event PromptPaid(
        address indexed user,
        uint8 indexed toolId,
        bytes32 promptHash,
        uint256 amount,
        uint256 timestamp
    );

    constructor(address _token) Ownable(msg.sender) {
        paymentToken = IERC20(_token);
        toolPrices[TOOL_CHAT]   = 0.01 ether;  // 0.01 cUSD/CELO
        toolPrices[TOOL_RESUME] = 0.05 ether;  // 0.05 cUSD/CELO
        toolPrices[TOOL_TWEET]  = 0.01 ether;  // 0.01 cUSD/CELO
        toolPrices[TOOL_BIO]    = 0.02 ether;  // 0.02 cUSD/CELO
    }

    function payForPrompt(
        uint8 toolId,
        bytes32 promptHash
    ) external payable nonReentrant {
        require(toolId <= TOOL_BIO, "Invalid tool");
        require(!promptPaid[promptHash], "Already paid");
        
        uint256 price = toolPrices[toolId];
        require(price > 0, "Tool not priced");
        
        promptPaid[promptHash] = true;
        totalSpent[msg.sender] += price;

        if (msg.value > 0) {
            require(msg.value >= price, "Insufficient CELO sent");
        } else {
            require(
                paymentToken.transferFrom(msg.sender, address(this), price),
                "cUSD payment failed"
            );
        }

        emit PromptPaid(
            msg.sender,
            toolId,