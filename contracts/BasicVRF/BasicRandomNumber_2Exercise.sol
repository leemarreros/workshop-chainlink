// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// Importar la interfaz del contrato de VRF de Chainlink
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

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
contract BasicRandomNumber_2Exercise is VRFConsumerBaseV2 {
    // Numero random
    uint256 public randomNumberOne;
    uint256 public randomNumberTwo;

    address vrfCoordinatorAdd = 0x7a1BaC17Ccc5b313516C5E16fb24f7659aA5ebed;

    // 2. Inicializar el constructor de VRFConsumerBaseV2 con el address de VRFCoordinator
    // VRFCoordinator se encarga de comunicarse con los oráculos para solicitar el número random
    // VRFConsumerBaseV2(vrfCoordinatorAdd)
    constructor() VRFConsumerBaseV2(vrfCoordinatorAdd) {}

    struct EstadoPedido {
        bool completado; // whether the request has been successfully fulfilled
        bool existe; // whether a requestId exists
        uint256[] randomWords;
    }
    mapping(uint256 requestId => EstadoPedido) public tablaDePedidos;
    uint256[] public historicoDeIds;

    function requestRandomWords(uint256 salt) external {
        uint256 randomNumber = uint256(
            keccak256(abi.encode(msg.sender, block.timestamp, salt))
        );
    }

    function requestRandomWordsVRF() external {
        // 3. Instanciar el contrato de VRFCoordinator
        IVRFCoordinator coordinator = IVRFCoordinator(vrfCoordinatorAdd);

        // De la documentación:
        // https://docs.chain.link/vrf/v2/subscription/supported-networks#polygon-matic-mumbai-testnet
        bytes32 keyHash = 0x4b09e658ed251bcafeebbc69400383d49f344ace09b9576fe248bb02c003fe9f;
        uint64 s_subscriptionId = 5507;
        uint16 requestConfirmations = 3;
        uint32 callbackGasLimit = 1000000;
        uint32 numWords = 2;

        // 4. Solicitar los números random al contrato de VRFCoordinator
        // Rellenar los respectivos parámetros
        uint256 requestId = coordinator.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );

        tablaDePedidos[requestId] = EstadoPedido({
            completado: false,
            existe: true,
            randomWords: new uint256[](0)
        });
        historicoDeIds.push(requestId);
    }

    // 5. Implementar el callback que será llamado por el Oráculo
    // En este método se reciben los números random
    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory _randomWords
    ) internal override {
        randomNumberOne = _randomWords[0];
        randomNumberTwo = _randomWords[1];

        tablaDePedidos[requestId] = EstadoPedido({
            completado: true,
            existe: true,
            randomWords: _randomWords
        });
    }

    function completado(uint256 requestId) public view returns (bool) {
        return tablaDePedidos[requestId].completado;
    }
}
