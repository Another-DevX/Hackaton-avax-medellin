// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../interfaces/ITeleporterMessenger.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract Mystic is ERC721, Ownable {
    ITeleporterMessenger public immutable teleporterMessenger;
    bytes32 private destinationBlockchainID;
    address private destinationAddress;
    address private tokenAddress;

    struct Request {
        address to;
        address tokenAddress;
        uint256 amount;
        uint8 functionId;
    }

    constructor(
        address teleporterMessengerAddress,
        bytes32 _destinationBlockchainID,
        address _destinationAddress,
        address _tokenAddress
    ) ERC721("Mystic", "MTC") Ownable() {
        teleporterMessenger = ITeleporterMessenger(teleporterMessengerAddress);
        destinationBlockchainID = _destinationBlockchainID;
        destinationAddress = _destinationAddress;
        tokenAddress = _tokenAddress;
    }

    function _baseURI() internal pure override returns (string memory) {
        return
            "https://ipfs.io/ipfs/QmZkF5gsnYHu3nrxvD3GNZ1YVvwx8sysWLTnB1or1tuWsr";
    }

    function preMint() public {
        Request memory message = Request({
            to: msg.sender,
            tokenAddress: tokenAddress,
            amount: 10000000000000000000,
            functionId: 3
        });

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

    function receiveTeleporterMessage(
        bytes32 sourceBlockchainID,
        address originSenderAddress,
        bytes calldata message
    ) external {
        Request memory withdrawRequest = abi.decode(message, (Request));
        _safeMint(withdrawRequest.to, 0);
    }
}
