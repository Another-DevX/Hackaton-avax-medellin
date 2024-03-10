// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import "../interfaces/ITeleporterMessenger.sol";
import {ITeleporterReceiver} from "../interfaces/ITeleporterReceiver.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract DummyContract is ReentrancyGuard, ITeleporterReceiver {
    struct Message {
        address sender;
        string message;
    }

    mapping(bytes32 => Message) _messages;
    ITeleporterMessenger public immutable teleporterMessenger;

    constructor(address teleporterMessengerAddress) {
        teleporterMessenger = ITeleporterMessenger(teleporterMessengerAddress);
    }

    function receiveTeleporterMessage(
        bytes32 sourceBlockchainID,
        address originSenderAddress,
        bytes calldata message
    ) external {
        string memory messageString = abi.decode(message, (string));
        _messages[sourceBlockchainID] = Message(
            originSenderAddress,
            messageString
        );
    }
}
