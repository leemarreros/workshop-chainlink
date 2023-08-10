// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// Importar la interfaz del contrato de VRF de Chainlink
// import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

interface IVRFCoordinator {
    function requestRandomWords(
        bytes32 keyHash,
        uint64 subId,
        uint16 minimumRequestConfirmations,
        uint32 callbackGasLimit,
        uint32 numWords
    ) external returns (uint256 requestId);
}

// 1. Herencia del contrato VRFConsumerBaseV2
// contract BasicRandomNumber_2Exercise is VRFConsumerBaseV2{
contract BasicRandomNumber_2Exercise {
    // Numero random
    uint256 public randomNumber;
    uint256 public randomNumberTwo;

    address vrfCoordinatorAdd;

    // 2. Inicializar el constructor de VRFConsumerBaseV2 con el address de VRFCoordinator
    // VRFCoordinator se encarga de comunicarse con los oráculos para solicitar el número random
    // VRFConsumerBaseV2(vrfCoordinatorAdd)
    constructor() {}

    function requestRandomWords(uint256 salt) external {
        randomNumber = uint256(
            keccak256(abi.encode(msg.sender, block.timestamp, salt))
        );
    }

    function requestRandomWordsVRF() external {
        // 3. Instanciar el contrato de VRFCoordinator
        IVRFCoordinator coordinator;

        // De la documentación:
        // https://docs.chain.link/vrf/v2/subscription/supported-networks#polygon-matic-mumbai-testnet
        bytes32 keyHash;
        uint64 s_subscriptionId;
        uint16 requestConfirmations;
        uint32 callbackGasLimit;
        uint32 numWords;

        // 4. Solicitar los números random al contrato de VRFCoordinator
        // Rellenar los respectivos parámetros
        // coordinator.requestRandomWords();
    }

    // 5. Implementar el callback que será llamado por el Oráculo
    // En este método se reciben los números random
    function fulfillRandomWords(
        uint256,
        uint256[] memory _randomWords
    ) internal {}
}
