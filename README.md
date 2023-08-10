[TOC]

# WORKSHOP CHAINLINK

![Chainlink azul](https://github.com/leemarreros/workshop-chainlink/assets/3300958/d34c0a65-2728-4f7a-a81b-9d13c3462d3e)

Síguenos: [Chainlink MeetUp](https://www.meetup.com/chainlink-peru-connected-smart-contracts/) [Chainlink Twitter Esp](chainlinkesp)

# Requisitos (IMPORTANTE!)

**Completa el set up antes de unirte al workshop para evitar demoras y retrasos en la clase!**

Sigue los siguientes pasos antes de comenzar el workshop:

1. Instalar Node 14.x y clonar repositorio

- Usar Node version 14.x (usar `nvm` para cambiar de versión en Node)

- Hacer clone del [repositorio de la clase](https://github.com/leemarreros/workshop-chainlink)

  - `$ git clone https://github.com/leemarreros/workshop-chainlink`

- Ubicarte en el branch `main` y luego instalar los paquetes de NPM

  - `$ npm install`

- Abrir un terminal en la carpeta raíz. Correr el siguiente comando y verificar errores:

  - `$ npx hardhat compile`

  De presentarse algún error, solucionarlo mediante recursos online.

2. Instalar Metamask y Obtener Matic tokens

- Instalar extensión de Metamask en Navegador. [Descargar aquí](https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn). Crear cuenta. Habilitar una billetera en Metamask. Cambiar a la red `Mumbai`.
- Enviar `Matic` a la billetera creada usando el `address` de la billetera. Para solicitar `Matic`, ingresar a [Polygon Faucet](https://faucet.polygon.technology/) o [Faucet de Alchemy](https://mumbaifaucet.com/). Recibirás un balance en `Matic`

3. Añadir Mumbai a Metamask

- Dirigirte a [Mumbai Polygon Scan](https://mumbai.polygonscan.com/)

- Hacia el final de la página buscar el botón `Add Mumbai Network`

  ![image-20230723160538721](https://github.com/leemarreros/workshop-chainlink/assets/3300958/cae3e423-3ec5-4bff-a84d-3540bf80075a)

- Se abrirará una ventana de Metamask. Dar confirmar y continuar hasta que se efectúe el cambio de red

4. Crear archivo de Secrets `.env` duplicando el archivo `.env-copy`. Corre el siguiente comando el terminal

- `$ cp .env-copy .env`

5. Rellenar las claves del archivo `.env`:

- `API_KEY_POLYGONSCAN`: Dirigirte a [PolygonScan](https://polygonscan.com/). Click en `Sign in`. Click en `Click to sign up` y terminar de crear la cuenta en Polygon Scan. Luego de crear la cuenta ingresar con tus credenciales. Dirigirte a la columna de la derecha. Buscar `OTHER` > `API Keys`. Crear un nuevo api key haciendo click en `+ Add` ubicado en la esquina superior derecha. Darle nombre al proyecto y click en `Create New API Key`. Copiar el `API Key Token` dentro del archivo `.env`.
- `PRIVATE_KEY`: Obtener el `private key` de la wallet que se creó en el punto `2` siguiendo [estos pasos](https://support.metamask.io/hc/en-us/articles/360015289632-How-to-export-an-account-s-private-key) y copiarlo en esta variable en el archivo `.env`.
- `MUMBAI_TESNET_URL`: Crear una cuenta en [Alchemy](https://dashboard.alchemyapi.io/). Ingresar al dashboard y crear una app `+ CREATE APP`. Escoger `NAME` y `DESCRIPTION` cualquiera. Escoger `CHAIN` = `Polygon PoS` y `NETWORK` = `Polygon Mumbai`. Hacer click en `VIEW KEY` y copiar el valor dentro de `HTTPS` en el documento `.env` para esta variable de entorno. Saltar el paso de pago del servicio.

6. Obtener LINK (gas del Oráculo)

- Obtener el token LINK del faucet. Dirigirte a [este link](https://faucets.chain.link/mumbai). Fíjate que te encuentres en la red **Mumbai** en tod momento

7. Crea una suscripción en Chainlink VRF

- Dirígete a [vrf chailink link mumbai](https://vrf.chain.link/mumbai)

- Clic en `Create Subscription` => `Create subscription` => Aprobar en Metamask. Esperar...

- Hacer clic en `Add funds` y confirmar con la billetera de Metamask

  ![image-20230723162645035](https://github.com/leemarreros/workshop-chainlink/assets/3300958/d01f7da4-2ad4-431c-86dc-06a9302fc08f)

8. Solicitar acceso a Chailink Functions BETA

- Este programa se encuentra en **BETA** y se require solicitar accesso
- Dirígete [a este link para pedir acceso](https://chainlinkcommunity.typeform.com/requestaccess?typeform-source=docs.chain.link)

9. Correr el siguiente comando en el terminarl para evaluar si todo está bien

- `$ npx hardhat run --network mumbai scripts/deployBasic_1.js`

- De ser correcto les saldrá el siguiente mensaje en el terminal:

  ```
  Basic deployed to: 0xA54a60124cE211f50dA0aA1cB7C5514B9f0dD58b
  The contract 0xA54a60124cE211f50dA0aA1cB7C5514B9f0dD58b has already been verified.
  https://mumbai.polygonscan.com/address/0xA54a60124cE211f50dA0aA1cB7C5514B9f0dD58b#code
  ```

Cualquier duda o pregunta en nuestras RRSS:

[Twitter](https://twitter.com/lee.marreros)

[MeetUp](https://www.meetup.com/blockchain-bites/)

[LinkedIn](https://www.linkedin.com/in/lee-marreros/)

[Discord](https://discord.gg/QSHvdzE8KG)

[Notas](https://pad.riseup.net/p/chainlink-workshop)

# Introducción: ¿Por qué necesitamos Oráculos en el Blockchain?

## Origen griego

La palabra oráculo proviene de la mitología griega y hace referencia a alguien que tiene la capacidad de comunicarse con Dios y ver el futuro. Se utilizaba a los oráculos para **obtener conocimiento más allá de su nivel de entendimiento**. 

En el contexto del Blockchain, los oráculos son sistemas que proveen información del mundo real a los Blockchain. A diferencia de lo que sucede en la mitología Griega, **los oráculos no predicen el futuro pero obtiene informatión del pasado**. 

## Colección de información

Para ser más específicos, los oráculos no insertan información directamente en el Blockchain. En cambio, **los oráculos colectan y guardan data del mundo real**. Cuando **un contrato necesita información, hace una consulta a un oráculo confiable**. Un ejemplo de oráculo son los sistemas de IoT como sensores.

## Es un puente al mundo real

El oráculo también puede ser entendido como un puente que **analiza y procesa información muy variada para convertirlo en en un formato que el blockchain puede entender**.

Digamos que queremos hacer el **intercambio de Ether a Dólares** en un contrato inteligente. Es crucial contar con el tipo de cambio de Ether a Dólares. Sin que un oráculo provea esa información, es imposible ejecutar un intercambio entre estos dos activos. 

## El problema del oráculo

El oráculo tendrá que buscar los tipos de cambio en diferentes exchanges. Siempre y cuando cualquier agente pueda verificar esta información, se podría decir que dicho oráculo es confiable. Sin embargo, **en situaciones cuando la información es difícilmente verificable, se crean oráculos centralizados y la confianza disminuye**.

En situaciones en las que hay **mucho valor (dinero) involucrado, las probabilidades de que un oráculo centralizado se vea comprometido** se incrementan. Cuando las partes involucradas y otros agentes no pueden verificar la información del oráculo en una transacción valiosa, el oráculo se convierte en un problema.

## Ejemplos

* Ganadores de lotería
* Desastres naturales con medidades de riesgo
* Data estática como códigos postales
* Condiciones climáticas
* Eventos políticos y deportivos
* Otros eventos en el Blockchain

## Oráculo y Blockchain

El problema del oráculo involucra su confianza y fiabilidad.

**"The security, authenticity, and trust conflict between third-party oracles and the trustless execution of smart contracts" - Curran**

La existencia de oráculos es en realidad un pase en la dirección contraria a la decentralización. **Los oráculos no son sistemas distribuidos**. Por ello, vuelven a introducir el punto singular de falla. 

La **información con la cual operan los oráculos es no determinística**. La fiabilidad de dicha información no puede ser comprobada mediante computación. Ello elimina la interacción peer-to-peer donde no se requería la confianza.

## Compromiso del oráculo

Un oráculo puede fallar de dos maneras.

Aunque el oráculo sea confiable y no es posible que tome partida, la **fuente información que utiliza sí puede ser alterada**. Consecuentemente, alimentará una data fraguada y falsa al contrato.

Incluso aunque el oráculo no esté parcializado y su información sea correcta, el **oráculo puede fallar por un malfuncionamiento del sistema** o manipulación consciente.

Desde un punto de vista de teoría de juegos, mientras la transacción tenga más valor, el incentivo es mayor para intentar manipular al sistema.

## Oráculo y tokenización de activos físicos

Cuando se vincula un activo físico a un activo digital, su regulación trasciende el código del contrato inteligente. Entonces también se necesita confiar en que la regulación del mundo físico será cumplida para que una transacción se puede llevar a cabo.

Imgínate la transferencia de activos físicos que fueron tokenizados. El smart contract puede fácilmente realizar la transferencia de activos entre los participantes. Sin embargo, esta sola transferencia no asegura que el anterior dueño se va a retirar de la propiedad. Surge la necesidad de confiar en una tercera persona que verifique que esto es así. Ello elimina el propósito de un smart contract que es la ejecución del código al pie de la letra.

En lugares donde exista mucha corrupción y se requiera trascender al mundo físico para realizar transacciones, la intención por la cual fue creada el contrato inteligente se ve afectada.

## Solución al problema del oráculo

Chainlink propone un **sistema de oráculos descentralizados** basados en su **reputación**. Se busca imitar el mecanismo de consenso de un Blockchain. Es decir toma en consideración la mayoría de los oráculos y su nivel de reputación de cada oráculo. Cuando se confirma la **información por la mayoría de oráculos**, dicha información se guarda en el Blockchain.

De esta manera **se elimina el punto singular de falla**. Sin embargo, incluso así, las empresas que son la fuente de información aún tendrían la posibilidad de coludir para alterar la data que liberan. 

# Función Random Verificable (VRF v2)

## ¿Por qué no es fiable la generación de aleatoriedad en un contrato?

* **Determinismo**: el resultado de una función es el mismo si se le pasan los mismos inputs. Todos los nodos vuelven a correr las transacciones para validarlas. Ello implica que no se pueda usar un número genuinamente aleatorio porque si fuera así cada nodo obtendría un resultado diferente al ejecutar una función
* **Injerencia de los mineros**: los mineros podrían manipular las variables que se usan para generar aleatoriedad. Así también un minero podría demorar la inclusión de una transacción para incluirla en un bloque posterior. 
* **Aleatoriedad predecible**: algunas variables globales pueden ser predecidas. Aquí encontramos, por ejemplo, el número de bloques. De ese modo, usar dicha variable global no es una fuente segura de aleatoriedad.
* **Intervenir una transacción**: puedo crear un contrato inteligente y ejecutar dos métodos en una misma transacción. De ese modo, ambos métodos compartirán las mismas fuentes de aleatoriedad, lo cual conllevaría a recrear el resultado aleatorio exacto.

## Adivina la cara de una moneda: hackeando un contrato con aleatoriedad

El siguiente contrato se trata de un juego de adivinanza. Al llamar al método `flip`, se pasa un argumento booleano que de coincidir con el booleano que se genera dentro de `flip`, se otorga un premio al usuario.

Analicemos el siguiente contrato inteligente:

`Moneda.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Moneda {
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

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
```

* El usuario deposita un 1 Ether para participar
* Si adivina si la moneda cae cara (`coinFlip == 1`) o sello (`coinFlip == 2`), el usuario gana 2 Ether
* Si no adivina, solo perdió el Ether depositado

¿Cómo leer las variables globales, que son la fuente de aleatoriedad, desde otro contrato?

Dado que podemos interceder a las variables globales usadas dentro del método `flip`, vamos a crear otro contrato inteligente para lograr ello. Desde el otro contrato vamos a realizar una transacción en el mismo bloque en que se llama al método `flip`. Así el contrato atacante logrará acceder a las fuentes de aleatoriedad de `flip`. Veamos:

```solidity
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
```

* `attack` hace us de todas las variables globales que posee `flip`
* Ello es posible porque se crea otra transacción llamada `attack` para poder llamar a la transacción `flop` al mismo tiempo
* En el método `attack` se calcula si es cara o sello y de esa manera, sin equivocarse, se llama al método `flip` con la respuesta correcta

## Introducción to Chainlink VRF v2

Chainlink VRF permite a los smart contracts usar valores random sin comprometer la usabilidad y seguridad. De hecho, cada vez que se solicita un número random, la prueba de dicho número es publicada y verificada dentro del mismo Blockchain antes de que pueda ser usado. 

En particular, Chainlink VRF sirve para construir juegos basados en el azar, crear aplicaciones que eligen representantes al azar y para asignar tareas de manera aleatoria (e.g. asignar juece de manera aleatoria).

### Generación de un número pseudorandom

Vamos a comenzar con la generación de un número pseudorandom en un contrato inteligente. Por lo general, esto involucra usar el método `keccak256` seguido de una lista de variables que se mezclan para crear el número random.

Veamos el siguiente contrato:

`BasicRandomNumber_1.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract BasicRandomNumber {
    // Numero random
    uint256 public randomNumber;

    function requestRandomWords(uint256 salt) external {
        randomNumber = uint256(
            keccak256(abi.encode(msg.sender, block.timestamp, salt))
        );
    }
}
```

El usuario llama al método `requestRandomWords` para obtener números aleatorios.

Aquí notamos una fuente de aleatoriedad extra: `salt`. Sin embargo, este input puede ser débil y estar sujeto a las misma vulnerabilidades del contrato `Moneda.sol` explicado líneas arriba.

### Implementación de VRF2

En el siguiente diagram podemos observar de manera general cómo se logra la comunicación con el Oráculo de Chainlink.

![img](https://docs.chain.link/files/881ade6-Simple_Architecture_Diagram_1_V1.png)

![image-20230808203719370](/Users/steveleec/Documents/Blockchain Bites/workshop-chainlink-solution/README.assets/image-20230808203719370.png)

* El contrato `Basic.sol` se comunica con el contrato `VRFCoordinator.sol` para poder solicitar los números random

* `VRFCoordinator.sol` se comunica con el Oráculo que hace el trabajo de encontrar un número random. 
* Por hace este trabajo, se le paga en `LINK`, que es el gas de Oráculo. Este token es descontado de una suscripción previamente creada
* El Oráculo llama al método callback `fulfillRandomWords` que está definido en `Basic.sol`, nuestro contrato

#### Creación de una suscripción

Para casos de uso en los cuales se usará constantemente el número random de Chainlink, es conveniente usar el modelo de suscripción. Luego de crear la suscripción, se deben depositar `LINK` tokens para ser usados como balance.

1. Dirigirte a [chainlink para crear una suscripción](https://vrf.chain.link/mumbai)

2. Click en `Create Subscription`. Confirmar en Metamask (2 veces).

3. Al terminar el paso 2, aparecerá el botón `Add funds`.

   ![image-20230808223831461](/Users/steveleec/Documents/Blockchain Bites/workshop-chainlink-solution/README.assets/image-20230808223831461.png)

   Si no se tiene un balance de `LINK`, solicitarlo de los [faucets de Chainlink](https://faucets.chain.link/mumbai)

4. Añadir tokens `LINK` y hacer clic en `Add funds`. Confirmar en Metamask

5. Al terminar el punto 4, hacer click en `Add consumers`. Los consumers son los smart contracts que podrán solicitar números random a Chainlink

6. Copiar y pegar el address del contrato que solicitará los números random y hacer click en `Add consumer`

   ![image-20230808224136762](/Users/steveleec/Documents/Blockchain Bites/workshop-chainlink-solution/README.assets/image-20230808224136762.png)

#### Convertir un contrato a VRF v2

Ahora veamos cómo pasar a incorporar lo necesario para hacer requests a los oráculos de Chainlink.

Puedes comenzar en el contrato `BasicRandomNumber_2Exercise.sol` y seguir los siguientes pasos.

1. Herencia del contrato VRFConsumerBaseV2
2. Inicializar el constructor de VRFConsumerBaseV2 con el address de VRFCoordinator. (VRFCoordinator se encarga de comunicarse con los oráculos para solicitar el número random)
3. Instanciar el contrato de VRFCoordinator
4. Solicitar los números random al contrato de VRFCoordinator usando los parámetros respectivos de la [documentación](https://docs.chain.link/vrf/v2/subscription/supported-networks#polygon-matic-mumbai-testnet)
5. Implementar el callback que será llamado por el Oráculo. En este método se reciben los números random

Contrato partida: `BasicRandomNumber_2Exercise.sol`

```solidity
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
```

Veamos el siguiente contrato con el resultado final:

`BasicRandomNumber_2.sol`

```solidity
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
contract BasicRandomNumber2 is VRFConsumerBaseV2 {
    // Numero random
    uint256 public randomNumber;
    uint256 public randomNumberTwo;

    address constant vrfCoordinatorAdd =
        0x7a1BaC17Ccc5b313516C5E16fb24f7659aA5ebed;

    // 2. Inicializar el constructor de VRFConsumerBaseV2 con el address de VRFCoordinator
    // VRFCoordinator se encarga de comunicarse con los oráculos para solicitar el número random
    constructor() VRFConsumerBaseV2(vrfCoordinatorAdd) {}

    function requestRandomWords(uint256 salt) external {
        randomNumber = uint256(
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
        uint32 callbackGasLimit = 100000;
        uint32 numWords = 2;

        // 4. Solicitar los números random al contrato de VRFCoordinator
        // Rellenar los respectivos parámetros
        coordinator.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
    }

    // 5. Implementar el callback que será llamado por el Oráculo
    // En este método se reciben los números random
    function fulfillRandomWords(
        uint256,
        uint256[] memory _randomWords
    ) internal override {
        randomNumber = _randomWords[0];
        randomNumberTwo = _randomWords[1];
    }
}
```

Para publicar este contrato de manera automática, correr el comando:

`npx hardhat --network mumbai run scripts/deployBasic_1.js`

Ahora vamos a mejorar el contrato anterior para incluir una situación en la cual pueden haber multiples requests de números random.

`BasicRandomNumber_3.sol`

```solidity
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

contract BasicRandomNumber3 is VRFConsumerBaseV2 {
    // Numero random
    uint256 public randomNumber;
    uint256 public randomNumberTwo;

    address constant vrfCoordinatorAdd =
        0x7a1BaC17Ccc5b313516C5E16fb24f7659aA5ebed;

    IVRFCoordinator coordinator = IVRFCoordinator(vrfCoordinatorAdd);

    bytes32 keyHash =
        0x4b09e658ed251bcafeebbc69400383d49f344ace09b9576fe248bb02c003fe9f;
    uint64 s_subscriptionId = 5507;
    uint16 requestConfirmations = 3;
    uint32 callbackGasLimit = 100000;
    uint32 numWords = 2;

    // 1. Crear una estructura de datos para guardar el estado de los pedidos
    struct EstadoPedido {
        bool completado; // whether the request has been successfully fulfilled
        bool existe; // whether a requestId exists
        uint256[] randomWords;
    }
    mapping(uint256 => EstadoPedido) tablaDePedidos;
    uint256[] historicoDeIds;

    // 2. Añadimos eventos significativos
    event Requested(uint256 indexed requestId);
    event Fulfilled(uint256 indexed requestId, uint256[] randomWords);

    constructor() VRFConsumerBaseV2(vrfCoordinatorAdd) {}

    function requestRandomWordsVRF() external {
        uint256 requestId = coordinator.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );

        // 3. Guardamos el estado del pedido
        tablaDePedidos[requestId] = EstadoPedido({
            completado: false,
            existe: true,
            randomWords: new uint256[](0)
        });
        historicoDeIds.push(requestId);

        emit Requested(requestId);
    }

    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory _randomWords
    ) internal override {
        randomNumber = _randomWords[0];
        randomNumberTwo = _randomWords[1];

        // 4. Actualizamos el estado del pedido
        tablaDePedidos[requestId] = EstadoPedido({
            completado: true,
            existe: true,
            randomWords: _randomWords
        });

        emit Fulfilled(requestId, _randomWords);
    }

    // 5. Puede hacer consultas para saber si un pedido ha sido completado
    function completado(uint256 requestId) public view returns (bool) {
        return tablaDePedidos[requestId].completado;
    }
}
```

Correr el siguiente comando para publicar este contrato `npx hardhat --network mumbai run scripts/deployBasic_2.js `

* Notar que hemos creado una estructura de datos para guardar los pedidos de números random
* Con dicha estructura podemos saber si un pedido aún se encuentra en procesamiento o si ya fue completado
* Además podemos guardar la lista de números random históricos de todos los pedidos para ser consultados en el futuro

#### Creando una rifa decentralizada

Vamos  a tomar como partida el siguiente contrato que utiliza un número pseudo random para computar el ganador de la rifa.

`RifaDescentralizadaPrev.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract RifaDescentralizadaPrev {
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

        uint256 randomNumber = _getPseudoRandomNumber();
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

    function _getPseudoRandomNumber() internal view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(
                        msg.sender,
                        blockhash(block.number - 1),
                        block.timestamp
                    )
                )
            );
    }
}
```

El ejercicio es convertir el anterior contrato en una rifa decentralizada. Sigue los siguientes pasos para lograrlo:

* Como ayuda se tiene al contrato `ServicioRandom.sol` que se puede usar para tener la configuración completa
* Se debe vincular el requestId con el owner de alguna manera. Cuando se llame `fulfillRandomWords` sabremos a qué owner le pertenece dicha rifa usando el `requestId`.
* Implementamos el método `fulfillRandomWords` para que sea el callback que el Oráculo llamará

Luego de trabajar la anterior rifa, se debería ver así:

`RifaDescentralizadaAfter.sol`

```solidity
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
        Rifa storage _rifa = rifas[_creador];

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

        limpiarRifa(_creador);

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
```

Para publicar este contrato ejecutar el comando `hardhat --network mumbai run scripts/deployRifaDecentralizada.js `

Una vez publicado, podemos interactuar con el mismo desde el terminal siguiendo estos pasos:

```javascript
// Conectarte a Mumbai testnet desde el terminal
// npx hardhat console --network mumbai

  // Conectarte con el contrato en Mumbai
  var USDC = await ethers.getContractFactory("USDC");
  var usdcAddress = "0xCc53008eCd213bdeF4C0b834cbcfBc2B214197bd";
  var usdc = await USDC.attach(usdcAddress);

  var RifaDescentralizada = await ethers.getContractFactory("RifaDescentralizadaAfter");
  var RifaAddress = "0x9c11A44a0f29707AFDEbFBB7EaefecDC04135B4B";
  var rifaDecentralizada = await RifaDescentralizada.attach(RifaAddress);

  // Creador de rifa le da permiso al contrato para transferir USDC
  var premio = ethers.parseEther("1000")
  await usdc.approve(RifaAddress, premio)
  
  // Creador crea Rifa
  var premio = ethers.parseEther("1000")
  var precio = ethers.parseEther("10");
  var fechaFin = (await ethers.provider.getBlock()).timestamp + 60 * 2;
  var tx = await rifaDecentralizada.crearRifa(premio, precio, fechaFin);
  console.log(tx.hash);

  // Participar en Rifa
  var [owner, alice] = await ethers.getSigners();
    // Acuñar tokens a Alice
    await usdc.mint(alice.address, precio);
    // Alice aprueba al contrato para transferir USDC
    await usdc.connect(alice).approve(RifaAddress, precio);
    await usdc.connect(owner).approve(RifaAddress, precio);
  
  var creador = owner.address;
  var tx = await rifaDecentralizada.connect(owner).participarEnRifa(creador);
  var tx = await rifaDecentralizada.connect(alice).participarEnRifa(creador);

  // Finalizar Rifa
  await rifaDecentralizada.finalizarRifa(creador);
```

## Chainlink Price Data Feed

Con [Chainlink price data feed](https://docs.chain.link/data-feeds/price-feeds/addresses) podemos consultar tipos de cambio como si fuera en tiempo real. La consulta se realiza a otro smart contract que posee dicha información.

Esa información es la agregación de varios nodos operadores de Chainlink. Cada fuente de precios tiene una address de contrato diferente. 

### Off-Chain Reporting (OCR)

En este modelo, los agregadores se comunican p2p. Se corre un modelo de consenso light y cada nodo reporta su información y la firma. Se consolida la información en una sola transacción que es firmada por un quorum de Oráculos.

Por lo general se escoge a un líder quien es el encargado de liderar las rondas de información.  Este agregador verifica el quorum de los oráculos y finalmente expone el valor medio y lo guarda en el contrato con el timestamp y el ID de la ronda.

Si por alguna razón el agregador falla, se ejecuta otro protocol (round-robin) de modo que otros nodos también pueden entregar el reporte final hasta que sea confirmado.

Mediante esta coordinación y validación, aseguramos la decentralización y la no parcialización de la información en Chainlink.

### Decentralized Oracle Network

Cada fuente de precios es actualizada por un oráculo decentralizado que es premiado por proveer dicha información. La cantidad de oráculos varía dependiendo del tipo de activo y requiere de un mínimo.

Veamos este ejemplo de [ETH/USD](https://data.chain.link/ethereum/mainnet/crypto-usd/eth-usd).

![image-20230809100821519](/Users/steveleec/Documents/Blockchain Bites/workshop-chainlink-solution/README.assets/image-20230809100821519.png)

Existen tres componentes para el Data Feed de Chainlink:

1. **Un contrato que consume la información**

   Es cualquier contrato que consume la data agregada y usa el address del contrato Proxy

2. **El contrato proxy que es el address que tiene la data**

   Apunta a los agregadores y permite actualizar a los agregadores sin interrumpir su servicio

3. **Un contrato agregador**

   Encargado de correr las rondas de actualización. Una ronda se dispara cuando el precio on-chain se desvía del off-chain después de un margen saludble. O también cuando se termina un tiempo límite.

### Forma parte de Chainlink Nodes

Al ejecutar un nodo de Chainlink, [puedes ser parte de la Red de Chainlink](https://docs.chain.link/chainlink-nodes). De esa manera puedes proveer información del mundo real a los contratos inteligentes. 

![image-20230809102414805](/Users/steveleec/Documents/Blockchain Bites/workshop-chainlink-solution/README.assets/image-20230809102414805.png)

### ¿Qué puedo leer de Data Feeds?

Hay al menos cuatro categorías:

1. Precios de activos (ratios)

   ![image-20230809112830568](/Users/steveleec/Documents/Blockchain Bites/workshop-chainlink-solution/README.assets/image-20230809112830568.png)

2. Pruebas de Reserva (proof of reserve)

   ![image-20230809112910150](/Users/steveleec/Documents/Blockchain Bites/workshop-chainlink-solution/README.assets/image-20230809112910150.png)

3. Precios de piso de NFTs

   ![image-20230809112938098](/Users/steveleec/Documents/Blockchain Bites/workshop-chainlink-solution/README.assets/image-20230809112938098.png)

4. Ratio y volatilidad

   ![image-20230809113023253](/Users/steveleec/Documents/Blockchain Bites/workshop-chainlink-solution/README.assets/image-20230809113023253.png)

#### Categorías de Data Feeds

![image-20230809111953148](/Users/steveleec/Documents/Blockchain Bites/workshop-chainlink-solution/README.assets/image-20230809111953148.png)

#### Interface para leer información

Todos los contratos de Chainlink que proveen información poseen la siguiente interface:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface AggregatorV3Interface {
  function decimals() external view returns (uint8);
  function description() external view returns (string memory);
  function version() external view returns (uint256);
  function getRoundData(uint80 _roundId)
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );
}
```

Lo cual quiere decir que tan solo cambiando el address del agregador podemos leer cualquiera de las cuatro categorías de Data Feeds que hay.

#### Creando el consumidor

`PriceFeed_1.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceFeed_1 {
    /**
     * Network: Sepolia
     * Aggregator: ETH/USD
     * Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
     */
    address ethUsdAgg = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
    AggregatorV3Interface internal dataFeed = AggregatorV3Interface(ethUsdAgg);

    function getRatioEthUsd() public view returns (int, uint256) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return (answer, dataFeed.decimals());
    }
}
```

### Usando Price Data Feeds (1)

Ahora, regresando al ejemplo de la subasta decentralizada, vamos a permitir que el usuario pueda cobrar su premio de USDC en ETH. Para ello debemos encontrar el tipo de cambio (ratio) de ETH a USDC.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {ServicioRandom} from "./ServicioRandom.sol";
import {PriceFeed_1} from "./PriceFeed_1.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract RifaDescentralizadaPriceFeed is ServicioRandom, PriceFeed_1 {
   // ...
    function reclamarPremioEnEth() public {
        uint256 balanceUsdc = balances[msg.sender];
        require(balanceUsdc > 0, "No tienes premio");
        balances[msg.sender] = 0;

        // Convertir balanceUsdc a balanceEth uasndo getRatioEthUsd
        // 1. Tener en cuenta que getRatioEthUsd tiene 8 decimales
        // 2. Tener en cuenta que USDC tiene 6 decimales
        // (1 y 2) Eso quiere decir que 10 ** 6 == 10 ** 8
        // 3. Tener en cuenta que ETH tiene 18 decimales

        // 1 ETH = 185000000000 USDC
        // X Eth = 300000000(00) USDC
        // => 30000000000/185000000000 = 0.16216 ETH (sin incluir 18 decimales)

        // X =[ 300 * (usdc decimals) * (decimals faltante) * (Eth Decimals) ]/ [1850 * (getRatio decimals)]
        // X =[ 300 * 10 ** 6 * 10 ** 2 * 10 ** 18] / [1850 * 10 ** 8]
        // 162162162162162180 Eth (con 18 decimals)
        // 0.16216 ETH (sin 18 decimales)

        (int ratio, uint256 decimals) = getRatioEthUsd();
        uint256 numerador = balanceUsdc * 10 ** (decimals - 6) * 10 ** 18;
        uint256 denominador = uint256(ratio);
        uint256 balanceEth = numerador / denominador;

        payable(msg.sender).transfer(balanceEth);
    }
    // ...
}
```

A través del método `reclamarPremioEnEth`, el usuario puede convertir sus USDC a ETH.

Sin embargo, en este proceso, hay que tener en cuenta los decimales de cada moneda. Hay al menos tres tipos de decimales.

1. El USDC posee 6 decimals
2. El oráculo nos devuelve un ratio con 8 decimales
3. La moneda final (ETH) posee 18 decimales.

Para poder calcular el tipo de cambio, debemos tener en cuenta todos esos factores como está descrito en el ejemplo.

## Chainlink Keepers (automatización)

Surge la necesidad de usar automatización dado que los contratos inteligentes no pueden autodispararse bajo ninguna circunstancia. Las transacciones solo pueden ser iniciadas por otra cuenta.

Utiliza la misma red de oráculos decentralizados. Veamos el siguiente diagrama para ver cómo funciona:

![Chainlink Automation](https://docs.chain.link/images/contract-devs/automation/automation_intro.gif)

### Disparadores

#### Desarrollando una sistema de votación decentralizada y automatizada

En el siguiente contrato hemos creado un sistema de votación siemple que concluye en cuanto se tengan 4 votos o más.

Este es el contrato para comenzar y gradualmente iremos incluyendo lo que necesitamos

`KeeperBasic_1.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

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
}
```

El objetivo de automatizar este contrato es que una vez que se tengan una cantidad `N` de votos, la votación finalice de manera automática.

Estos son los pasos que debemos seguir:

1. Importamos `AutomationCompatibleInterface` de la librería de Chainlink
2. Heremos el contrato `AutomationCompatibleInterface` en nuestro contrato
3. Implementamos `checkUpkeep`. Este método returna un boolean. Si este boolean es true, el oráculo dispara el método  `performUpkeep`.
4. Implementamos `performUpkeep`. Este método es llamado por el oráculo y puede ejecutar la lógica que queremos automatizar desde nuestro smart contract.

Así luce el contrato luego de implementarse los keepers:

`KeeperBasicSol_1.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@chainlink/contracts/src/v0.8/AutomationCompatible.sol";

contract VotacionKeeperSol is AutomationCompatibleInterface {
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
    }

    function checkUpkeep(
        bytes calldata /* checkData */
    )
        external
        view
        override
        returns (bool upkeepNeeded, bytes memory /* performData */)
    {
        upkeepNeeded = totalVotos() > 3;
    }

    function performUpkeep(bytes calldata /* performData */) external override {
        if (totalVotos() > 3) {
            finalizarVotacion();
        }
    }

    function totalVotos() public view returns (uint256) {
        return
            votosCandidatos[idCandidatoUno] + votosCandidatos[idCandidatoDos];
    }
}
```

Para publicar este contrato correr el comando `npx hardhat --network mumbai run scripts/deployKeeperBasic_1.js`

#### Registrando el Keepers basado en lógica

Dirigirte a [Chainlink Automation](https://automation.chain.link/mumbai) y seguir los pasos para registrar el UpKeep.

![image-20230809152218630](/Users/steveleec/Documents/Blockchain Bites/workshop-chainlink-solution/README2.assets/image-20230809152218630.png)

Luego dar confirmar en Metamask y esperar a que finalice la transacción.

#### Upkeeps Flexibles

Este diseño de upkeeps ayuda a mantener los costos de operación al mínimo. El trabajo se manda al método `checkUpkeep`. Dado que se trata de un método view, no involucra un costo de gas. Este método tiene la capacidad de crear un output que puede ser leído por `performUpkeep`. De ese se logra una comunicación entre `checkUpkeep` y `performUpkeep`.

Dado que aprovechamos `checkUpkeep` para ejecutar operaciones costosas, podemos aprovechar también para hacer el cálculo de un resultado pesado. Al hacerlo allí, nos ahorramos pagar por esa computación. Ese resultado luego es pasado a `performUpkeep` para completar con la otra parte de la lógica.

Para este ejemplo, vamos a desarrollar un sistema de votaciones para 100 personas. Por supuesto, hacer el cálculo del conteo de votos para 100 personas on-chain es costos. Pero ahora se lo podemos delegar a `checkUpkeep` dicho trabajo y pasarle a `performUpkeep` el resultado del conteo para emitir al ganador.

Para publicar `KeeperBasic_2.sol` correr el siguiente comando `npx hardhat --network mumbai run scripts/deployKeeperBasic_2.js`

`KeeperBasic_2.sol`

```solidity
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
```