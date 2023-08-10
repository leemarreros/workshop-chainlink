// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// https://pad.riseup.net/p/chainlink-workshop
// 1.
import {AutomationCompatibleInterface} from "@chainlink/contracts/src/v0.8/AutomationCompatible.sol";

// 2. Heredar
// contract VotacionKeeperSol is AutomationCompatibleInterface {
contract VotacionKeeper is AutomationCompatibleInterface {
    uint256 idCandidatoUno = 1;
    uint256 idCandidatoDos = 2;

    mapping(uint256 idCandidato => uint256 numeroBVotos) public votosCandidatos;
    mapping(address votante => bool voto) public votos;

    // 0: empate
    // 1: candidato 1
    // 2: candidato 2
    event Ganador(uint256 idCandidato);

    function votar(uint256 _idCandidato) public {
        require(!votos[msg.sender], "Ya votaste");
        require(
            _idCandidato == idCandidatoUno || _idCandidato == idCandidatoDos,
            "Candidato no existe"
        );

        votosCandidatos[_idCandidato]++;
        votos[msg.sender] = true;
    }

    function finalizarVotacion() public {
        // cuando se llega a N votos, finalizar votacion
        if (
            votosCandidatos[idCandidatoUno] == votosCandidatos[idCandidatoDos]
        ) {
            emit Ganador(0);
        } else if (
            votosCandidatos[idCandidatoUno] > votosCandidatos[idCandidatoDos]
        ) {
            emit Ganador(idCandidatoUno);
        } else {
            emit Ganador(idCandidatoDos);
        }

        delete votosCandidatos[idCandidatoUno];
        delete votosCandidatos[idCandidatoDos];
    }

    function totalVotos() public view returns (uint256) {
        return
            votosCandidatos[idCandidatoUno] + votosCandidatos[idCandidatoDos];
    }

    // 3. implementar checkUpkeep
    // Validar cierta logica
    // - si true, ejecutar performUpkeep
    function checkUpkeep(
        bytes calldata /* checkData */
    )
        external
        view
        override
        returns (bool upkeepNeeded, bytes memory performData)
    {
        // definir una logica. si es true llamar al callback

        performData = abi.encode(totalVotos());
        return (totalVotos() > 1, performData);
    }

    // 4. implementar performUpkeep
    function performUpkeep(bytes calldata performData) external override {
        uint256 _totalVotos = abi.decode(performData, (uint256));
        if (totalVotos() > 1) {
            finalizarVotacion();
        }
    }
}
