// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Protocol {
    struct RequestMessage {
        address user;
        address recipent;
        address tokenAddress;
        uint256 amount;
        uint8 functionId;
        uint8 requestId;
    }
}
