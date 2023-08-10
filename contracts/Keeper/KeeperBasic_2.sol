// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {AutomationCompatibleInterface} from "@chainlink/contracts/src/v0.8/AutomationCompatible.sol";

contract VotacionKeeper2 is AutomationCompatibleInterface {
    bool finVotacion;

    mapping(uint256 idCandidato => uint256 numeroVotos) public votosCandidatos;
    mapping(address votante => bool voto) public votos;

    // 0: empate
    // N: candidato N
    // 0 < N < 101
    event Ganador(uint256 idCandidato, uint256 votos, uint256 totalVotos);

    function votar(uint256 _idCandidato) public {
        require(!votos[msg.sender], "Ya votaste");
        require(_idCandidato > 0 && _idCandidato < 101, "Candidato no existe");

        votosCandidatos[_idCandidato]++;
        votos[msg.sender] = true;
    }

    function finalizarVotacionCostosa() public {
        uint256 idCandidatoGanador;
        uint256 votosGanador = 0;
        uint256 totalVotos;
        for (uint256 i = 1; i < 101; i++) {
            totalVotos += votosCandidatos[i];
            if (votosCandidatos[i] > votosGanador) {
                idCandidatoGanador = i;
                votosGanador = votosCandidatos[i];
            }
        }

        emit Ganador(idCandidatoGanador, votosGanador, totalVotos);
    }

    function checkUpkeep(
        bytes calldata checkData
    )
        external
        view
        override
        returns (bool upkeepNeeded, bytes memory performData)
    {
        if (finVotacion) return (false, "");

        (uint256 indexCandidatoUno, uint256 indexCandidatoDos) = abi.decode(
            checkData,
            (uint256, uint256)
        );

        // contando los votos
        uint256 totalVotes;
        uint256 idCandidatoGanador;
        uint256 votosGanador = 0;
        for (
            uint256 i = indexCandidatoUno;
            i <= indexCandidatoDos && !upkeepNeeded;
            i++
        ) {
            // calculando ganador
            if (votosCandidatos[i] > votosGanador) {
                idCandidatoGanador = i;
                votosGanador = votosCandidatos[i];
            }

            // calculando total votos
            totalVotes += votosCandidatos[i];
        }

        // mayor a dos votos, termina la votación
        if (totalVotes > 1) {
            upkeepNeeded = true;
        }

        performData = abi.encode(idCandidatoGanador, votosGanador, totalVotes);
    }

    function performUpkeep(bytes calldata performData) external override {
        finVotacion = true;
        (uint256 id, uint256 _votos, uint256 total) = abi.decode(
            performData,
            (uint256, uint256, uint256)
        );
        emit Ganador(id, _votos, total);
    }

    //////////////////////////////////////////////////////////////////////////////
    //////////////////////////      HELPERS             //////////////////////////
    //////////////////////////////////////////////////////////////////////////////

    function encode(
        uint256 indexOne,
        uint256 indexTwo
    ) public pure returns (bytes memory) {
        return abi.encode(indexOne, indexTwo);
    }

    function decodeAddress(
        bytes memory _encodedData
    )
        public
        pure
        returns (uint256 indexCandidatoUno, uint256 indexCandidatoDos)
    {
        (indexCandidatoUno, indexCandidatoDos) = abi.decode(
            _encodedData,
            (uint256, uint256)
        );
    }
}
