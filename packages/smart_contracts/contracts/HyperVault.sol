// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import "../interfaces/ITeleporterMessenger.sol";
import {ITeleporterReceiver} from "../interfaces/ITeleporterReceiver.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract HyperVault is ReentrancyGuard, ITeleporterReceiver {
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

    ITeleporterMessenger public immutable teleporterMessenger;
    bytes32 private destinationBlockchainID;

    constructor(
        address teleporterMessengerAddress,
        bytes32 _destinationBlockchainID
    ) {
        teleporterMessenger = ITeleporterMessenger(teleporterMessengerAddress);
        destinationBlockchainID = _destinationBlockchainID;
    }

    function sendMessage(
        address destinationAddress,
        uint256 requiredGasLimit,
        string calldata message
    ) external returns (bytes32 messageID) {
        emit SendMessage({
            destinationBlockchainID: destinationBlockchainID,
            destinationAddress: destinationAddress,
            feeTokenAddress: address(0),
            feeAmount: 0,
            requiredGasLimit: requiredGasLimit,
            message: message
        });
        return
            teleporterMessenger.sendCrossChainMessage(
                TeleporterMessageInput({
                    destinationBlockchainID: destinationBlockchainID,
                    destinationAddress: destinationAddress,
                    feeInfo: TeleporterFeeInfo({
                        feeTokenAddress: address(0),
                        amount: 0
                    }),
                    requiredGasLimit: requiredGasLimit,
                    allowedRelayerAddresses: new address[](0),
                    message: abi.encode(message)
                })
            );
    }

    function receiveTeleporterMessage(
        bytes32 sourceBlockchainID,
        address originSenderAddress,
        bytes calldata message
    ) external {}
}
