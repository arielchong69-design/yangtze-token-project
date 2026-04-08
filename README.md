# Yangtze Eco Rights Token (YERT)

## Project Overview
This project implements an ERC-20 token named **Yangtze Eco Rights Token (YERT)** on the Ethereum Sepolia test network.  
The token is designed to represent ecological revenue rights and includes basic treasury management and token burning functionality.

---

## Smart Contract Details
- **Token Name:** Yangtze Eco Rights Token  
- **Symbol:** YERT  
- **Standard:** ERC-20  
- **Total Supply:** 10,000,000 YERT  
- **Network:** Sepolia Testnet  

---

## Contract Address (CA)
0x90B1773BAF3441BF3f4D3018a251201aBBD7a7cC

🔗 View on Etherscan:  
https://sepolia.etherscan.io/address/0x90B1773BAF3441BF3f4D3018a251201aBBD7a7cC

---

## Key Features
- Fixed total supply (10 million tokens)
- Initial allocation:
  - 80% to public distribution
  - 20% to treasury (team allocation)
- Treasury lock mechanism (1 year)
- Owner-controlled treasury management
- Token burning function (burn treasury tokens)

---

## Functions
- `burnTreasuryTokens(uint256 amount)`  
  Allows the owner to burn tokens from the treasury after lock period

- `getLockRemaining()`  
  Returns remaining lock time for treasury tokens

---

## Technologies Used
- Solidity (^0.8.20)
- OpenZeppelin ERC-20 library
- Remix IDE
- MetaMask
- Sepolia Testnet

---

## Notes
This project is developed for academic purposes and demonstrates the basic implementation of a tokenised eco-rights model.
