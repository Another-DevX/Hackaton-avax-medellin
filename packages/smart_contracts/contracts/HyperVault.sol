// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import "../interfaces/ITeleporterMessenger.sol";
import {ITeleporterReceiver} from "../interfaces/ITeleporterReceiver.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract HyperVault is ReentrancyGuard, ITeleporterReceiver {
    struct FundMessage {
        address recipent;
        uint256 amount;
        address tokenAddress;
        uint8 functionId;
    }

    struct WithdrawRequest {
        address tokenAddress;
        uint256 amount;
        address user;
        uint8 functionId;
    }

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

        sendMessage(abi.encode(message));
    }

    function requestWithdraw(address tokenAddress, uint256 amount) external {
        WithdrawRequest memory message = WithdrawRequest({
            tokenAddress: tokenAddress,
            amount: amount,
            user: msg.sender,
            functionId: 2
        });
        sendMessage(abi.encode(message));
    }

    function withdraw(
        address tokenAddress,
        address recipent,
        uint256 amount
    ) internal {
        IERC20(tokenAddress).transfer(recipent, amount);
    }

    function sendMessage(bytes memory message) internal returns (bytes32) {
        return
            teleporterMessenger.sendCrossChainMessage(
                TeleporterMessageInput({
                    destinationBlockchainID: destinationBlockchainID,
                    destinationAddress: destinationAddress,
                    feeInfo: TeleporterFeeInfo({
                        feeTokenAddress: address(0),
                        amount: 0
                    }),
                    requiredGasLimit: 100000,
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
        WithdrawRequest memory withdrawRequest = abi.decode(
            message,
            (WithdrawRequest)
        );
        withdraw(
            withdrawRequest.tokenAddress,
            withdrawRequest.user,
            withdrawRequest.amount
        );
    }
}
