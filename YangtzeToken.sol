// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract YangtzeToken is ERC20, Ownable {
    uint256 public lockUntil;
    address public treasuryAddress;

    uint256 public constant TEAM_ALLOCATION = 2_000_000 * 10**18;
    uint256 public constant PUBLIC_ALLOCATION = 8_000_000 * 10**18;

    event TreasuryTokensMoved(address indexed to, uint256 amount);
    event TreasuryTokensBurned(uint256 amount);
    event TreasuryAddressUpdated(address indexed oldTreasury, address indexed newTreasury);

    constructor(address _treasuryAddress)
        ERC20("Yangtze Eco Rights Token", "YERT")
        Ownable(msg.sender)
    {
        require(_treasuryAddress != address(0), "Invalid treasury address");

        treasuryAddress = _treasuryAddress;
        lockUntil = block.timestamp + 365 days;

        _mint(msg.sender, PUBLIC_ALLOCATION);
        _mint(treasuryAddress, TEAM_ALLOCATION);
    }

    modifier onlyAfterLock() {
        require(block.timestamp >= lockUntil, "Treasury tokens are locked");
        _;
    }

    function updateTreasuryAddress(address newTreasury) external onlyOwner {
        require(newTreasury != address(0), "Invalid treasury address");
        address oldTreasury = treasuryAddress;
        treasuryAddress = newTreasury;
        emit TreasuryAddressUpdated(oldTreasury, newTreasury);
    }

    function moveTreasuryTokens(address to, uint256 amount)
        external
        onlyOwner
        onlyAfterLock
    {
        require(to != address(0), "Invalid recipient");
        require(balanceOf(treasuryAddress) >= amount, "Insufficient treasury balance");

        _transfer(treasuryAddress, to, amount);
        emit TreasuryTokensMoved(to, amount);
    }

    function burnTreasuryTokens(uint256 amount)
        external
        onlyOwner
        onlyAfterLock
    {
        require(amount > 0, "Amount must be greater than 0");
        require(balanceOf(treasuryAddress) >= amount, "Insufficient treasury balance");

        _burn(treasuryAddress, amount);
        emit TreasuryTokensBurned(amount);
    }

    function getLockRemaining() external view returns (uint256) {
        if (block.timestamp >= lockUntil) {
            return 0;
        }
        return lockUntil - block.timestamp;
    }
}
