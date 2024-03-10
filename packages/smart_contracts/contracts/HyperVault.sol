// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import "../interfaces/ITeleporterMessenger.sol";
import {ITeleporterReceiver} from "../interfaces/ITeleporterReceiver.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

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
        bytes message
    );

    struct FundMessage {
        address recipent;
        uint256 amount;
        address tokenAddress;
        uint8 functionId;
    }

    /**
     * @dev Emitted when a new message is received from a given chain ID.
     */
    event ReceiveMessage(
        bytes32 indexed sourceBlockchainID,
        address indexed originSenderAddress,
        string message
    );

    ITeleporterMessenger public immutable teleporterMessenger;
    bytes32 private destinationBlockchainID;
    address private destinationAddress;

    constructor(
        address teleporterMessengerAddress,
        bytes32 _destinationBlockchainID,
        address _destinationAddress
    ) {
        teleporterMessenger = ITeleporterMessenger(teleporterMessengerAddress);
        destinationBlockchainID = _destinationBlockchainID;
        destinationAddress = _destinationAddress;
    }

    function fund(address tokenAddress, uint256 amount) external {
        IERC20(tokenAddress).transferFrom(msg.sender, address(this), amount);
        FundMessage memory message = FundMessage({
            recipent: msg.sender,
            amount: amount,
            tokenAddress: tokenAddress,
            functionId: 1
        });

        sendMessage(100000, abi.encode(message));
    }

    function withdraw(
        address tokenAddress,
        address recipent,
        uint256 amount
    ) internal {
        IERC20(tokenAddress).transfer(recipent, amount);
    }

    function sendMessage(
        uint256 requiredGasLimit,
        bytes memory message
    ) internal returns (bytes32) {
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
                    message: message
                })
            );
    }

    function receiveTeleporterMessage(
        bytes32 sourceBlockchainID,
        address originSenderAddress,
        bytes calldata message
    ) external {
        bool success = abi.decode(message, (bool));
        require(success, "HyperVault: failed to send message");
        
    }
}
