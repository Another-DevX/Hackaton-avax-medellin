// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "../interfaces/ITeleporterMessenger.sol";
import {ITeleporterReceiver} from "../interfaces/ITeleporterReceiver.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import {Protocol} from "../structs/Protocol.sol";
import { FaFileImage } from "react-icons/fa6";


contract HyperVaultManager is
    ReentrancyGuard,
    ITeleporterReceiver,
    Protocol
{
    mapping(address => mapping(address => uint256)) public balances;
    mapping(address => uint8) public allowedTokensDecimalPlaces;
    mapping(address => RequestMessage) public _messages;

    address public owner;
    ITeleporterMessenger public immutable teleporterMessenger;
    bytes32 public destinationBlockchainID;
    address public destinationAddress;

    modifier onlyOwner() {
        require(msg.sender == owner, "Must be owner");
        _;
    }

    constructor(
        address teleporterMessengerAddress,
        bytes32 _destinationBlockchainID
    ) {
        teleporterMessenger = ITeleporterMessenger(teleporterMessengerAddress);
        destinationBlockchainID = _destinationBlockchainID;
        owner = msg.sender;
    }
    //Register HyperVault address
    function addDestinationAddress(
        address _destinationAddress
    ) external onlyOwner {
        destinationAddress = _destinationAddress;
    }

    function addToken(address token, uint8 decimals) external onlyOwner {
        allowedTokensDecimalPlaces[token] = decimals;
    }

    function fund(address recipient, address token, uint256 ammount) internal {}

    function withdraw(
        address recipient,
        address token,
        uint256 ammount
    ) internal {}


    function receiveTeleporterMessage(
        bytes32 sourceBlockchainID,
        address originSenderAddress,
        bytes calldata message
    ) external {
        RequestMessage memory request = abi.decode(message, (RequestMessage));
        //Add funds
        if (request.functionId == 1) {
            require(
                allowedTokensDecimalPlaces[request.tokenAddress] > 0,
                "Not allowed token"
            );
            balances[request.user][request.tokenAddress] += request.amount;
        } 
        //Wwithdraw
        else if (request.functionId == 2) {
            require(
                allowedTokensDecimalPlaces[request.tokenAddress] > 0,
                "Not allowed token"
            );
            require(
                balances[request.user][request.tokenAddress] >= request.amount,
                "Not enough balance"
            );
            balances[request.user][request.tokenAddress] -= request.amount;
        } 
        //Transfer
        else if (request.functionId == 3) {             
            require(
                balances[request.user][request.tokenAddress] >= request.amount,
                "Not enough balance"
            );
            balances[request.user][request.tokenAddress] -= request.amount;
            balances[request.recipent][request.tokenAddress] += request.amount;

        }
        RequestMessage memory decodedMessage = RequestMessage(
            request.user,
            request.recipent,
            request.tokenAddress,
            request.amount,
            request.functionId,
            request.requestId
        );
        _messages[originSenderAddress] = decodedMessage;
        sendMessage(abi.encode(decodedMessage));
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
