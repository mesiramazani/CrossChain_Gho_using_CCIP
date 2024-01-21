//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../contracts/Gho.sol";
import "./DeployHelpers.s.sol";
import {TokenTransfer} from "../contracts/TokenTransfer.sol";

contract DeployScript is ScaffoldETHDeploy {
    error InvalidPrivateKey(string);

    address routerSepolia = 0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59;
    address linkToken = 0x779877A7B0D9E8603169DdbD7836e478b4624789;
    uint256 allowedChain = 3478487238524512106;

    function run() external {
        uint256 deployerPrivateKey = setupLocalhostEnv();
        if (deployerPrivateKey == 0) {
            revert InvalidPrivateKey(
                "You don't have a deployer account. Make sure you have set DEPLOYER_PRIVATE_KEY in .env or use `yarn generate` to generate a new random account"
            );
        }
        vm.startBroadcast(deployerPrivateKey);
        /*Gho gho = new Gho(burnerWallet);
        console.logString(string.concat("Gho deployed at: ", vm.toString(address(gho))));*/
        TokenTransfer tokenTransfer = new TokenTransfer(routerSepolia, linkToken, allowedChain);
        vm.stopBroadcast();

        /**
         * This function generates the file containing the contracts Abi definitions.
         * These definitions are used to derive the types needed in the custom scaffold-eth hooks, for example.
         * This function should be called last.
         */
        exportDeployments();
    }

    function test() public {}
}

