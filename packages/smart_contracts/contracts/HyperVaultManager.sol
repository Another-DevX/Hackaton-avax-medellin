// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "../interfaces/ITeleporterMessenger.sol";
import {ITeleporterReceiver} from "../interfaces/ITeleporterReceiver.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract HyperVaultManager is ReentrancyGuard, ITeleporterReceiver {
    struct RequestMessage {
        address user;
        address tokenAddress;
        uint256 amount;
        uint8 functionId;
    }

    mapping(address => mapping(address => uint256)) private balances;
    mapping(address => uint256) private allowedTokensDecimalPlaces;

    address public owner;
    ITeleporterMessenger public immutable teleporterMessenger;
    bytes32 private destinationBlockchainID;
    address private destinationAddress;

    modifier onlyOwner() {
        require(msg.sender == owner, "Must be owner");
        _;
    }

    constructor(
        address teleporterMessengerAddress,
        bytes32 _destinationBlockchainID,
        address _destinationAddress
    ) {
        teleporterMessenger = ITeleporterMessenger(teleporterMessengerAddress);
        destinationBlockchainID = _destinationBlockchainID;
        destinationAddress = _destinationAddress;
        owner = msg.sender;
    }

    function addToken(address token, uint256 ammount) external onlyOwner {
        allowedTokensDecimalPlaces[token] = ammount;
    }

    function fund(address recipient, address token, uint256 ammount) internal {}

    function withdraw(
        address recipient,
        address token,
        uint256 ammount
    ) internal {}

    function transfer(
        address sender,
        address recipient,
        address token,
        uint256 ammount
    ) external {
        require(balances[sender][token] >= ammount);
        balances[sender][token] -= ammount;
        balances[recipient][token] += ammount;
    }

    function receiveTeleporterMessage(
        bytes32 sourceBlockchainID,
        address originSenderAddress,
        bytes calldata message
    ) external {
        RequestMessage memory request = abi.decode(message, (RequestMessage));
        if (request.functionId == 1) {
            require(allowedTokensDecimalPlaces[token] > 0, "Not allowed token");
            balances[recipient][token] += ammount;
        } else {
            require(allowedTokensDecimalPlaces[token] > 0, "Not allowed token");
            require(
                balances[recipient][token] >= ammount,
                "Not enough balance"
            );
            balances[recipient][token] -= ammount;
        }
        sendMessage(abi.encode(message));
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
}
