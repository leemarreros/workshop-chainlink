// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract BasicRandomNumber1 {
    // Numero random
    uint256 public randomNumber;

    function requestRandomWords(uint256 salt) external {
        randomNumber = uint256(
            keccak256(abi.encode(msg.sender, block.timestamp, salt))
        );
    }
}
