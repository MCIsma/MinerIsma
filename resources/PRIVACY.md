# Privacy Policy — MinerIsma

The **MinerIsma** project is an open-source, free, and fully portable software. This Privacy Policy outlines how the software handles information, network connections, and local data storage across all versions.

---

### 🇧🇷 [Acesse a Tradução para Português do Brasil clicando aqui](#politica-de-privacidade-pt-br)

---

## 1. Zero Data Collection & Telemetry Commitment

* **No Tracking:** MinerIsma **does not collect, store, transmit, or share any personal data**, hardware identifiers, IP addresses, or usage telemetry with developers or third-party servers.
* **No Accounts or Registration:** The software requires no login, email, user account, or personal identification to run.

---

## 2. Portability & Local Storage

* All user preferences (theme settings, language, hardware profiles, custom pools, local RPC credentials, and wallet addresses) are saved **exclusively on the local machine**.
* Any generated log files (runtime logs, Time to Find estimations, or block discovery records) remain solely on the user's computer—within the application's `resources` directory and a local safety backup folder (`%LOCALAPPDATA%\MinerIsma`) used strictly to preserve settings across version updates—and can be inspected or deleted at any time by the user.
* The software does not create persistent hidden registry keys or system changes beyond explicit user-chosen preferences (such as the optional Windows startup shortcut, desktop shortcut, or local Task Manager graph view preference).

---

## 3. Network Connections & External Services

MinerIsma makes only essential, outbound network requests strictly required for its core functionality:

1. **Solo Mining Connections (Stratum / Local RPC):**
   * **Solo Pool:** Connects directly to the user-specified pool server (e.g., public stratum servers) to receive mining work and submit candidate solutions.
   * **Local Node (Noble Mode):** Communicates exclusively with the user's local Bitcoin Core node via authenticated local RPC calls (`127.0.0.1` or configured local IP).
2. **Public Market, Network & Version Data:**
   * Makes anonymous public API requests to third-party endpoints (such as CoinGecko and AwesomeAPI) to display current Bitcoin prices and fiat exchange rates (USD/BRL/EUR).
   * Queries public mempool/blockchain data (`mempool.space`) for block height, halving progress estimates, and latest solo-mined block records.
   * Performs a read-only public text check (`rentry.co/MinerIsma-V`) solely to notify the user if a newer software version is available.
   * Performs basic TCP latency or ICMP ping checks on demand solely to measure connection quality to the selected mining pool or node.
   * External educational links, pool dashboards, and the optional Google Forms feedback page are opened in the system's default browser **only when explicitly clicked by the user**.

None of these requests transmit private information, personal data, or hardware identifiers.

---

## 4. Wallet & Private Key Security

* Any payout address configured in the application is a **public Bitcoin address**.
* MinerIsma **never requests, reads, stores, or accesses private keys, seed phrases, or sensitive wallet credentials**.

---

## 5. Transparency & Open Source

As an open-source PowerShell-based application, MinerIsma's complete source code is transparent, auditable, and verifiable by anyone prior to execution.

---

## 6. License & Disclaimer

The software is provided "as is", free of charge, under its open-source license (GNU GPLv3), without warranties of any kind, express or implied.

<br>

---

<a id="politica-de-privacidade-pt-br"></a>
# Política de Privacidade — MinerIsma (Português - BR)

*(⬆️ [Back to English / Voltar ao Topo](#privacy-policy--minerisma))*

O projeto **MinerIsma** é um software de código aberto, gratuito e totalmente portátil. Esta Política de Privacidade descreve como o software lida com informações, conexões de rede e armazenamento local de dados de forma perene para todas as versões.

---

## 1. Compromisso com a Não Coleta de Dados (Sem Telemetria)

* **Zero Rastreamento:** O MinerIsma **não coleta, armazena, transmite nem compartilha quaisquer dados pessoais**, identificadores de hardware, endereços IP ou telemetria de uso com os desenvolvedores ou servidores de terceiros.
* **Sem Contas ou Cadastros:** O aplicativo não requer login, e-mail, criação de conta ou qualquer identificação pessoal para ser executado.

---

## 2. Portabilidade e Armazenamento Local

* Todas as preferências do usuário (configurações de tema, idioma, perfis de hardware, pools personalizadas, credenciais RPC locais e endereços de carteira) são salvas **exclusivamente na máquina local**.
* Quaisquer arquivos de registro gerados (logs de execução, estimativas de *Time to Find* ou notificações de blocos encontrados) permanecem exclusivamente no computador do usuário — dentro do diretório `resources` do aplicativo e em uma pasta local de backup (`%LOCALAPPDATA%\MinerIsma`) utilizada estritamente para preservar suas configurações durante atualizações de versão — podendo ser inspecionados ou excluídos a qualquer momento pelo usuário.
* O software não cria entradas ocultas no registro do Windows nem alterações de sistema além daquelas explicitamente acionadas pelo usuário (como o atalho opcional de inicialização com o sistema, atalho na Área de Trabalho ou preferência de visualização dos gráficos do Gerenciador de Tarefas).

---

## 3. Conexões de Rede e Serviços Externos

O MinerIsma realiza apenas as comunicações de rede estritamente necessárias para suas funções principais:

1. **Conexões de Mineração Solo (Stratum / RPC Local):**
   * **Pool Solo:** Conecta-se diretamente ao servidor de pool especificado pelo usuário (por exemplo, servidores stratum públicos) para receber trabalho e submeter soluções candidatas.
   * **Nó Próprio (Modo Nobre):** Comunica-se exclusivamente com o nó local do Bitcoin Core via chamadas RPC locais autenticadas (`127.0.0.1` ou IP local configurado).
2. **Consultas Públicas de Cotação, Rede e Versão:**
   * Realiza requisições anônimas a APIs públicas de terceiros (como CoinGecko e AwesomeAPI) para exibir a cotação atual do Bitcoin e taxas de câmbio fiduciárias (USD/BRL/EUR).
   * Consulta dados públicos de mempool/blockchain (`mempool.space`) para estimativas de altura de bloco, progresso do halving e registro do último bloco solo minerado na rede.
   * Realiza uma leitura pública simples (`rentry.co/MinerIsma-V`) exclusivamente para sinalizar ao usuário quando há uma nova atualização disponível.
   * Executa verificações básicas de latência TCP ou ping ICMP sob demanda exclusivamente para medir a qualidade da conexão com a pool ou nó escolhido.
   * Links educativos externos, painéis de pool e o formulário opcional de Sugestão e Experiência (Google Forms) são abertos no navegador padrão **apenas quando clicados voluntariamente pelo usuário**.

Nenhuma dessas requisições envia dados privados, informações pessoais ou identificadores de hardware.

---

## 4. Segurança de Chaves e Carteiras

* Qualquer endereço de pagamento configurado no aplicativo é um **endereço público de Bitcoin**.
* O MinerIsma **nunca solicita, lê, armazena ou manipula chaves privadas, sementes de recuperação (seed phrases) ou credenciais de carteiras**.

---

## 5. Transparência e Código Aberto

Por ser desenvolvido com código-fonte aberto baseado em PowerShell, o código completo do MinerIsma é transparente, auditável e verificável por qualquer pessoa antes da execução.

---

## 6. Licença e Isenção de Responsabilidade

O software é fornecido "no estado em que se encontra" (*as is*), de forma livre e gratuita, sob sua respectiva licença de código aberto (GNU GPLv3), sem garantias de qualquer tipo, expressas ou implícitas.