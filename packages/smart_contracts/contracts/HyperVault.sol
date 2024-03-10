// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import {ITeleporterMessenger, TeleporterMessageInput, TeleporterFeeInfo} from "@teleporter/ITeleporterMessenger.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts@4.8.1/security/ReentrancyGuard.sol";
import {ITeleporterReceiver} from "@teleporter/ITeleporterReceiver.sol";

/**
 * @dev Emitted when a message is submited to be sent.
 */
event SendMessage(
    bytes32 indexed destinationBlockchainID,
    address indexed destinationAddress,
    address feeTokenAddress,
    uint256 feeAmount,
    uint256 requiredGasLimit,
    string message
);

/**
 * @dev Emitted when a new message is received from a given chain ID.
 */
event ReceiveMessage(
    bytes32 indexed sourceBlockchainID,
    address indexed originSenderAddress,
    string message
);

  struct Message {
        address sender;
        string message;
    }


contract HyperVault is ReentrancyGuard, ITeleporterReceiver {
  
     ITeleporterMessenger public immutable teleporterMessenger;

    constructor(address teleporterMessengerAddress) {
        teleporterMessenger = ITeleporterMessenger(teleporterMessengerAddress);
    }

    function sendMessage(bytes32 destinationBlockchainID, address destinationAddress, address feeTokenAddress, uint256 feeAmount, uint256 requiredGasLimit, string calldata message) external returns (bytes32 messageID) {

    }

    function receiveTeleporterMessage(bytes32 sourceBlockchainID, address originSenderAddress, bytes calldata message) external {

    }

    
}
