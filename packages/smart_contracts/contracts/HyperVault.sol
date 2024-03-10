// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import "../interfaces/ITeleporterMessenger.sol";
import {ITeleporterReceiver} from "../interfaces/ITeleporterReceiver.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import {RequestManager} from "../interfaces/IRequestManager.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract HyperVault is ReentrancyGuard, ITeleporterReceiver, RequestManager {
    ITeleporterMessenger public immutable teleporterMessenger;
    bytes32 public destinationBlockchainID;
    address public destinationAddress;
    mapping(address => RequestMessage) public _messages;
    constructor(
        address teleporterMessengerAddress,
        bytes32 _destinationBlockchainID,
        address _destinationAddress
    ) {
        teleporterMessenger = ITeleporterMessenger(teleporterMessengerAddress);
        destinationBlockchainID = _destinationBlockchainID;
        destinationAddress = _destinationAddress;
    }

    function requestFund(address tokenAddress, uint256 amount) external {
        require(
            IERC20(tokenAddress).balanceOf(msg.sender) >= amount,
            "Not enough funds!"
        );
        require(
            IERC20(tokenAddress).allowance(msg.sender, address(this)) >= amount,
            "Not enough allowance!"
        );
        RequestMessage memory message = RequestMessage({
            user: msg.sender,
            tokenAddress: tokenAddress,
            amount: amount,
            functionId: 1
        });
        sendMessage(abi.encode(message));
    }

    function requestWithdraw(address tokenAddress, uint256 amount) external {
        RequestMessage memory message = RequestMessage({
            user: msg.sender,
            tokenAddress: tokenAddress,
            amount: amount,
            functionId: 2
        });
        sendMessage(abi.encode(message));
    }

    function fund(address tokenAddress, address user, uint256 amount) public {
        IERC20(tokenAddress).transferFrom(user, address(this), amount);
    }

    function withdraw(
        address tokenAddress,
        address user,
        uint256 amount
    ) public {
        IERC20(tokenAddress).transfer(user, amount);
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
                    requiredGasLimit: 1000000,
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
        RequestMessage memory request = abi.decode(message, (RequestMessage));
        RequestMessage memory decodedMessage = RequestMessage(
            request.user,
            request.tokenAddress,
            request.amount,
            request.functionId
        );

        if (request.functionId == 1) {
            fund(request.tokenAddress, request.user, request.amount);
        } else {
            withdraw(request.tokenAddress, request.user, request.amount);
        }
    }
}
