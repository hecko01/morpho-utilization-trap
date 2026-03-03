// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

interface IMorphoVault {
    function totalAssets() external view returns (uint256);
    function totalBorrows() external view returns (uint256);
}

contract MorphoUtilizationTrap is ITrap {
    // UPDATED: Pointing to your deployed MockMorpho
    address public constant TARGET_VAULT = 0x4c2d7860FF6428A227671a351Ad142a0D3C15B49; 

    function collect() external view override returns (bytes memory) {
        uint256 assets = IMorphoVault(TARGET_VAULT).totalAssets();
        uint256 borrows = IMorphoVault(TARGET_VAULT).totalBorrows();
        return abi.encode(assets, borrows);
    }

    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        if (data.length == 0 || data[0].length == 0) return (false, bytes(""));

        (uint256 assets, uint256 borrows) = abi.decode(data[0], (uint256, uint256));

        if (assets == 0) return (false, bytes(""));

        // Trigger if utilization > 90%
        // Optimized math: (borrows / assets) > 0.9  => borrows * 10 > assets * 9
        if (borrows * 10 > assets * 9) {
            return (true, abi.encode(assets, borrows));
        }

        return (false, bytes(""));
    }
}
