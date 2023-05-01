// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import "@bnb-chain/greenfield-contracts-sdk/BucketApp.sol";
import "@bnb-chain/greenfield-contracts-sdk/ObjectApp.sol";
import "@bnb-chain/greenfield-contracts-sdk/GroupApp.sol";
import "@bnb-chain/greenfield-contracts-sdk/interface/IERC1155.sol";
import "@bnb-chain/greenfield-contracts-sdk/interface/IERC1155NonTransferable.sol";
import "@bnb-chain/greenfield-contracts-sdk/interface/IERC721NonTransferable.sol";

contract CopyrightShop is BucketApp, ObjectApp, GroupApp {

    // event
    event NewContract(address indexed _contractAddress, string _url, bytes32 _value);
    event AcceptContract(address indexed _contractAddress, string _url, bytes32 _value);

    // error code
    string constant ERROR_INVALID_CALLER = "invalid caller";
    string constant ERROR_INVALID_RESOURCE = "invalid resource";
    string constant ERROR_INVALID_OPERATION = "invalid operation";
    string constant ERROR_INSUFFICIENT_VALUE = "insufficient value";

    address public owner;
    
    
     // system contract
    address public bucketToken;
    address public objectToken;
    address public groupToken;
    address public memberToken;

    // struct
    struct Contract {
        string url;
        bytes32 value;
    }

    Contract private contractInfo;

    // mapping
    mapping(Contract => mapping(address => bool)) private contractMap;

    // modifier
    modifier onlyOwner() {
        require(msg.sender == owner, string.concat("Copyright: ", ERROR_INVALID_CALLER));
        _;
    }

    modifier onlyContract() {
        require(contractMap[contractInfo][msg.sender], string.concat("Contract: ", ERROR_INVALID_CALLER));
        _;
    }


    function createContainer(
        string calldata name,
        BucketStorage.BucketVisibilityType visibility,
        uint64 chargedReadQuota,
        address spAddress,
        uint256 expireHeight,
        bytes calldata sig
    ) internal onlyOwner{
        require(bytes(name).length > 0, "name is empty");

        bytes memory _callbackData = bytes(name);
        _createBucket(msg.sender, name, visibility, chargedReadQuota, spAddress, expireHeight, sig, _callbackData);
    }
    
    function createCopyright()external{
        require(
            IERC721NonTransferable(objectToken).ownerOf(_ebookId) == msg.sender,
            string.concat("EbookShop: ", ERROR_INVALID_CALLER)
        );
        require(ebookGroup[_ebookId] != 0, string.concat("EbookShop: ", ERROR_GROUP_NOT_EXISTED));
        require(price > 0, string.concat("EbookShop: ", ERROR_INVALID_PRICE));

        ebookPrice[_ebookId] = price;
        IERC1155(ebookToken).mint(msg.sender, _ebookId, 1, "");
    }

    function greenfieldCall(
        uint32 status,
        uint8 resoureceType,
        uint8 operationType,
        uint256 resourceId,
        bytes calldata callbackData
    ) external override(BucketApp, ObjectApp, GroupApp) {
        require(msg.sender == crossChain, string.concat("Copyright: ", ERROR_INVALID_CALLER));

        if (resoureceType == RESOURCE_BUCKET) {
            _bucketGreenfieldCall(status, operationType, resourceId, callbackData);
        } else if (resoureceType == RESOURCE_OBJECT) {
            _objectGreenfieldCall(status, operationType, resourceId, callbackData);
        } else if (resoureceType == RESOURCE_GROUP) {
            _groupGreenfieldCall(status, operationType, resourceId, callbackData);
        } else {
            revert(string.concat("Copyright: ", ERROR_INVALID_RESOURCE));
        }
    }

    function initNewContract(address _contractAddress, string calldata _url, string calldata value) external onlyOwner {
        contractInfo = Contract(_url, keccak256(abi.encodePacked(_value)));
        contractMap[contractInfo][_contractAddress] = true;
        emit NewContract(_contractAddress, _url, _value);
    }

    function acceptContract(string calldata value) external onlyOwner {
        require(contractInfo.value == keccak256(abi.encodePacked(_value)), string.concat("Contract: ", ERROR_INVALID_VALUE));
        contractMap[contractInfo][_contractAddress] = true;
        emit AcceptContract(_contractAddress, _url, _value);
    }

    function getContract(address _contractAddress) external view returns (string memory, bytes32) {
        require(contractMap[contractInfo][_contractAddress], string.concat("Contract: ", ERROR_INVALID_CALLER));
        return (contractInfo.url, contractInfo.value);
    }

    function acceptedContract(address _contractAddress) external view returns (bool) {
        return contractMap[contractInfo][_contractAddress];
    }
}