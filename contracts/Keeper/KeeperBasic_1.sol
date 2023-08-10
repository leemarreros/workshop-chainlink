// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// 1.
// import {AutomationCompatibleInterface} from "@chainlink/contracts/src/v0.8/AutomationCompatible.sol";

// 2. Heredar
// contract VotacionKeeperSol is AutomationCompatibleInterface {
contract VotacionKeeper {
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
    // function checkUpkeep(bytes calldata /* checkData */) external view override returns (bool upkeepNeeded, bytes memory /* performData */){}

    // 4. implementar performUpkeep
    // function performUpkeep(bytes calldata /* performData */) external override {}
}
