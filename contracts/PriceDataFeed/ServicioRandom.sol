// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

abstract contract ServicioRandom is VRFConsumerBaseV2 {
    address constant vrfCoordinatorAdd =
        0x7a1BaC17Ccc5b313516C5E16fb24f7659aA5ebed;

    // VRF Coordinator
    VRFCoordinatorV2Interface coordinator =
        VRFCoordinatorV2Interface(vrfCoordinatorAdd);

    // Parámetros de la llamada a VRF Coordinator
    bytes32 keyHash =
        0x4b09e658ed251bcafeebbc69400383d49f344ace09b9576fe248bb02c003fe9f;
    uint64 s_subscriptionId = 5507;

    /**
     * MEDIDA DE SEGURIDAD #4
     * Los mineros pueden reescribir los bloques
     * A medida que se esperan más confirmaciones de bloques,
     * es más difícil reescrbir todos los bloques
     * Dependerá de cada Blockchain
     */
    uint16 requestConfirmations = 3;
    uint32 callbackGasLimit = 100000;
    uint32 numWords = 2;

    /**
     * MEDIDA DE SEGURIDAD #3
     * Utiliza VRFConsumerBaseV2 porque incluye un checkeo adicional
     * para ver si se entregó el número random o no
     *
     */
    constructor() VRFConsumerBaseV2(vrfCoordinatorAdd) {}

    function requestRandomWordsVRF() public returns (uint256) {
        return
            coordinator.requestRandomWords(
                keyHash,
                s_subscriptionId,
                requestConfirmations,
                callbackGasLimit,
                numWords
            );
    }
}
