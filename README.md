# Morpho Utilization Trap 🛡️

A real-time on-chain security monitor built for the **Drosera Network**. This trap specifically monitors **Morpho-style lending vaults** for high utilization rates, which often signal liquidity crunches or sophisticated drain attacks.

## 🚀 Overview
Traditional security relies on post-mortem analysis. This project implements **Active Defensive Infrastructure**. By monitoring the ratio of borrowed assets to total assets, we can trigger emergency responses (like pausing a pool or alerting a multisig) before the vault is fully exhausted.

## 🏗️ Architecture
The system is split into three distinct layers:

1. **The Target (MockMorpho):** A simulated lending vault that tracks `assets` and `borrows`.
2. **The Trap (MorphoUtilizationTrap):** A stateless monitoring contract that computes utilization:
   - **Threshold:** > 90% Utilization 
   - **Logic:** `borrows * 10 > assets * 9`
3. **The Responder (MorphoUtilizationResponse):** An authorized contract that executes emergency logic when the Drosera Operators reach consensus on an attack.

## 📍 Deployment Details (Hoodi Testnet)
| Component | Address |
| :--- | :--- |
| **Trap Config** | `0xaf77601DC7Bfceaba976e625CcE5972342B4C31D` |
| **Target Vault** | `0x4c2d7860FF6428A227671a351Ad142a0D3C15B49` |
| **Response Contract** | `0x00a7402644a7Ef672bD54492e7bDED189160FD8C` |

## 🛠️ Tech Stack
- **Solidity:** Smart contract logic.
- **Foundry:** Testing and deployment.
- **Drosera SDK:** Network integration.
- **Bash:** Real-time attack simulation and monitoring.

## 🧪 Simulation
To test the trap's integrity, a liquidity drain was simulated by setting the vault utilization to 95%. The Drosera Network correctly identified the state change and triggered the Response contract within the defined cooldown period.
