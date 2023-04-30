//SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract CopyrightNFT is ERC721, Ownable, ERC721Enumerable, ERC721URIStorage{

    constructor () ERC721("CopyrightNFT", "CNFT") {
    }

    function mint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/";
    }

    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    function tokenURI(uint256 tokenId) public view virtual override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, ERC721Enumerable, AccessControlEnumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _burn(uint256 tokenId) internal virtual override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function _transfer(address from, address to, uint256 tokenId) internal virtual override(ERC721, ERC721Enumerable) {
        super._transfer(from, to, tokenId);
    }

    function _exists(uint256 tokenId) internal view virtual override(ERC721, ERC721Enumerable) returns (bool) {
        return super._exists(tokenId);
    }

    function _safeMint(address to, uint256 tokenId) internal virtual override(ERC721, ERC721URIStorage) {
        super._safeMint(to, tokenId);
    }

    function _safeMint(address to, uint256 tokenId, bytes memory _data) internal virtual override(ERC721, ERC721URIStorage) {
        super._safeMint(to, tokenId, _data);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, bytes memory _data) internal virtual override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId, _data);
    }

}