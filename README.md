# WORKSHOP CHAINLINK



# Requisitos (IMPORTANTE!)

**Completa el set up antes de unirte al workshop para evitar demoras y retrasos en la clase!**

Sigue los siguientes pasos antes de comenzar el workshop:

1. Instalar Node 14.x y clonar repositorio

- Usar Node version 14.x (usar `nvm` para cambiar de versión en Node)

- Hacer fork del [repositorio de la clase](https://github.com/leemarreros/workshop-chainlink)

- Ubicarte en el branch `main` y luego instalar los paquetes de NPM

  - `$ npm install`

- Abrir un terminal en la carpeta raíz. Correr el siguiente comando y verificar errores:

  - `$ npx hardhat compile`

  De presentarse algún error, solucionarlo mediante recursos online.

2. Instalar Metamask y Obtener Matic tokens

- Instalar extensión de Metamask en Navegador. [Descargar aquí](https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn). Crear cuenta. Habilitar una billetera en Metamask. Cambiar a la red `Mumbai`. 
- Enviar `Matic` a la billetera creada usando el `address` de la billetera. Para solicitar `Matic`, ingresar a [Polygon Faucet](https://faucet.polygon.technology/) o [Faucet de Alchemy](https://mumbaifaucet.com/). Recibirás un balance en `Matic`

3. Añadir Mumbai a Metamask

* Dirigirte a [Mumbai Polygon Scan](https://mumbai.polygonscan.com/)

* Hacia el final de la página buscar el botón `Add Mumbai Network`

  ![image-20230723160538721](https://github.com/leemarreros/workshop-chainlink/assets/3300958/cae3e423-3ec5-4bff-a84d-3540bf80075a)

* Se abrirará una ventana de Metamask. Dar confirmar y continuar hasta que se efectúe el cambio de red

4. Crear archivo de Secrets `.env` duplicando el archivo `.env-copy`. Corre el siguiente comando el terminal

- `$ cp .env-copy .env`

5. Rellenar las claves del archivo `.env`:

- `API_KEY_POLYGONSCAN`: Dirigirte a [PolygonScan](https://polygonscan.com/). Click en `Sign in`. Click en `Click to sign up` y terminar de crear la cuenta en Polygon Scan. Luego de crear la cuenta ingresar con tus credenciales. Dirigirte a la columna de la derecha. Buscar `OTHER` > `API Keys`. Crear un nuevo api key haciendo click en `+ Add` ubicado en la esquina superior derecha. Darle nombre al proyecto y click en `Create New API Key`. Copiar el `API Key Token` dentro del archivo `.env`.
- `PRIVATE_KEY`: Obtener el `private key` de la wallet que se creó en el punto `2` siguiendo [estos pasos](https://support.metamask.io/hc/en-us/articles/360015289632-How-to-export-an-account-s-private-key) y copiarlo en esta variable en el archivo `.env`.
- `MUMBAI_TESNET_URL`: Crear una cuenta en [Alchemy](https://dashboard.alchemyapi.io/). Ingresar al dashboard y crear una app `+ CREATE APP`. Escoger `NAME` y `DESCRIPTION` cualquiera. Escoger `CHAIN` = `Polygon PoS` y `NETWORK` = `Polygon Mumbai`. Hacer click en `VIEW KEY` y copiar el valor dentro de `HTTPS` en el documento `.env` para esta variable de entorno. Saltar el paso de pago del servicio.

6. Obtener LINK (gas del Oráculo)

* Obtener el token LINK del faucet. Dirigirte a [este link](https://faucets.chain.link/mumbai). Fíjate que te encuentres en la red **Mumbai** en tod momento

7. Crea una suscripción en Chainlink VRF

* Dirígete a [vrf chailink link mumbai](https://vrf.chain.link/mumbai)

* Clic en `Create Subscription` => `Create subscription` => Aprobar en Metamask. Esperar...

* Hacer clic en `Add funds` y confirmar con la billetera de Metamask

  ![image-20230723162645035](https://github.com/leemarreros/workshop-chainlink/assets/3300958/d01f7da4-2ad4-431c-86dc-06a9302fc08f)

8. Solicitar acceso a Chailink Functions BETA

* Este programa se encuentra en **BETA** y se require solicitar accesso
* Dirígete [a este link para pedir acceso](https://chainlinkcommunity.typeform.com/requestaccess?typeform-source=docs.chain.link)

9. Correr el siguiente comando en el terminarl para evaluar si todo está bien

* `$ npx hardhat run --network mumbai scripts/deployBasic_1.js`

* De ser correcto les saldrá el siguiente mensaje en el terminal:

  ```
  Basic deployed to: 0xA54a60124cE211f50dA0aA1cB7C5514B9f0dD58b
  The contract 0xA54a60124cE211f50dA0aA1cB7C5514B9f0dD58b has already been verified.
  https://mumbai.polygonscan.com/address/0xA54a60124cE211f50dA0aA1cB7C5514B9f0dD58b#code
  ```

  
