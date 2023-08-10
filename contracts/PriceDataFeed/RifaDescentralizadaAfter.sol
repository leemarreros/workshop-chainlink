// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {ServicioRandom} from "./ServicioRandom.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract RifaDescentralizadaAfter is ServicioRandom {
    struct Rifa {
        uint256 premio; // en USDC
        uint256 precio; // precio de participacion en USDC
        uint256 fechaInicio;
        uint256 fechaFin;
        uint256 acumulado; // de todos los tickets vendidos
        address creador;
        address[] participantes;
    }
    mapping(address => Rifa) public rifas;

    // Relaciona requestId con creador de la rifa
    // Más adelante voy a poder el requestId para encontrar al creador
    // Y usando al creador podré encontrar la rifa
    mapping(uint256 requestId => address creador) requestIdToCreador;

    IERC20 public usdc;

    event InicioRifa(address creador, uint256 premio, uint256 fechaFin);
    event ParticipaEnRifa(address participante, address creador);
    event FinalizaRifa(
        address creador,
        address ganador,
        uint256 premio,
        uint256 neto
    );

    constructor(address _usdcAddress) {
        usdc = IERC20(_usdcAddress);
    }

    function crearRifa(
        uint256 _premio,
        uint256 _precio,
        uint256 _fechaFin
    ) public {
        // Crear rifa
        Rifa storage _rifa = rifas[msg.sender];

        // Valida que no exista rifa
        require(_rifa.creador == address(0), "Solo se puede crear una rifa");

        _rifa.premio = _premio;
        _rifa.precio = _precio;
        _rifa.fechaInicio = block.timestamp;
        _rifa.fechaFin = _fechaFin;
        _rifa.creador = msg.sender;
        _rifa.acumulado = 0; // redundante

        // Creador hace deposito de premio al contrato
        usdc.transferFrom(msg.sender, address(this), _premio);

        emit InicioRifa(msg.sender, _premio, _fechaFin);
    }

    function participarEnRifa(address _creador) public {
        Rifa storage _rifa = rifas[_creador];

        // verifica que rifa exista
        require(_rifa.creador != address(0), "Rifa no existe");

        // Verifica que rifa aún no termina
        require(_rifa.fechaFin >= block.timestamp, "Rifa ya termino");

        // Guarda participante en rifa
        _rifa.participantes.push(msg.sender);

        // Participante hace depósito del precio del ticket
        usdc.transferFrom(msg.sender, address(this), _rifa.precio);

        // Acumula
        _rifa.acumulado += _rifa.precio;

        // Event Participa en Rifa
        emit ParticipaEnRifa(msg.sender, _creador);
    }

    function finalizarRifa(address _creador) public {
        Rifa storage _rifa = rifas[_creador];

        // rifa existe
        require(_rifa.creador != address(0), "Rifa no existe");

        // Verifica que rifa terminó
        require(_rifa.fechaFin < block.timestamp, "Rifa aun no termina");

        uint256 requestId = requestRandomWordsVRF();
        requestIdToCreador[requestId] = _creador;
    }

    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory _randomWords
    ) internal override {
        address _creador = requestIdToCreador[requestId];

        // Calcular ganador
        uint256 randomNumber = _randomWords[0];
        _calcularGanadorDistribuirPremio(randomNumber, _creador);
    }

    function _calcularGanadorDistribuirPremio(
        uint256 randomNumber,
        address _creador
    ) internal {
        Rifa memory _rifa = rifas[_creador];
        limpiarRifa(_creador);

        // Calcular ganador
        uint256 numParticipantes = _rifa.participantes.length;
        uint256 indexGanador = randomNumber % numParticipantes;
        address ganador = _rifa.participantes[indexGanador];

        // Transfiere premio al ganador
        usdc.transfer(ganador, _rifa.premio);

        // Transfiere acumulado al creador de la rifa
        uint256 fee = _rifa.acumulado / 10;
        uint256 net = _rifa.acumulado - fee;
        usdc.transfer(_creador, net);

        emit FinalizaRifa(_creador, ganador, _rifa.premio, net);
    }

    //////////////////////////////////////////////////////////////////////////////
    //////////////////////////      HELPERS             //////////////////////////
    //////////////////////////////////////////////////////////////////////////////
    function limpiarRifa(address _creador) public {
        rifas[_creador].acumulado = 0;
        rifas[_creador].creador = address(0);
        rifas[_creador].premio = 0;
        rifas[_creador].precio = 0;
        rifas[_creador].fechaInicio = 0;
        rifas[_creador].fechaFin = 0;
        rifas[_creador].participantes = new address[](0);
    }
}
