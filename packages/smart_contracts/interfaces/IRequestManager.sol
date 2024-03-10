// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract RequestManager {
    struct RequestMessage {
        address user;
        address tokenAddress;
        uint256 amount;
        uint8 functionId;
    }
}
