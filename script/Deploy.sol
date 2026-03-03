// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {MorphoUtilizationResponse} from "../src/MorphoUtilizationResponse.sol";

// Mock contract for the Trap to monitor
contract MockMorpho {
    uint256 public totalAssets = 1000 ether;
    uint256 public totalBorrows = 500 ether;

    function setUtilization(uint256 _assets, uint256 _borrows) external {
        totalAssets = _assets;
        totalBorrows = _borrows;
    }
}

contract DeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // Hoodi Drosera Executor Address for Authorization
        address hoodiExecutor = 0x91cB447BaFc6e0EA0F4Fe056F5a9b1F14bb06e5D;

        vm.startBroadcast(deployerPrivateKey);

        MockMorpho mock = new MockMorpho();
        MorphoUtilizationResponse response = new MorphoUtilizationResponse(hoodiExecutor);

        console.log("MockMorpho deployed at:", address(mock));
        console.log("Response deployed at:", address(response));

        vm.stopBroadcast();
    }
}
