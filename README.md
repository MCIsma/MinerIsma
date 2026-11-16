# MinerIsma v2.2.0 (Beta) — Gerenciador de Mineração Solo de Bitcoin

## ⚖️ License
This project is licensed under the [GPLv3](LICENSE).
See the LICENSE file in the resources folder for more details.
```
===============================================================================
MinerIsma v2.2.0 Beta - MinerManager.ps1 - Gerenciador Miner Solo BTC Tray Icon
===============================================================================
  PROOF OF EXISTENCE / PRIOR ART RECORD / INTELLECTUAL PROPERTY REGISTRATION
-------------------------------------------------------------------------------
Registered Previous Version : MinerIsma_v2.1.2.exe - Consolidated File Hex Hash:
 (0x)E5FE414E13E83C5CAC49A4AF3455715E99E637461EDC99AB7EDC78939A433637
Blockchain Network Polygon Mainnet / Ethereum Mainnet - Transaction ID:
polygonscan: 0x0e3f70814115e5bbbb66409f61944c560e99b498befcbd9d1a37c9b8c4b7e00e 
Subscriber Wallet copyright holders: 0xF72C0Ee272eEf5c52018dA877ED2EF61c9434015
Copyright (c) MCIsma /2026 GNU General Public License v3.0 - resources\LICENSE⚖️
Algoritmo Hash: SHA-256 (Get-FileHash) Timestamp: 2026-11-11 20:47 UCT-03 LOCAL
Technical Note: Each record attests to the integrity and precedence of the
complete package corresponding to the immediately preceding Consolidated Version
A detailed version history is available at: resources\RELEASE_NOTES.md.
================================================================================
```
GPLv3 License

Copyright (c) MCIsma / 2026 emcis77\@proton.me / EVM: 0xF72C0Ee272eEf5c52018dA877ED2EF61c9434015


## **MinerIsma is a free, easy-to-use, and inclusive manager for lottery-style solo Bitcoin mining.**

**MinerIsma** was developed to turn any computer running Windows 10/11 into a participating node for solo Bitcoin mining. Operating discreetly from the system tray, it automates CPU affinity management, thermal control, and block monitoring—all without interfering with your computer's usability.

---

### 🇧🇷 [Acesse a Tradução para Português do Brasil clicando aqui](#readme-em-portugues-br)

---

## ⚡ Transparency, Security, and Open Source

- **It is not malware; miners are often unfairly stigmatized. The code is open source!**  
  Due to the nature of cryptographic mining algorithms, antivirus software and Windows Defender frequently trigger "false positive" alerts (such as PUP or CoinMiner detections). The entire source code for MinerIsma and its underlying engines is transparent, auditable, and distributed under the **GNU General Public License v3.0 (GPLv3)**.
- **Secure and Audited Engine:**  
  The application utilizes the well-established and audited **`cpuminer-opt` (v26.1) engine—developed by JayDDee**—it is open-source and widely trusted within the crypto community.
- **Immutable Record on Blockchain:**  
  The integrity and authorship of the codebase are secured via an official intellectual property record and proof of existence, anchored on the **Polygon Mainnet** or **Ethereum Mainnet** blockchains. All such perpetual transactions are signed by the copyright holders using the EVM-compatible wallet: `0xF72C0Ee272eEf5c52018dA877ED2EF61c9434015`.

---

## 🔒 Privacy & Data Policy

**MinerIsma** is open-source, free, and completely portable:
- **Zero Telemetry:** No personal data, hardware identifiers, or usage statistics are collected or shared.
- **100% Local:** All configurations and log files remain exclusively on your computer.
- **Public Queries Only:** Network requests are limited strictly to chosen mining pools, local nodes (RPC), and public API checks (prices and halving estimates).
- **Safe:** It never requests or accesses private keys or wallet seeds.

For full details, please check the [PRIVACY.md](PRIVACY.md) file.

---

## ⚠️ Disclaimer & Operational Notice

> **Use the miner at your own risk! It may cause your PC to overheat and increases power consumption.**

- CPU mining requires continuous hardware usage:
  - Ensure that your PC’s cooling system (fans/coolers and thermal paste) is in good condition.
- Be aware of the impact on electricity consumption in your home or office.
- Use the built-in **Power Profiles** and **Pulse Mode** features to keep temperatures within safe levels at all times. All pre-configured power levels are safe, controlled, and tested; however, they require careful monitoring and dedicated observation, as performance may vary from one PC to another.
- Using custom settings in **Advanced Mode** may carry additional risks and could destabilize your PC. Proceed at your own risk, and only if you possess advanced technical knowledge. The use of Advanced Mode on laptops is strongly discouraged.
- The various topics covered in MinerIsma are for educational purposes only; they do not constitute recommendations or offers to sell products, services, or investments.
- There are no recurring earnings in the form of Bitcoin fractions, nor is there any guarantee of success—it is simply a matter of "trying your luck."
  - There is an extremely remote possibility of discovering a Bitcoin block approximately every 10 minutes; it is like a lottery ticket with highly improbable odds against thousands of others—but luck is luck!

---

## 💻 System Requirements

- **Operating System:** Windows 10 or Windows 11 (64-bit). 32-bit processors are **not** supported.
- **Processor (CPU):** Any x86-64 processor with support for modern instruction sets (automatic detection for SSE2, AVX, AVX2, AVX-512, SHA, and VAES).
- **Bitcoin Wallet:** You must have a valid Bitcoin wallet address (Native SegWit `bc1...`, Legacy, or Taproot) where the block reward (3.125 BTC) will be sent if you find the solution.
- **Internet Connection:** A stable network connection is required to communicate with the pool via the Stratum protocol (or with your Local Bitcoin Core Node via RPC). Bandwidth consumption, however, is extremely low.
- **Faith and Consistency:** There is no point in running **MinerIsma** at *maximum capacity* for just an hour or a week, hoping to make some quick cash, only to stop or give up shortly after. *Solo Lottery Mining* is a process that requires perseverance, persistence, and patience—take it easy and just let it run! In the meantime, check out the links provided and learn more about Bitcoin.

---

## 🚀 Key Features

- **Exposure to Luck:** **MinerIsma** manages the execution of the best CPU-based mining engine for Bitcoin’s SHA256 algorithm—**cpuminer-opt**—offering you the (unlikely, yet possible) chance for your processor to calculate and *match* a block hash. This triggers the *birth* of **3.125 BTC**, which is delivered straight to your wallet! Remember us if this happens to you! 🙌
- **Silent System Tray Operation:** The application runs minimized next to the Windows clock, free from intrusive windows or disruptive actions. It is designed to work calmly and consistently, discreetly striving to increase your wealth every single day. No manual intervention is required—simply keep an eye on your PC’s temperature during the first few days and throughout the summer. Find your optimal balance of power.
- **Intelligent CPU Detection:** The software identifies whether your chip is AMD or Intel, dynamically selecting the optimized executable that utilizes the best instruction set for your specific hardware.
- **Dynamic Affinity Profiles:** Workloads are distributed across logical threads using balanced hexadecimal masks (~10% to ~50% usage), preventing system freezes while maximizing mining performance. Includes a quick shortcut (**"Your Threads on PC"**) that opens Windows Task Manager directly in the Logical Processors graph view.
- **Pulse Mode (Thermal Cycling & RAM Restoration):** Automatically toggle between periods of intensive mining and 5-minute cooling breaks (available in `2hx5` and `4hx5` modes). This smart feature also restores RAM periodically for the operating system—especially useful when mining on a local Bitcoin Core node.
- **Block-Found Alert & Global Mute (`🔇`):** An audiovisual notification system that includes automatic screenshot capture and detailed log entries upon a successful find. The system supports testing 4 custom audio alerts or enabling a global **Mute** option that silences all program sounds.
- **Luck Dashboard (TTF):** Real-time statistics, including an estimated *Time to Find* (TTF) for the next block, a countdown to the Halving, and information on the most recent solo block mined on the global network.
- **Advanced Mode (Latency Test, Own Node & Hard Profile):** Features a real-time **Pool/Node Latency Tester** (TCP/ICMP Ping), **Noble User Mode** for mining directly to your own Bitcoin Core node via RPC (`127.0.0.1:8332`), and **Hard User Mode** for custom thread/affinity configurations with profile recovery.
- **Multilingual Interface & Themes:** Complete dynamic and instant support for Portuguese (BR), English (EN), and Spanish (ES), plus three additional interface languages: French (FR), German (DE), and Arabic (AR). Includes smart OS language detection on first run, external language pack support (`MinerIsma_Langs.json`) with a dynamic submenu, and seamless switching between "Obsidian" (Dark) and "Pearl" (Light) themes.
- **Educational & Useful Content:** Curated resources for learning about money, Bitcoin and freedom, crypto-assets, financial markets, security, and privacy—plus real-time Bitcoin, Dollar, and Euro price tracking.
- **High-Efficiency Engine:** The engine driving the impressive mining performance of MinerIsma is the powerful *cpuminer-opt*, optimized by JayDDee. It is capable of delivering at least 50 times the power of a "NerdMiner" device, using only a single thread of your computer! Depending on your processor, this performance can actually exceed 300 times that of a NerdMiner on a single thread.
- **Portability:** **MinerIsma** is fully portable; it runs from any folder on Windows—even from external storage devices. **MinerIsma** is designed to be intelligent, accessible, inclusive, and adaptive.

---

## 📥 Where to Download (Official Sources Only)

The official **`MinerIsma_v2.x.x.exe`** package is available for free **only** through the channels listed below. **Do not trust other sources or executables redistributed by third parties!**

- 🔗 **Link 1 (Proton Drive):** [Download Official Package](https://drive.proton.me/urls/WF022MG27W#YknkVYHMQO4w)
- 🔗 **Link 2 (Mega.nz - Alt.):** [Download Mirror on Mega](https://mega.nz/folder/1pEAyJRB#ZsvFzL9K-00y0iPqmwc8mQ)
- 🔗 **Link 3 (GitHub Releases):** [Official GitHub Repository](https://github.com/MCIsma/MinerIsma/releases)

---

## 🛠️ Getting Started

1. Create a folder named **MINER** in your Documents directory.
2. Download the official executable **`MinerIsma_v2.x.x.exe`** directly into this **MINER** folder in Documents.
3. Add this folder to your Windows Defender exclusions to prevent the mining program from being automatically blocked.
   - See the "Antivirus Settings" mini-tutorial below for instructions on how to do this.
4. Run **`MinerIsma_v2.x.x.exe`** for the first time:
   - If Windows displays a "protected your PC" message, click "More info" and then "Run anyway."
   - A folder named "BTC_MinerIsma" will be created, and the miner will start automatically.
> **Only run `START_MinerIsma.exe` if the miner closes unexpectedly or fails to launch automatically with your system.**
5. A window will appear asking for your Bitcoin wallet address; enter your wallet address, or create one using the provided link.
   - If needed, you can access MinerIsma by right-clicking its icon in the system tray (near the clock).
   - Go to **Miner Panel** ➔ **Your Bitcoin Wallet** and enter your Bitcoin address.
   - In the **Worker** field, enter a name (e.g., "PCGamer") and click Save. (You only need to do this once.)
   - You're all set! Your computer is now participating in the Bitcoin network lottery!

### 🛡️ Mini-tutorial: Antivirus Settings – Adding an Exception

> *It’s not malware; there are no viruses! Miners are often unfairly maligned. The code is open-source!*  
> (*Cars were once banned in Birmingham, UK, simply because criminals used them to commit robberies.*)

#### How to configure:

1. **On Windows:**
   - Windows Security → Virus & threat protection → Manage settings → Exclusions
   - Add or remove exclusions: Create an exception for the new **MINER** folder you’ve created.
2. **In your Antivirus software:** Every antivirus program is different, but generally, look for something like this:
   - Menu → Settings → Exceptions/Exclusions → Add Exception → File/Folder
   - Navigate to the **MINER** folder you created (in your Documents), select it (or check the box), and click OK.
   - Once you have downloaded the **MinerIsma_v2.x.x.exe** file into the **MINER** folder, add an exception for that file as well.
   - **Note on Pool Dashboard Links (`web.public-pool.io`):** Some third-party antivirus "Web Shields" may display a warning when opening **Your Miner on Pool** simply because the pool's website is categorized under "Cryptocurrency Mining." The dashboard is a safe, read-only public statistics page—you can safely allow/proceed in your browser or check your stats from your phone.

---

## 📝 If you do not have a Bitcoin wallet, follow these steps:

Download **Blue Wallet**—it’s a great, free, and user-friendly option: (https://bluewallet.io)

1. Create a new, simple, yet powerful wallet by tapping the plus (+) icon;
2. Keep your 12-word recovery phrase safe—use pen and paper! Do not take photos or store them in digital notes; this is serious;
   - Use only lowercase letters, ensure there are no typos, double-check everything, do not say the words out loud, and then check them once more;
   - Remember: Keep those 12 words safe—pen and paper only! No photos, no digital notes;
   - These 12 words are the only way to access your funds; if you lose them, there is no one you can turn to for help!
3. In **Blue Wallet**, go to "Receive" and copy your new Bitcoin address;
   - Return to **MinerIsma** and proceed to step 5.

---

## ⛏️ How to use:

Access all **MinerIsma** functions by right-clicking the icon in the system tray (next to the clock).

- Select your language (by clicking directly on **[BR]/[EN]/[ES]** or via the side arrow), choose between **Light/Dark Mode**, and view the current **Bitcoin price** at the top of the tray menu.
- Keep "Start with Windows" enabled; Bitcoin mining is an **act of constant faith**.
  - Set a **delay** to allow your internet connection and Windows to load before the miner starts; the "Default" is 5 seconds.
- Select "Show / Hide Miner" to view the miner console—this is where the actual work happens.
- Use "Pause/Resume Mining" to temporarily halt operations during high-demand PC tasks, then resume mining afterward.
  - Select "Pulse" for 5-minute thermal breaks after 2 or 4 hours of mining; this also periodically restores RAM.
- Choose your preferred power profile under the **Power** menu. These are safe settings designed to keep your PC running smoothly, even while mining.
  - Monitor your PC's temperature and fan noise—especially during the summer—to find the right balance between performance, comfort, and your specific usage needs.
  - If using a laptop, keep it plugged into a power source. Select fewer threads and use "Pulse Mode," as cooling systems in laptops are often limited. Do not use "Advanced Mode" on a laptop.
- Explore useful features in **Miner Panel** ("Your Bitcoin Wallet," "Stats: Your Luck," "Your Miner on Pool," "Your Threads on PC," and "Advanced Mode") and **"Test Block Alert"** (including the **Mute** option).
- Visit **Tutorial & Feedback** to read the built-in tutorial, visit MinerIsma on the Web, send your feedback via **"Suggestion & Experience,"** or support the project.
- Learn about Bitcoin, cryptocurrency, blockchain, financial freedom, self-custody, and privacy through dozens of helpful links.
  - Please note: I do not endorse any specific products or investments; this is strictly for educational purposes.
- Use the "Share MinerIsma" button to copy the link and refer **MinerIsma** to your friends—who knows, maybe one of them will get rich and buy us both a pizza!! 🍕 *The more people mining, the stronger we become* 💪

---

## 🔄️ Easy Update ⟳:

- MinerIsma will notify you when an update is available by displaying a circular arrow icon "⟳" at the top of the menu;
1. Click the ⟳ icon or go to **Miner Panel** ➔ **MinerIsma Updates**. A download page will open;
2. Download the new **`MinerIsma_v2.x.x.exe`** file into the same "MINER" folder you previously created in your Documents;
3. Run the **`MinerIsma_v2.x.x.exe`** file; the old version of MinerIsma will be automatically replaced by the new one;
   - If Windows displays a "protected your PC" message, select "More info" and then "Run anyway";
   - Your settings will be preserved and restored, and the miner will restart automatically.

---

## 🗂️ Files comprising MinerIsma, within its root folder "BTC_MinerIsma"—full structure:

- **MINER folder or Documents** (Suggested download location on the user's PC)
  - `MinerIsma_v2.X.X.exe` (SFX .exe file → Generates the portable "BTC_MinerIsma" folder on the user's PC)
    - **BTC_MinerIsma folder** (Folder generated by the MinerIsma_v2.X.X.exe executable)
      - `START_MinerIsma.exe` (Launcher—formerly a .bat file; handles Windows startup and manual user execution)
      - `README.md` (About/Registration/License/Summary/Functions/Disclaimer/Structure)
      - **"bin" folder** (Contents of cpuminer-opt)
        - 8 `cpuminer...exe` files
        - 5 `.dll` files
        - 4 `cpuminer-opt` documentation files
        - `MinerManager.ps1` → MinerIsma management script
      - **"resources" folder**
        - `iconeMinerIsmaFull4b.ico`
        - `Leia-ME.txt` (Contains a copy of the README in Portuguese)
        - `LICENSE` (Standard GPLv3 license, restricting commercial use of the open-source MinerIsma)
        - `MinerIsma AUDITS.txt` (Continuous health checks for the files included in the SFX archive)
        - `MinerIsma AUDITS.md` (Continuous health checks for the files included in the SFX archive)
        - `MinerIsma_Langs.json` (External multilingual pack for FR, DE, AR, and future languages)
        - `PRIVACY.md` (Commitment File Regarding Non-Collection of User Data)
        - `QRcode-LNURL-BTC_On-EVM-1800x580_450dpi.png` (Image file for the "Support the Project, Donate" window)
        - `README.txt` (A .txt version of the README for easy user access)
        - `RELEASE_NOTES.md` (Proof of Existence – Blockchain – Continuous logging – Updates)
        - `Tutorial.html`
        - 4 `.mp3` files (for "block_alert")
        - 3 `.mp3` files (for "animated_buttons")

> *Do not remove or alter any folders or files; all content is essential for the system to function efficiently.*

### Files Generated During Use of MinerIsma
- **BTC_MinerIsma folder** (Folder generated by the MinerIsma_v2.X.X.exe executable)
  - `BLOCK_FOUND_LOG.txt` (Log of blocks found → Eureka!)
  - `MinerIsma_Stats_2026xxxx_024xxx.png` (Screenshots—an optional user feature)
  - **"resources" folder**
    - `MinerIsma_Config.json` (File for saving and loading user configurations)
    - `MinerIsma_TTF_LOG.txt` (File for saving and loading statistics)
    - `MinerManager_ERROS.log` (Log file for any identified errors)
- `→ C:\Users\Your User\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`
  - `MinerIsma.lnk` (Shortcut for automatic startup → Created via the system tray icon)
- `→ C:\Users\Your User\Desktop`
  - `MinerIsma.lnk` (Shortcut to "START_MinerIsma.exe" → Created via the system tray icon)
- `→ C:\Users\Your User\AppData\Local\MinerIsma`
  - **MinerIsma folder** (System backup folder for MinerIsma)
    - `MinerIsma_Config.json` (Backup file for saved configurations)
    - `MinerIsma_TTF_LOG.txt` (Backup file for statistics)

---

## 🤝 Support and Community

- **Feedback & Suggestions Form:** [Google Forms - Suggestion & Experience](https://docs.google.com/forms/d/e/1FAIpQLSe43fnq_EONpBqmIk37Shyf3j1WiWqDaPfECperMae3x2Purg/viewform?usp=publish-editor)
- **Support Email:** [emcis77\@proton.me](mailto:emcis77@proton.me)
- **Source Code & Issue Tracker:** [GitHub MCIsma/MinerIsma](https://github.com/MCIsma/MinerIsma)

---

## 🧡 Support the Project / Donations

MinerIsma is 100% free and open-source. If the project has helped you, provided a learning opportunity, or if you would like to contribute to its ongoing development, please send any amount to the official address:

- **Bitcoin On-Chain:** `bc1qy2wuwjz0c5hcw4r835erf9w7kjz9kmzprvgd7m`
- **Lightning Network:** `lnurl1dp68gurn8ghj7mnpd4jhxtnrda5kummn9e5k7tmvde6hymrs9a5hxmtp2alrwl` *(or via address isma\@coinos.io)*
- **EVM Networks (Polygon / Base / Arbitrum / BNB):** `0xF72C0Ee272eEf5c52018dA877ED2EF61c9434015`
- **Support the cpuminer-opt Engine (BTC):** `12tdvfF7KmAsihBXQXynT6E6th2c2pByTT`

---
*Licensed under the GNU General Public License v3.0 (GPLv3).*

<br>

---

<a id="readme-em-portugues-br"></a>
# README em Português BR

*(⬆️ [Back to English / Voltar ao Topo](#minerisma-v220-beta--gerenciador-de-mineração-solo-de-bitcoin))*

---

## **MinerIsma é um gerenciador grátis, fácil e inclusivo à Mineração Solo de Bitcoin ao estilo Lottery.**

O **MinerIsma** foi desenvolvido para transformar qualquer computador com Windows 10/11 em um nó participante da mineração solo de Bitcoin. Operando de forma discreta a partir da bandeja do sistema (*System Tray*), ele automatiza o gerenciamento de afinidade de CPU, controle térmico e monitoramento de blocos sem interferir na usabilidade do seu computador.

---

## ⚡ Transparência, Segurança e Código Aberto

- **Não é malware, mineradores são alvo de preconceito. O Código é aberto!**  
  Devido à natureza dos algoritmos de mineração criptográfica, softwares antivírus e o Windows Defender frequentemente emitem alertas de "falso positivo" (PUP/CoinMiner). Todo o código do MinerIsma e seus motores são transparentes, auditáveis e distribuídos sob licença livre **GNU General Public License v3.0 (GPLv3)**.
- **Motor Seguro e Auditado:**  
  O aplicativo utiliza como motor de computação o consagrado e auditado **`cpuminer-opt` (v26.1) desenvolvido e otimizado por JayDDee**, com código aberto e ampla confiabilidade na comunidade cripto.
- **Registro Imutável em Blockchain:**  
  A integridade e autoria da base do código possuem registro oficial de propriedade intelectual e prova de existência gravados em Blockchain, nas redes **Polygon Mainnet** ou **Ethereum Mainnet**, com transações perpétuas sempre assinadas pelos detentores de direitos autorais Wallet EVM: `0xF72C0Ee272eEf5c52018dA877ED2EF61c9434015`.

---

## 🔒 Privacidade e Dados

**MinerIsma** é de código aberto, gratuito e 100% portátil:
- **Zero Telemetria:** Nenhum dado pessoal, identificador de hardware ou estatística de uso é coletado ou transmitido.
- **Totalmente Local:** Todas as configurações e arquivos de log residem exclusivamente no seu computador.
- **Apenas Consultas Públicas:** As conexões de rede limitam-se à pool de mineração definida, ao nó local (RPC) e a consultas públicas de cotação e rede.
- **Segurança:** Nunca solicita, armazena ou tem acesso a chaves privadas ou sementes (*seeds*) de carteira.

Para mais informações, consulte o arquivo [PRIVACY.md](PRIVACY.md).

---

## ⚠️ Aviso de Responsabilidade (Disclaimer)

> **Use o minerador por sua conta e risco! Pode superaquecer seu Pc, e aumenta o consumo de energia.**

- A mineração com processador exige uso contínuo de hardware:
  - Certifique-se de que o sistema de arrefecimento (ventoinhas/coolers e pasta térmica) do seu Pc esteja em bom estado.
- Esteja ciente do impacto no consumo de energia elétrica da sua residência ou escritório.
- Utilize os recursos integrados de **Perfis de Energia** e o **Modo Pulsar** para manter as temperaturas sempre em níveis seguros. Todos os níveis de potência pré-configurados são seguros, controlados e testados, mas requerem monitoramento especial e observação dedicada, pois podem funcionar de forma diferente em cada Pc.
- A utilização de configurações customizadas do **Modo Avançado** pode trazer ainda mais riscos e desestabilizar o funcionamento do Pc. Use por sua conta e risco, apenas se você tiver conhecimento avançado. É desaconselhado o uso de Modo Avançado em Notebook.
- Os diversos tópicos contidos no MinerIsma são exclusivamente para fins educativos, não constituindo recomendação ou venda de produtos, serviços ou investimentos!
- Não há ganhos recorrentes de frações de Bitcoin, nem mesmo a garantia de sucesso, é apenas *Tentar a Sorte*.
  - Existe uma possibilidade muito infimamente remota de descobrir um Bloco de Bitcoin a cada ~10min., é um bilhete de Loteria com chances quase improváveis contra milhares de outros, mas sorte é sorte!

---

## 💻 Requisitos do Sistema

- **Sistema Operacional:** Windows 10 ou Windows 11 (64 bits). Processadores de 32 bits **não** são suportados.
- **Processador (CPU):** Qualquer processador x86-64 com suporte a instruções modernas (detecção automática para SSE2, AVX, AVX2, AVX-512, SHA e VAES).
- **Carteira de Bitcoin:** É necessário possuir um endereço de carteira Bitcoin válido (SegWit nativo `bc1...`, Legacy ou Taproot) para onde o prêmio do bloco (3.125 BTC) será direcionado caso você encontre a solução.
- **Conexão com a Internet:** Acesso estável à rede para comunicação com a pool via protocolo Stratum (ou com seu Node Bitcoin Core via RPC). O consumo de banda é extremamente baixo.
- **Fé e Constância:** Não adianta você rodar o **MinerIsma** *no máximo* durante uma hora ou uma semana pensando em ganhar uma grana e parar ou desistir tão rápido. A *Mineração Solo Lottery* é um processo de perseverança, persistência e paciência, pegue leve e deixe rodando! Enquanto isso, aproveite os links e Aprenda Bitcoin.

---

## 🚀 Principais Funcionalidades

- **Exposição à Sorte:** O **MinerIsma** gerencia a execução do melhor motor de mineração com CPU para o algoritmo SHA256 do Bitcoin, o **cpuminer-opt**, e te dá a possibilidade (quase improvável, mas possível) de seu processador calcular e *casar* a Hash de um Bloco, desbloqueando o *Nascimento* de **3.125 BTC** que vêm ao mundo direto para sua carteira! Lembre de nós se isso acontecer com você 🙌
- **Operação Silenciosa no Tray:** Fica minimizado ao lado do relógio do Windows, sem janelas invasivas ou ações intrusivas. Feito para trabalhar calma e constantemente, todos os dias discretamente tentando te fazer mais rico, sem nenhuma ação necessária, exceto observância da temperatura do Pc nos primeiros dias e no verão. Encontre a potência de equilíbrio.
- **Detecção Inteligente de CPU:** Identifica se o chip é AMD ou Intel e escolhe dinamicamente o executável otimizado com o melhor conjunto de instruções.
- **Perfis Dinâmicos de Afinidade:** Distribui a carga entre threads lógicas com máscaras hexadecimais balanceadas (~10% a ~50% de uso), evitando congelamentos do sistema e ampliando o desempenho da mineração. Conta também com o atalho **"Suas Threads no Pc"**, que abre o Gerenciador de Tarefas do Windows diretamente nos gráficos de Processadores Lógicos.
- **Modo Pulsar (Ciclos Térmicos e Restauração de RAM):** Alterne automaticamente entre períodos de mineração intensa e pausas de alívio de 5 minutos (modos `2hx5` e `4hx5`). Essa função inteligente também restaura a memória RAM periodicamente para o sistema operacional, especialmente útil na mineração com Node Próprio.
- **Alerta de Bloco Encontrado e Função Mutar (`🔇`):** Sistema audiovisual com suporte a captura de tela comprobatória e registro detalhado no log em caso de sucesso, com possibilidade de testar 4 alertas sonoros ou ativar a opção **Mutar** para silenciar todos os sons do programa.
- **Painel de Sorte (TTF):** Estatísticas em tempo real com estimativa média de tempo até um bloco (*Time to Find*), contagem regressiva para o Halving e consulta do último Bloco Solo minerado na rede global.
- **Modo Avançado (Teste de Latência, Node Próprio e Perfil Hard):** Inclui medidor de **Latência da Pool/Node** em tempo real (Ping TCP/ICMP), **Modo Usuário Nobre** para minerar diretamente no seu Node Bitcoin Core via RPC (`127.0.0.1:8332`) e **Modo Usuário Hard** para controle manual de threads/afinidade com recuperação de perfil salvo e indicador `Custom Avancado: NTh`.
- **Interface Multilíngue e Temas:** Suporte dinâmico e instantâneo completo a Português (BR), Inglês (EN) e Espanhol (ES), além de mais três idiomas com suporte dedicado à interface: Francês (FR), Alemão (DE) e Árabe (AR). Inclui ainda detecção inteligente do idioma do S.O. na primeira execução, suporte a carregamento de pacote externo (`MinerIsma_Langs.json`) com submenu dinâmico e troca fluida entre os temas Obsidian (Dark) e Pearl (Light).
- **Conteúdo Educativo e Útil:** Links de conteúdos para aprendizado sobre Dinheiro, Bitcoin e Liberdade, Criptoativos, Mercado Financeiro, Custódia, Segurança e Privacidade, além de Cotação do Bitcoin, Dólar e Euro em Tempo Real.
- **Motor de Alta Eficiência:** O motor por trás da incrível mineração do MinerIsma é o potente `cpuminer-opt` otimizado por JayDDee, que é capaz de superar em pelo menos 50 vezes a potência de um dispositivo minerador NerdMiner, usando apenas 1 Thread de seu Computador! Ou seja, cada única thread de seu Pc entrega no mínimo 50x mais potência do que um famoso aparelho minerador de Bitcoin NerdMiner. Essa potência na realidade pode ultrapassar 300x numa única thread de acordo com seu processador.
- **Portabilidade:** O **MinerIsma** é totalmente portátil, funciona em qualquer pasta do Windows, até mesmo em dispositivos externos. **MinerIsma** é inteligente, acessível, inclusivo e adaptativo.

---

## 📥 Onde Baixar (Fontes Oficiais)

O pacote oficial **`MinerIsma_v2.x.x.exe`** está disponível gratuitamente **somente** nos canais listados abaixo. **Não confie em outras fontes ou executáveis redistribuídos por terceiros!**

- 🔗 **Link 1 (Proton Drive):** [Baixar Pacote Oficial](https://drive.proton.me/urls/WF022MG27W#YknkVYHMQO4w)
- 🔗 **Link 2 (Mega.nz - Op.):** [Espelho de Download no Mega](https://mega.nz/folder/1pEAyJRB#ZsvFzL9K-00y0iPqmwc8mQ)
- 🔗 **Link 3 (GitHub Releases):** [Repositório Oficial no GitHub](https://github.com/MCIsma/MinerIsma/releases)

---

## 🛠️ Como Iniciar

1. Crie uma pasta com nome **MINER** em Documentos.
2. Baixe o executável oficial **`MinerIsma_v2.x.x.exe`** direto para essa pasta **MINER** em Documentos.
3. Adicione a pasta às exclusões do Windows Defender para evitar bloqueio automático do programa de mineração.
   - Veja como fazer isso no mini-tutorial Configurações Antivírus abaixo.
4. Execute o **`MinerIsma_v2.x.x.exe`** pela primeira vez:
   - Se o Windows "proteger", clique em → "Mais informações" e "Executar assim mesmo";
   - Uma pasta "BTC_MinerIsma" será criada e o Miner iniciará automaticamente.
> **Execute `START_MinerIsma.exe` somente caso o Miner se feche ou não inicie junto com o sistema.**
5. Uma janela se abrirá solicitando sua carteira Bitcoin; insira a carteira ou providencie uma no link.
   - Se precisar, acesse o MinerIsma com o botão direito no ícone na bandeja do sistema, junto ao relógio.
   - Vá em **Painel do Minerador** ➔ **Sua Carteira Bitcoin** e insira seu endereço de Bitcoin.
   - No Trabalhador (*Worker*), insira algo como "PCGamer" e clique em Salvar. (Isso só é necessário uma única vez.)
   - Pronto! Seu computador já está concorrendo na loteria da rede Bitcoin!

### 🛡️ Mini-tutorial Configurações Antivírus - Adicione Exceção

> *Não é malware, não há vírus! Mineradores são alvo de preconceito. O Código é aberto!*  
> (*Carros já foram proibidos em Birmingham-UK, pois eram usados por bandidos em seus roubos*)

#### Configure:

1. **No Windows:**
   - Segurança do Windows → Proteção contra vírus e ameaças → Gerenciar configurações → Exclusões
   - Adicionar ou remover exclusões: Crie uma exceção para a nova pasta **MINER** criada.
2. **No Antivírus:** Cada Antivírus é de um jeito, mas normalmente procure por algo assim:
   - Menu → Configurações → Exceções/Exclusões → Adicionar Exceção → Arquivo/Pasta
   - Navegue até a pasta **MINER** criada em Documentos, selecione (ou marque a caixa) e clique em Ok.
   - Após baixar o **MinerIsma_v2.x.x.exe** na pasta **MINER**, faça Exceção igual para ele.
   - **Nota sobre o Painel da Pool (`web.public-pool.io`):** Alguns antivírus com "Módulo Internet / Web Shield" podem exibir um aviso ao abrir a opção **Seu Miner na Pool** simplesmente porque o domínio da pool é classificado na categoria "Mineração de Criptomoedas". A página exibe apenas estatísticas públicas de leitura da carteira — é totalmente seguro prosseguir/permitir no navegador (ou consultar pelo celular).

---

## 📝 Caso não possua uma carteira Bitcoin, siga esses passos:

Baixe a **Blue Wallet**, é boa, gratuita e fácil: (https://bluewallet.io)

1. Crie uma Nova Carteira Simples e Poderosa, clicando em mais (+);
2. Guarde BEM as 12 palavras, Papel e Caneta! Nada de Foto ou Notas, isso é sério;
   - Tudo em letra minúscula, não erre, confira 2x, não pronuncie as palavras, agora confira novamente;
   - Atenção: De novo, guarde BEM as 12 palavras, Papel e Caneta! Nada de Foto ou Notas;
   - Apenas essas 12 palavras garantem o acesso ao seu dinheiro; se perder, não há com quem reclamar!
3. Em 'Receber' na **Blue Wallet**, Copie o seu novo Endereço Bitcoin;
   - Volte ao **MinerIsma**, lá no passo 5.

---

## ⛏️ Como usar:

Acesse todas as Funções do **MinerIsma** com o botão Direito do Mouse no Ícone no Tray (ao lado do relógio).

- Escolha o idioma (clicando direto sobre **[BR]/[EN]/[ES]** ou na setinha ao lado), alterne entre **Modo Claro/Escuro** e veja a **Cotação do Bitcoin** no Topo do Menu do ícone no tray;
- Mantenha "Iniciar com Windows" habilitado, mineração de Bitcoin é um **ato de fé constante**.
  - Escolha o **delay** para sua internet e Windows carregarem antes do Miner, o "Padrão" é 5 segundos;
- Escolha "Mostrar / Ocultar Miner" para ver o Console do Minerador, é onde tudo acontece de fato.
- Em "Pausar/Retomar Mineração" escolha o tempo necessário para tarefas de alta demanda do Pc, depois retome a mineração.
  - Escolha "Pulsar" para Pausas Térmicas de 5min. após 2 ou 4 horas de mineração. Isso também restaura e otimiza a RAM.
- Escolha o perfil de potência desejado no menu **Power**, são perfis seguros para manter seu Pc em atividade fluida mesmo durante a mineração.
  - Observe a Temperatura do Pc ou barulho da ventoinha por um período de tempo e também durante o verão, para encontrar a potência de equilíbrio para a sua máquina, conforto e seu perfil de usuário.
  - Em Notebook use somente conectado à energia. Escolha menos threads e Modo Pulsar, pois o arrefecimento nesses aparelhos sempre é deficitário. Não use o Modo Avançado em Notebook.
- Explore funções interessantes no **Painel do Minerador** ("Sua Carteira Bitcoin", "Estatísticas: Sua Sorte", "Seu Miner na Pool", "Suas Threads no Pc" e "Modo Avançado") e em **"Testar Alerta de Bloco"** (incluindo a opção **Mutar**).
- Acesse **Tutorial e Feedback** para abrir o Tutorial completo, visitar o MinerIsma na web, enviar sua opinião em **"Sugestão e Experiência"** ou apoiar o projeto.
- Aprenda sobre Bitcoin, Criptomoeda, Blockchain, Liberdade Financeira, Custódia e Privacidade com dezenas de links úteis.
  - Não recomendo aqui produtos ou investimentos, é apenas aprendizado.
- Use o botão "Compartilhar MinerIsma" para copiar o link e indicar o **MinerIsma** para seus amigos, quem sabe um deles fica rico e paga uma pizza para mim e para você!! 🍕 *Quanto mais pessoas minerando, mais fortes ficamos* 💪

---

## 🔄️ Atualização Fácil ⟳:

- Seu MinerIsma notificará quando houver atualização com um ícone de seta circular "⟳" aceso no topo do Menu;
1. Clique no ícone ⟳ ou em **Painel do Minerador** ➔ **Atualizacoes MinerIsma**. Uma página para Download se abrirá;
2. Baixe o novo arquivo **`MinerIsma_v2.x.x.exe`** para a mesma pasta MINER criada anteriormente em Documentos;
3. Execute o **`MinerIsma_v2.x.x.exe`**, o MinerIsma antigo será substituído automaticamente pelo novo;
   - Se o Windows "proteger", clique em → "Mais informações" e "Executar assim mesmo";
   - Suas configurações estarão a salvo e restabelecidas, e o Miner reiniciará automaticamente.

---

## 🗂️ Arquivos que compõem o MinerIsma, em sua Pasta Raiz "BTC_MinerIsma", TODOS em sua Estrutura:

- **Pasta MINER ou Documentos** (Pasta Sugerida/Download no Pc do Usuário)
  - `MinerIsma_v2.X.X.exe` (Arquivo .exe SFX → Gera a pasta "BTC_MinerIsma" portátil no Pc do usuário)
    - **Pasta BTC_MinerIsma** (Pasta gerada a partir do executável MinerIsma_v2.X.X.exe)
      - `START_MinerIsma.exe` (Lançador, antigo .bat, inicia com Windows e serve para início manual pelo usuário)
      - `README.md` (Sobre/Registro/Licença/Resumo/Funções/Disclaimer/Estrutura)
      - **Pasta "bin"** (Conteúdo do cpuminer-opt)
        - 8 arquivos `cpuminer...exe`
        - 5 arquivos `.dll`
        - 4 arquivos de Documentação do `cpuminer-opt`
        - `MinerManager.ps1` → Arquivo gerenciador MinerIsma
      - **Pasta "resources"**
        - `iconeMinerIsmaFull4b.ico`
        - `Leia-ME.txt` (Contém uma cópia do README em Português)
        - `LICENSE` (Licença padrão GPLv3 restringindo o uso comercial do MinerIsma de código aberto)
        - `MinerIsma AUDITS.txt` (Verificações contínuas de saúde dos arquivos anexados para SFX)
        - `MinerIsma AUDITS.md` (Verificações contínuas de saúde dos arquivos anexados para SFX)
        - `MinerIsma_Langs.json` (Pacote externo de idiomas adicionais FR, DE, AR e futuras expansões)
        - `PRIVACY.md` (Arquivo de Compromisso com a Não Coleta de Dados do Usuário)
        - `QRcode-LNURL-BTC_On-EVM-1800x580_450dpi.png` (Arquivo de imagem para a Janela "Apoie o Projeto, Doe")
        - `README.txt` (Cópia em .txt do README em resources para fácil acesso do usuário)
        - `RELEASE_NOTES.md` (PROOF OF EXISTENCE - Blockchain - Registro Contínuo - Atualizações)
        - `Tutorial.html`
        - 4 arquivos `.mp3` (para "alerta_de_bloco")
        - 3 arquivos `.mp3` (para "botões animados")

> *Não remova ou altere qualquer pasta ou arquivo, todo conteúdo é fundamental para a eficiência do sistema.*

### Arquivos Gerados na Utilização do MinerIsma
- **Pasta BTC_MinerIsma** (Pasta gerada a partir do executável MinerIsma_v2.X.X.exe)
  - `BLOCK_FOUND_LOG.txt` (Registro de Encontro de Bloco → Eureka!)
  - `MinerIsma_Stats_2026xxxx_024xxx.png` (Capturas de Telas de Opção Exclusiva do Usuário)
  - **Pasta "resources"**
    - `MinerIsma_Config.json` (Arquivo de gravação e leitura automática de configurações salvas)
    - `MinerIsma_TTF_LOG.txt` (Arquivo de gravação e leitura de estatísticas)
    - `MinerManager_ERROS.log` (Arquivo de Registro de possíveis Erros identificados)
- `→ C:\Users\Seu Usuario\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`
  - `MinerIsma.lnk` (Arquivo Atalho de inicialização automática → Opção do usuário pelo ícone do tray)
- `→ C:\Users\Seu Usuario\Desktop`
  - `MinerIsma.lnk` (Arquivo Atalho de "START_MinerIsma.exe" → Criado por opção do usuário pelo ícone no tray)
- `→ C:\Users\Seu Usuario\AppData\Local\MinerIsma`
  - **Pasta MinerIsma** (Pasta de Backup do MinerIsma no Sistema)
    - `MinerIsma_Config.json` (Arquivo de Backup das configurações salvas)
    - `MinerIsma_TTF_LOG.txt` (Arquivo de Backup das estatísticas)

---

## 🤝 Suporte e Comunidade

- **Formulário de Sugestão e Experiência:** [Google Forms - Feedback MinerIsma](https://docs.google.com/forms/d/e/1FAIpQLSe43fnq_EONpBqmIk37Shyf3j1WiWqDaPfECperMae3x2Purg/viewform?usp=publish-editor)
- **E-mail de Suporte:** [emcis77\@proton.me](mailto:emcis77@proton.me)
- **Desenvolvimento e Código:** [GitHub MCIsma/MinerIsma](https://github.com/MCIsma/MinerIsma)

---

## 🧡 Apoie o Projeto

O MinerIsma é 100% gratuito e de código aberto. Se o projeto te ajudou, gerou aprendizado, ou se você deseja contribuir com o desenvolvimento contínuo, envie qualquer quantia para o endereço oficial:

- **Bitcoin On-Chain:** `bc1qy2wuwjz0c5hcw4r835erf9w7kjz9kmzprvgd7m`
- **Lightning Network:** `lnurl1dp68gurn8ghj7mnpd4jhxtnrda5kummn9e5k7tmvde6hymrs9a5hxmtp2alrwl` *(ou via chave isma\@coinos.io)*
- **Redes EVM (Polygon / Base / Arbitrum / BNB):** `0xF72C0Ee272eEf5c52018dA877ED2EF61c9434015`
- **Apoie o Motor cpuminer-opt BTC:** `12tdvfF7KmAsihBXQXynT6E6th2c2pByTT`

---
*Licenciado sob a GNU General Public License v3.0 (GPLv3).*
