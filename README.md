# Morpho Utilization Trap

A Drosera security trap designed to monitor utilization rates on Morpho-style lending vaults. 

## Deployment Specs (Hoodi Testnet)
- **Trap Config Address:** 0xaf77601DC7Bfceaba976e625CcE5972342B4C31D
- **Target Vault (Mock):** 0x4c2d7860FF6428A227671a351Ad142a0D3C15B49
- **Response Contract:** 0x00a7402644a7Ef672bD54492e7bDED189160FD8C

## Logic
The trap triggers when `borrows * 10 > assets * 9` (Utilization > 90%). It uses a stateless execution model to ensure high reliability and low gas costs for the Drosera Network.
