// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import "../interfaces/ITeleporterMessenger.sol";
import {ITeleporterReceiver} from "../interfaces/ITeleporterReceiver.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract DummyContract is ReentrancyGuard, ITeleporterReceiver {
    struct FundMessage {
        address recipent;
        uint256 amount;
        address tokenAddress;
        uint8 functionId;
    }

    mapping(address => FundMessage) public _messages;
    ITeleporterMessenger public immutable teleporterMessenger;

    constructor(address teleporterMessengerAddress) {
        teleporterMessenger = ITeleporterMessenger(teleporterMessengerAddress);
    }

    function receiveTeleporterMessage(
        bytes32 sourceBlockchainID,
        address originSenderAddress,
        bytes calldata message
    ) external {
        FundMessage memory messageDecoded = abi.decode(message, (FundMessage));
        _messages[originSenderAddress] = FundMessage(
            messageDecoded.recipent,
            messageDecoded.amount,
            messageDecoded.tokenAddress,
            messageDecoded.functionId
        );
    }
}

