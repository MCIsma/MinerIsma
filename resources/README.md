# MinerIsma v2.1.1 (Alpha) — Gerenciador de Mineração Solo de Bitcoin

"## ⚖️ License
This project is licensed under the [GPLv3](LICENSE).
See the LICENSE file in the resources folder for more details.
```
===============================================================================
 MinerManager.ps1 - MinerIsma v2.1.1 - Alpha (Gerenciador Solo com Tray Icon)
===============================================================================
PROOF OF EXISTENCE / PRIOR ART RECORD
-------------------------------------------------------------------------------
Registered Previous Version  : BTC_MinerIsma_v2.0.4.rar / MinerIsma_v2.0.4.exe
File Hex Hash .rar Blockchain:
 (0x)D59C650C194ABD5B705A87BC3CA52AB2B0DBF898FDBDB8645893A8348FFC43E9
File Hex Hash .exe GitHub    :
 (0x)562FE5421EFF21B6D3FAC1D961AB70CE99D880ABBD4138DF4746A6302F158A4D
Blockchain Transaction ID    :
 0xbb6f434687e9b242248304dfc50acb855df03f616c0370c582d8eb4e2e36a89b
Blockchain Network: Polygon Mainnet
Subscriber Wallet copyright holders: 0xF72C0Ee272eEf5c52018dA877ED2EF61c9434015
Timestamp: 2026-10-29  04:05 UCT-03 LOCAL
Technical Note: Each record certifies the integrity and precedence of the
complete package corresponding to the immediately preceding Consolidated Version
================================================================================
```
GPLv3 License

Copyright (c) MCIsma / 2026 emcis77@proton.me / EVM: 0xF72C0Ee272eEf5c52018dA877ED2EF61c9434015


> **MinerIsma is a manager: Free, simple, and inclusive for Lottery-style Solo Bitcoin Crypto Mining.**

**MinerIsma** was developed to turn any Windows PC into an active participant in solo Bitcoin mining. Operating quietly and unobtrusively from the Windows System Tray, it automates CPU affinity management, thermal duty cycles, and real-time block monitoring without degrading day-to-day computer performance.

---

##     Tradução para Português do Brasil, a partir da Linha 170 abaixo.

---

## ⚡ Transparency, Security, and Open Source

- **Not malware — cryptocurrency miners often face unfair stigma. The code is 100% open source!**  
  Due to the computational nature of cryptographic hashing algorithms, antivirus software and Windows Defender frequently trigger "false positive" alerts (categorized as PUP or CoinMiner). All MinerIsma source code is fully transparent, auditable, and distributed under the **GNU General Public License v3.0 (GPLv3)**.
- **Secure and Audited Engine:**  
  The application utilizes the well-established, audited **cpuminer-opt (v26.1) by JayDDee**, which is widely trusted and open source within the crypto community.
- **Immutable Blockchain Proof of Existence:**  
  Codebase integrity and intellectual property authorship are permanently registered on the **Polygon Mainnet** blockchain (TxID: `0xbb6f434687e9b242248304dfc50acb855df03f616c0370c582d8eb4e2e36a89b`).

---

## ⚠️ Disclaimer & Operational Notice

> **Use this miner at your own risk! Hardware may run hot, and continuous mining consumes electricity.**

CPU mining places a steady load on your system hardware:
1. Ensure your computer's cooling system (fans, heatsinks, and thermal paste) is in good working order.
2. Be mindful of electricity usage and household energy costs.
3. Take advantage of built-in features such as **Power Profiles**, **Timed Pauses**, and the **Pulse Mode** to maintain hardware temperatures well within safe thresholds.

---

## 💻 System Requirements

- **Operating System:** Windows 10 or Windows 11 (64-bit). 32-bit processors are **not** supported.
- **Processor (CPU):** Any modern x86-64 processor (features automatic CPU architecture detection and runtime optimization for SSE2, AVX, AVX2, AVX-512, SHA, and VAES instruction sets).
- **Bitcoin Wallet:** A valid Bitcoin address (native SegWit `bc1...`, Legacy, or Taproot) to receive the block subsidy and transaction fees (3.125 BTC) if your node solves a block.
- **Internet Connection:** Stable network connection for communication with the mining pool over the Stratum protocol.

---

## 🚀 Key Features

- **Silent System Tray Operation:** Runs minimized next to the Windows clock with zero invasive pop-ups during routine mining.
- **Intelligent CPU Architecture Detection:** Automatically detects whether an AMD or Intel processor is installed and dynamically selects the highest-performing binary optimized for supported instruction sets.
- **Dynamic Thread Affinity Profiles:** Balances computational loads across logical cores using dedicated hexadecimal affinity masks (~10% to ~50% total CPU utilization), ensuring system responsiveness.
- **Pulse Mode (Thermal Cycling):** Automatically alternates between intensive mining runs and 5-minute thermal cooldown periods (available in `2hx5` and `4hx5` cycles).
- **Instant Block Found Alerts:** Comprehensive audiovisual notification system featuring automatic proof screenshot capture and append-only disk logging.
- **Real-Time Luck Statistics (TTF):** Live metrics tracking your Time-to-Find (*Time to Find*) block estimate, upcoming Halving block countdown, and global tracking of recent blocks found by solo miners worldwide.
- **Multilingual UI & Visual Themes:** Dynamic runtime language switching between Portuguese (BR), English (EN), and Spanish (ES), alongside Obsidian (Dark) and Pearl (Light) UI themes.

---

## 📥 Where to Download (Official Sources Only)

The official software package is distributed free of charge **exclusively** through the official channels listed below. **Do not trust third-party mirrors or unauthorized redistributions!**

- 🔗 **Link 1 (Proton Drive):** [Download Official Package](https://drive.proton.me/urls/WF022MG27W#YknkVYHMQO4w)
- 🔗 **Link 2 (Mega.nz - Optional Mirror):** [Download Mirror on Mega](https://mega.nz/folder/1pEAyJRB#ZsvFzL9K-00y0iPqmwc8mQ)
- 🔗 **Link 3 (GitHub Releases):** [Official GitHub Repository Releases](https://github.com/MCIsma/MinerIsma/releases/tag/v2.1.1)

---

## 🛠️ Getting Started

1. Create a folder named **MINER** inside your `Documents` directory.
2. Download the official executable **`BTC_MinerIsma_v2.x.x.exe`** directly into the `MINER` folder created in Documents.
3. Add this folder to Windows Defender antivirus exclusions if background heuristic warnings block the mining executable.
4. Run **`BTC_MinerIsma_v2.x.x.exe`** for the first time:
   - If Windows SmartScreen displays a warning, click **"More info"** and then **"Run anyway"**;
   - A `BTC_MinerIsma` folder will be created and the Miner will start.
   - Run the launcher **`START_MinerIsma.exe`** only if the Miner closes unexpectedly or does not launch with the system.
5. A window will open requesting your Bitcoin wallet address. Enter your wallet address or create a new one.
   - If needed, right-click the MinerIsma icon in the System Tray (beside the Windows clock):
     - Go to **Miner Panel** ➔ **Configure Wallet** and enter your Bitcoin address;
     - Enter your worker name (*Worker*) — choose something like "PCGamer" — and click Save.
     - You're all set! Your computer is now actively competing in the Bitcoin solo mining lottery!

---

## >> If you don't have a Bitcoin wallet yet, follow these steps:

1. Download BlueWallet — it is reliable, free, and beginner-friendly: (https://bluewallet.io)
2. Tap to create a New Simple and Powerful Wallet (under "more");
3. Write down and safeguard your 12 recovery seed words on physical paper with pen! Never take screenshots or save digital notes;
4. **Attention:** Once again, carefully write down and safeguard your 12 recovery words on physical paper with pen! No screenshots or digital notes;
5. All words are in lowercase. Check them twice, do not speak the words out loud, and verify them again;
6. In BlueWallet, tap 'Receive' and copy your newly generated Bitcoin address;
7. Return to MinerIsma at step 5. (Your wallet configuration is saved persistently, so you won't need to re-enter it later).

---

## >>> How to Use:

- Always access all MinerIsma features by **right-clicking** the tray icon (next to the clock).
  - Choose your language and Light/Dark theme at the very top of the Tray Menu;
  - Keep **"Start with Windows"** enabled — Bitcoin mining is a constant act of persistence and faith.
    - Choose a startup delay to allow your internet and Windows background services to fully load before the Miner starts; the default ("Default") is 5 seconds;
  - Choose **"Show / Hide Miner"** to open the Miner Console, where actual hashing operations take place in real time.
  - Under **"Pause / Resume Mining"**, select a temporary pause duration when running heavy workloads on your PC; mining resumes automatically afterward.
    - Select **Pulse Mode** for 5-minute thermal cooldown pauses after every 2 or 4 hours of continuous mining. This also helps cycle and clear RAM.
  - Select your preferred performance profile under the **Power** menu — these are safely calibrated profiles designed to keep your PC smooth and responsive even while mining.
  - Explore key features: **"Test Block Alert"**, **"Statistics: Your Luck"**, and **"Your Miner on Pool"**.
  - Learn about Bitcoin, Cryptocurrency, Blockchain, Financial Freedom, and Privacy through dozens of curated educational links.
  - No investment advice or product endorsements are given here — this is strictly for educational and experimental purposes.
  - Click **"Share MinerIsma"** to copy the download link and invite friends — who knows, if they strike lucky and hit a block, maybe they'll buy us a pizza!

---

## >>>> Easy Updating ⟳:

- MinerIsma will notify you when a new version is available with an active circular arrow icon "**⟳**" at the top of the menu;
1. Click the **⟳** icon or go to **Miner Panel** ➔ **MinerIsma Updates**. A download page will open;
2. Download the new **`BTC_MinerIsma_v2.x.x.exe`** file into the same `MINER` folder previously created in Documents;
3. Run **`BTC_MinerIsma_v2.x.x.exe`** — the previous MinerIsma installation will be automatically updated and replaced;
   - If Windows SmartScreen prompts you, click **"More info"** and **"Run anyway"**;
   - Your existing settings and configurations are fully preserved, and the Miner will restart automatically.

---

## 🤝 Support and Community

- **Support Email:** [emcis77@proton.me](mailto:emcis77@proton.me)
- **Source Code & Issue Tracker:** [GitHub MCIsma/MinerIsma](https://github.com/MCIsma/MinerIsma)

---

## 🧡 Support the Project / Donations

MinerIsma is 100% free and open source. If the project helped you or if you wish to contribute to ongoing development, donations to the official addresses are warmly welcomed:

- **Bitcoin On-Chain:** `bc1qy2wuwjz0c5hcw4r835erf9w7kjz9kmzprvgd7m`
- **Lightning Network:** `lnurl1dp68gurn8ghj7mnpd4jhxtnrda5kummn9e5k7tmvde6hymrs9a5hxmtp2alrwl` *(or via address isma@coinos.io)*
- **EVM Networks (Polygon / Base / Arbitrum / BNB):** `0xF72C0Ee272eEf5c52018dA877ED2EF61c9434015`

---
*Licensed under the GNU General Public License v3.0 (GPLv3).*




---

##               TRADUÇÃO PORTUGUES - BR               ##

---

> **MinerIsma é um gerenciador: Grátis, fácil e inclusivo à Mineração Cripto Solo de Bitcoin ao estilo Lottery.**

O **MinerIsma** foi desenvolvido para transformar qualquer computador com Windows em um nó participante da mineração solo de Bitcoin. Operando de forma discreta a partir da bandeja do sistema (*System Tray*), ele automatiza o gerenciamento de afinidade de CPU, controle térmico e monitoramento de blocos sem interferir na usabilidade do seu computador.

---

## ⚡ Transparência, Segurança e Código Aberto

- **Não é malware, mineradores são alvo de preconceito. O Código é aberto!**  
  Devido à natureza dos algoritmos de mineração criptográfica, softwares antivírus e o Windows Defender frequentemente emitem alertas de "falso positivo" (PUP/CoinMiner). Todo o código do MinerIsma é transparente, auditável e distribuído sob licença livre **GNU General Public License v3.0 (GPLv3)**.
- **Motor Seguro e Auditado:**  
  O aplicativo utiliza como motor de computação o consagrado e auditado **`cpuminer-opt` (v26.1) desenvolvido por JayDDee**, com código aberto e ampla confiabilidade na comunidade cripto.
- **Registro Imutável em Blockchain:**  
  A integridade e autoria da base do código possuem registro oficial de propriedade intelectual e prova de existência gravados na rede **Polygon Mainnet** (TxID: `0xbb6f434687e9b242248304dfc50acb855df03f616c0370c582d8eb4e2e36a89b`).

---

## ⚠️ Aviso de Responsabilidade (Disclaimer)

> **Use o minerador por sua conta e risco! Pode superaquecer, e gasta energia.**

A mineração com processador exige uso contínuo de hardware:
1. Certifique-se de que o sistema de arrefecimento (ventoinhas/coolers e pasta térmica) do seu computador esteja em bom estado.
2. Esteja ciente do impacto no consumo de energia elétrica da sua residência ou escritório.
3. Utilize os recursos integrados de **Perfis de Energia**, **Pausa Temporizada** e o **Modo Pulsar** para manter as temperaturas sempre em níveis seguros.

---

## 💻 Requisitos do Sistema

- **Sistema Operacional:** Windows 10 ou Windows 11 (64 bits). Processadores de 32 bits **não** são suportados.
- **Processador (CPU):** Qualquer processador x86-64 com suporte a instruções modernas (detecção automática para SSE2, AVX, AVX2, AVX-512, SHA e VAES).
- **Carteira de Bitcoin:** É necessário possuir um endereço de carteira Bitcoin válido (SegWit nativo `bc1...`, Legacy ou Taproot) para onde o prêmio do bloco (3.125 BTC) será direcionado caso você encontre a solução.
- **Conexão com a Internet:** Acesso estável à rede para comunicação com a pool via protocolo Stratum.

---

## 🚀 Principais Funcionalidades

- **Operação Silenciosa no Tray:** Fica minimizado ao lado do relógio do Windows, sem janelas invasivas.
- **Detecção Inteligente de CPU:** Identifica se o chip é AMD ou Intel e escolhe dinamicamente o executável otimizado com o melhor conjunto de instruções.
- **Perfis Dinâmicos de Afinidade:** Distribui a carga entre threads lógicas com máscaras hexadecimais balanceadas (~10% a ~50% de uso), evitando congelamentos do sistema.
- **Modo Pulsar (Ciclos Térmicos):** Alterne automaticamente entre períodos de mineração intensa e pausas de alívio de 5 minutos (modos `2hx5` e `4hx5`).
- **Alerta de Bloco Encontrado:** Sistema audiovisual com suporte a captura de tela comprobatória e registro detalhado no log em caso de sucesso.
- **Painel de Sorte (TTF):** Estatísticas em tempo real com estimativa média de tempo até um bloco (*Time to Find*), contagem regressiva para o Halving e consulta do último bloco solo minerado na rede global.
- **Interface Multilíngue e Temas:** Suporte dinâmico a Português (BR), Inglês (EN) e Espanhol (ES), com temas Obsidian (Dark) e Pearl (Light).

---

## 📥 Onde Baixar (Fontes Oficiais)

O pacote oficial está disponível gratuitamente **somente** nos canais listados abaixo. **Não confie em outras fontes ou executáveis redistribuídos por terceiros!**

- 🔗 **Link 1 (Proton Drive):** [Baixar Pacote Oficial](https://drive.proton.me/urls/WF022MG27W#YknkVYHMQO4w)
- 🔗 **Link 2 (Mega.nz - Op.):** [Espelho de Download no Mega](https://mega.nz/folder/1pEAyJRB#ZsvFzL9K-00y0iPqmwc8mQ)
- 🔗 **Link 3 (GitHub Releases):** [Repositório Oficial no GitHub](https://github.com/MCIsma/MinerIsma/releases/tag/v2.1.1)

---

## 🛠️ Como Iniciar

1. Crie uma pasta com nome **MINER** em Documentos.
2. Baixe o executável oficial **`BTC_MinerIsma_v2.x.x.exe`** direto para a pasta MINER criada em Documentos.
3. Adicione a pasta às exclusões do Windows Defender caso haja bloqueio automático do executável de mineração.
4. Execute o **`BTC_MinerIsma_v2.x.x.exe`** pela primeira vez, 
        - Se o Windows "proteger", → "Mais informações" e "Execute assim mesmo";
        - Uma pasta "BTC_MinerIsma" será criada e o Miner iniciará.
        - Execute o inicializador **`START_MinerIsma.exe`**, somente caso o Miner se feche ou não inicia junto com o sistema.
5. Uma janela se abrirá para solicitar a sua carteira Bitcoin, insira a carteira, ou providencie uma.
        - Se precisar, Clique com o botão direito no ícone do MinerIsma na bandeja do sistema (ao lado do relógio),
        - Em **Painel do Minerador** ➔ **Configurar Carteira** e insira seu endereço de Bitcoin,
        - E o nome do seu trabalhador (*Worker*), insira algo como "PCGamer", e Salve.
        - Pronto! Seu computador já está concorrendo na loteria da rede Bitcoin!

---

##  >> Caso não possua uma carteira Bitcoin, sigas esses passos:

1. Baixe a Blue Wallet, é boa, gratuita e fácil; (https://bluewallet.io)
2. Crie uma Nova Carteira Simples e Poderosa, em mais;
3. Guarde BEM as 12 palavras, Papel e Caneta! Nada de Foto ou Notas;
4. Atenção: De novo, guarde BEM as 12 palavras, Papel e Caneta! Nada de Foto ou Notas;
5. Tudo minúscula, não erre, confira 2x, não pronuncie as palavras, agora confira novamente;
6. Em 'Receber' na Blue Wallet, copie o seu novo endereço Bitcoin;
7. Volte ao MinerIsma, lá no passo 5. (Sua carteira ficará salva, não precisa inserir novamente depois).

---

##  >>> Como usar:

 - Sempre acesse todas as Funcionalidades do MinerIsma, com o botão Direito do Mouse, no Ícone no Tray (ao lado do relógio).
        - Escola o idioma, Modo Claro/Escuro no Topo do Menu do ícone no tray;
        - Mantenha "Iniciar com Windows" habilitado, mineração de Bitcoin é um ato de fé constante. 
               - Escolha o delay para dar tempo a sua internet e Windows carregar antes do Miner, o "Padrão" é 5 segundos;
        - Escolha "Mostrar / Ocultar Miner" para ver o Console do Minerador, é onde tudo acontece de fato.
        - Em "Pausar/Retomar Mineracao" escolha tempo necessário para tarefas de alta demanda do Pc, depois volta a mineração,
               - Escolha Pulsar para Pausas Térmicas de 5min. após 2 ou 4 horas de mineração. Isso também ajuda com a RAM.
        - Escolha o perfil de potência desejado no menu **Power**, são perfis seguros para manter seu Pc em atividade fluida mesmo durante a mineração.
        - Explore funcionalidades interessantes: "Testar Alerta de Bloco", "Estatística: Sua Sorte" e "Seu Miner na Pool".
        - Aprenda sobre Bitcoin, Criptomoeda, Blockchain, Liberdade Financeira e Privacidade com dezenas de links úteis.
        - Não recomendo aqui produtos ou investimentos, é apenas aprendizado.
        - Use o botão "Compartilhar MinerIsma" para copiar o link e indicar o MinerIsma para seus amigos, quem sabe eles ficam ricos e pague uma pizza para eu e para você!!

---

## >>>> Atualização Fácil ⟳:

 - Seu MinerIsma avisará quando houver atualização comum ícone de seta redonda "⟳" aceso no topo do Menu;
 1. Clique o ícone ⟳ ou em **Painel do Minerador** ➔ **Atualizacoes MinerIsma**. Uma página para Download se abrirá;
 2. Baixe o novo arquivo **`BTC_MinerIsma_v2.x.x.exe`** para a mesma pasta MINER criada anteriormente em Documentos;
 3. Execute o **`BTC_MinerIsma_v2.x.x.exe`**, o MinerIsma antigo será substituído automaticamente;
        - Se o Windows "proteger", → "Mais informações" e "Execute assim mesmo";
        - Suas configurações estarão a salvo e restabelecidas, o Miner reiniciara automaticamente.

---

## 🤝 Suporte e Comunidade

- **E-mail de Suporte:** [emcis77@proton.me](mailto:emcis77@proton.me)
- **Desenvolvimento e Código:** [GitHub MCIsma/MinerIsma](https://github.com/MCIsma/MinerIsma)

---

## 🧡 Apoie o Projeto

O MinerIsma é 100% gratuito e de código aberto. Se o projeto te ajudou ou se você deseja contribuir com o desenvolvimento contínuo, envie qualquer quantia para o endereço oficial:

- **Bitcoin On-Chain:** `bc1qy2wuwjz0c5hcw4r835erf9w7kjz9kmzprvgd7m`
- **Lightning Network:** `lnurl1dp68gurn8ghj7mnpd4jhxtnrda5kummn9e5k7tmvde6hymrs9a5hxmtp2alrwl` *(ou via chave isma@coinos.io)*
- **Redes EVM (Polygon / Base / Arbitrum / BNB):** `0xF72C0Ee272eEf5c52018dA877ED2EF61c9434015`

---
*Licenciado sob a GNU General Public License v3.0 (GPLv3).*


