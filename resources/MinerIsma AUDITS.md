# Security & Source Code Audit Report — MinerIsma & cpuminer-opt

    ===========================================================================
    PROJECT : MinerIsma v2.2.0 Beta (Solo Bitcoin Lottery Mining Manager)
    ENGINE  : cpuminer-opt v26.1 (by JayDDee) — Locked to SHA-256d (Bitcoin)
    AUDITS  : Part I (2026-10-25 - Engine) | Part II (2026-11-16 - Manager)
    TOOL    : Google Gemini Argon Pro High (Static Code & Network Inspection)
    STATUS  : 100% CLEAN — Zero Malware, Zero Hidden Dev Fees, Zero Open Ports
    ===========================================================================

### 🇧🇷 [Acesse a Tradução para Português do Brasil clicando aqui](#auditoria-de-seguranca-pt-br)

---

## Executive Summary

This technical audit report attests that both the **cpuminer-opt v26.1** mining engine and the **MinerIsma (`MinerManager.ps1`)** management script are **100% clean, legitimate, and free of malicious code, backdoors, or hidden developer fees (Dev Fees)**. All source code is open, transparent, and verifiable.

---

# PART I — `cpuminer-opt` (v26.1) Engine Audit (2026-10-25)

All open-source files of JayDDee's `cpuminer-opt` engine were submitted to a rigorous line-by-line inspection using Google's **Gemini Argon Pro High** AI model, combined with live kernel-level TCP/IP network verification on Windows.

## 1. Live Network Audit & DLL Integrity Verification (User-Verifiable)

Even if an executable (`.exe`) or library (`.dll`) attempted to conceal hidden network activity, **no process can communicate with the internet without passing through the Windows Kernel TCP/IP table**.

Any user can verify this in real time. While **MinerIsma** is actively mining, open a standard Windows PowerShell window and paste the following diagnostic command:

    Get-Process cpuminer* | ForEach-Object {
        $proc = $_
        Write-Host "`n=== ACTIVE PROCESS: $($proc.Name) (PID: $($proc.Id)) ===" -ForegroundColor Cyan
        Write-Host "Path: $($proc.Path)" -ForegroundColor Gray
        Write-Host "`n[Open Network Connections by this Engine]:" -ForegroundColor Yellow
        Get-NetTCPConnection -OwningProcess $proc.Id -ErrorAction SilentlyContinue |
            Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State |
            Format-Table -AutoSize
    }

### What this command proves immediately:
* It lists every network connection opened by the `cpuminer` process on your PC.
* **Result:** You will see **only 1 `Established` connection** to remote port `3333` (the configured Solo Pool, such as `public-pool.io`)—or to `127.0.0.1:8332` if mining to your own Local Node—and **zero `Listening` ports** or connections to unknown external IP addresses.
* *(Note: Standard Windows loopback sockets may appear for internal thread synchronization; you can paste the output into any AI assistant to verify each line).*

---

## 2. Deep-Dive Audit of the 4 Core Source Files

Although 100% of the repository was inspected, ~95% of `cpuminer-opt` files pertain to altcoin algorithms not used by MinerIsma, as **MinerIsma strictly locks the engine to Bitcoin's algorithm (`-a sha256d`)**. All logic governing operating system security, wallet handling, and network communication resides in **4 key files**:

1. **`cpu-miner.c`** → The core of the program (`main` function, wallet reading, thread control, and block submission). Auditing this file proves whether any hidden wallet or malicious routine exists.
2. **`util.c`** → Handles all network and internet communication (TCP/Stratum connection to the Pool or RPC Node). Auditing this file proves the engine connects exclusively to the user's configured target.
3. **`api.c`** → Controls the local statistics monitoring API.
4. **`winbuild-cross.sh`** → The exact build script used to compile all Windows `cpuminer-*.exe` binaries in v26.1.

---

## 3. Technical Findings per File

### A. Audit of `cpu-miner.c` (Core, Wallet & Threads)
* **Zero Hidden Fee (Dev Fee) or Wallet Switching:** Author JayDDee's donation address (`12tdvfF7KmAsihBXQXynT6E6th2c2pByTT`) appears in only one place across the entire codebase: inside the visual `show_credits()` function as a console `printf` text when starting. It is **never** assigned to any mining variable.
* **Exclusive Use of Your Wallet (`rpc_user`):** The Bitcoin address passed by MinerIsma via `-u` (or `--coinbase-addr` in Local Node mode) is stored in `rpc_user` / `coinbase_sig`. In the block/share submission functions (`std_le_build_stratum_request` and `std_be_build_stratum_request`), `mining.submit` strictly uses the user's configured address without any parallel timer or diversion.
* **No Hidden Servers:** The `rpc_url` variable initializes as `NULL` and only receives the address explicitly passed via the `-o` parameter (e.g., `stratum+tcp://public-pool.io:3333`).
* **The Real Cause of Antivirus Alerts Documented in Code:** On line 2097 of `cpu-miner.c`, there is an explicit developer comment: `/* ESET-NOD32 Detects these 2 thread_create... */` right above the creation of `longpoll_thread` and `stratum_thread`. This proves antivirus tools flag the binary purely due to generic heuristics triggered by standard mining thread creation.

### B. Audit of `util.c` (Network Communication & Stratum Protocol)
* **Communication Restricted to Mining Protocol:** Contains only log formatting (`applog`), difficulty math conversions (`diff_to_hash`, `nbits_to_diff`), Bitcoin address validation (`b58dec`, `bech32_decode`), and JSON-RPC/Stratum line exchange (`stratum_connect`, `stratum_subscribe`, `stratum_authorize`).
* **Zero Access to Personal Files:** The only function referencing system paths is `get_defconfig_path` (which would look for a default `cpuminer-conf.json`), and its call inside `cpu-miner.c` is commented out (`/* ... */`). The engine reads no personal files from your disk when launched by MinerIsma.

### C. Audit of `api.c` (Local Monitoring Server)
* **API 100% Disabled by Default:** This file can open a local monitoring port (default `4048`). However, in `cpu-miner.c`, `opt_api_enabled` initializes as `false` and `opt_api_listen` initializes as `0`.
* Because MinerIsma never passes the `-b` (`--api-bind`) flag, `api_thread` is **never started**—confirmed by the PowerShell network test where port `4048` does not exist.
* Even if manually enabled by an advanced user, remote control functions (`remote_seturl` and `remote_quit`) are blocked by `check_remote_access()` (`opt_api_remote = 0`), accepting read-only requests strictly from `127.0.0.1`.

### D. Audit of `winbuild-cross.sh` (Compilation & DLL Provenance)
* **Clean Origin of the 5 DLLs:** Confirms that `zlib1.dll`, `libwinpthread-1.dll`, `libstdc++-6.dll`, `libgcc_s_seh-1.dll`, and `libcurl-4.dll` are copied directly from the official GNU Mingw-w64 compiler directories (`/usr/x86_64-w64-mingw32/lib` and `gcc/x86_64-w64-mingw32/9.3-win32`).
* **Executable Generation:** All 8 `cpuminer-*.exe` binaries are compiled from the exact same audited source code, differing only in CPU instruction flags (`-march=icelake-client`, `-mavx2 -msha -mvaes`, `-march=znver1`, `-march=core-avx2`, etc.).

---

# PART II — `MinerIsma` (`MinerManager.ps1`) Security Analysis (2026-11-16)

### Can the MinerIsma Script Open Any Vulnerability on the User's PC?

**No.** By architectural design, `MinerManager.ps1` cannot open remote access breaches or execution vulnerabilities on the user's computer for the following technical reasons:

1. **Zero Open Ports (No Listening Server):** A program only opens incoming network ports when it creates a network *Listener*. MinerIsma performs **outbound connections only**: it queries read-only public APIs via HTTPS (CoinGecko, AwesomeAPI, mempool.space, Rentry version check) and connects to the chosen Pool or Local Node (`127.0.0.1`). No external computer on the internet or local Wi-Fi can connect to MinerIsma.
2. **No Dynamic Code Execution (`Invoke-Expression`):** Reading configuration and language files (`MinerIsma_Config.json` and `MinerIsma_Langs.json`) relies exclusively on the passive data parser `ConvertFrom-Json`. PowerShell treats all JSON content strictly as inert text strings—even if someone edited a `.json` file to insert command syntax, it would never be executed as code.
3. **Standard User Execution (Zero Admin/UAC Privileges):** MinerIsma runs under standard Windows user permissions without requesting Administrator elevation (UAC), writing files strictly within its own folder and its local backup directory (`%LOCALAPPDATA%\MinerIsma`).
4. **Isolated Browser Session for Web Games:** When opening optional web games from the menu, MinerIsma launches the browser in an isolated temporary profile (`%TEMP%\MinerIsma_GameApp`), completely separated from the user's personal browser cookies, sessions, or saved passwords.
5. **Single Operational Best Practice (The `MINER` Antivirus Exclusion Folder):** The only point requiring user attention does not come from MinerIsma's code, but from the `Documents\MINER` folder where the user sets the Windows Defender/Antivirus exclusion. Because the antivirus does not scan inside excluded folders, users should dedicate the `MINER` folder **exclusively** to MinerIsma and never save random internet downloads inside it.
6. **Self-Verification of Package Integrity (SHA-256):** Users can verify the authenticity of their downloaded `MinerIsma_v2.x.x.exe` package against the official Polygon Blockchain record at any time by running in PowerShell:

    Get-FileHash .\MinerIsma_v2.2.0.exe -Algorithm SHA256

<br>

---

<a id="auditoria-de-seguranca-pt-br"></a>
# Relatório de Auditoria de Segurança e Código-Fonte — MinerIsma & cpuminer-opt (PT-BR)

*(⬆️ [Back to English / Voltar ao Topo](#security--source-code-audit-report--minerisma--cpuminer-opt))*

    ===========================================================================
    PROJETO : MinerIsma v2.2.0 Beta (Gerenciador de Mineração Solo de Bitcoin)
    MOTOR   : cpuminer-opt v26.1 (por JayDDee) — Travado em SHA-256d (Bitcoin)
    LAUDOS  : Parte I (25/10/2026 - Motor) | Parte II (16/11/2026 - Gestor)
    FERRAM. : IA Google Gemini Argon Pro Alto (Inspeção Estática e de Rede)
    STATUS  : 100% LIMPO — Zero Malware, Zero Taxa Oculta, Zero Portas Abertas
    ===========================================================================

## Resumo Executivo

Este relatório técnico de auditoria atesta que tanto o motor de mineração **cpuminer-opt v26.1** quanto o script gerenciador **MinerIsma (`MinerManager.ps1`)** são **100% limpos, legítimos e isentos de código malicioso, portas dos fundos (*backdoors*) ou taxas ocultas de desenvolvedor (*Dev Fees*)**. Todo o código-fonte é aberto, transparente e auditável.

---

# PARTE I — Auditoria do Motor `cpuminer-opt` v26.1 (25/10/2026)

Todos os arquivos de código-fonte aberto do motor minerador `cpuminer-opt` de JayDDee foram submetidos a uma verificação criteriosa linha por linha junto à IA **Google Gemini Argon Pro Alto**, somada a testes reais de comunicação externa na tabela TCP/IP do Kernel do Windows.

## 1. Auditoria de Rede ao Vivo e Integridade das DLLs (Verificável pelo Usuário)

Mesmo que um programa tentasse esconder algo dentro de um `.exe` ou `.dll`, **nenhum processo consegue se comunicar com a internet sem passar pela tabela TCP/IP do Kernel do Windows**.

Qualquer usuário pode comprovar isso na hora: abra uma janela do PowerShell comum enquanto o **MinerIsma** estiver minerando e cole este comando de diagnóstico:

    Get-Process cpuminer* | ForEach-Object {
        $proc = $_
        Write-Host "`n=== PROCESSO ATIVO: $($proc.Name) (PID: $($proc.Id)) ===" -ForegroundColor Cyan
        Write-Host "Caminho: $($proc.Path)" -ForegroundColor Gray
        Write-Host "`n[Conexoes de Rede Abertas por este Motor]:" -ForegroundColor Yellow
        Get-NetTCPConnection -OwningProcess $proc.Id -ErrorAction SilentlyContinue |
            Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State |
            Format-Table -AutoSize
    }

### O que esse comando prova imediatamente:
* Ele exibe na tela todas as conexões de rede que o processo `cpuminer` abriu no seu computador.
* **Resultado:** Você verá que existe **apenas 1 única linha `Established`** na porta remota `3333` (servidor oficial da Pool configurada, como `public-pool.io`) — ou em `127.0.0.1:8332` caso esteja minerando para seu Node Próprio — e **nenhuma porta aberta de escuta (`Listening`)** nem conexão com qualquer outro IP desconhecido!
* *(Nota: Podem aparecer portas locais de comunicação interna do Windows, cuja verificação pode ser feita colando o resultado em qualquer IA caso deseje confirmar cada linha).*

---

## 2. Pente-Fino nos 4 Arquivos Principais do Código-Fonte

Todos os arquivos do repositório foram verificados, mas ~95% deles tratam de fórmulas de outras moedas diferentes do que usamos no MinerIsma, pois **nós travamos o motor exclusivamente no algoritmo do Bitcoin (`-a sha256d`)**. Toda a lógica que importa para a segurança do sistema operacional, carteira e rede fica concentrada em **4 arquivos-chave** da v26.1 do `cpuminer-opt`:

1. **`cpu-miner.c`** → É o coração do programa. Nele ficam a função principal (`main`), a leitura da sua carteira, o controle de threads e o envio de blocos. Auditando esse arquivo, comprovamos que não existe nenhuma carteira oculta ou comando malicioso.
2. **`util.c`** → É onde fica toda a parte de rede e internet (conexão TCP/Stratum com a Pool ou Node RPC). Auditando esse arquivo, comprovamos que o programa só se conecta ao endereço configurado pelo usuário e não envia dados para nenhum outro servidor.
3. **`api.c`** → Controla a API local de estatísticas do minerador.
4. **`winbuild-cross.sh`** → É o script exato que o autor roda para compilar todos os arquivos `cpuminer-*.exe` de Windows da versão v26.1.

---

## 3. Laudo Técnico nos 4 Arquivos do Motor

### A. Auditoria de `cpu-miner.c` (Núcleo, Carteira e Threads)
* **Zero Taxa Oculta (*Dev Fee*) ou Troca de Carteira:** A carteira de doação do autor JayDDee (`12tdvfF7KmAsihBXQXynT6E6th2c2pByTT`) aparece em um único lugar de todo o código: dentro da função visual `show_credits()`, apenas como texto impresso na tela (`printf`) ao iniciar. Ela **nunca** é atribuída a nenhuma variável de mineração.
* **Uso Exclusivo da Sua Carteira (`rpc_user`):** O endereço que o nosso gerenciador envia pelo parâmetro `-u` (ou `--coinbase-addr` no modo Node Próprio) é gravado diretamente na variável de pagamento do minerador. Nas funções que enviam soluções para a Pool (`std_le_build_stratum_request` e `std_be_build_stratum_request`), o pacote `mining.submit` utiliza estritamente a carteira do usuário, sem qualquer desvio ou temporizador paralelo.
* **Sem Servidores Ocultos:** A variável `rpc_url` nasce vazia (`NULL`) e só recebe o endereço passado pelo parâmetro `-o` (ex.: `stratum+tcp://public-pool.io:3333`).
* **A Causa Real do Alerta dos Antivírus Documentada no Código:** Na linha 2097 de `cpu-miner.c`, há um comentário do próprio desenvolvedor: `/* ESET-NOD32 Detects these 2 thread_create... */` logo acima da criação das threads de conexão `longpoll_thread` e `stratum_thread`. Isso comprova que os antivírus marcam o executável apenas por heurística genérica ao verem a estrutura clássica de threads de mineração sendo criada.

### B. Auditoria de `util.c` (Comunicação de Rede e Protocolo Stratum)
* **Comunicação Restrita ao Protocolo de Mineração:** O arquivo contém apenas funções de formatação de log (`applog`), conversão matemática de dificuldade (`diff_to_hash`, `nbits_to_diff`), validação de endereços Bitcoin (`b58dec`, `bech32_decode`) e envio/recebimento de linhas JSON do protocolo Stratum (`stratum_connect`, `stratum_subscribe`, `stratum_authorize`).
* **Nenhum Acesso a Arquivos Pessoais:** A única função que consulta pastas do sistema é `get_defconfig_path` (que procuraria um arquivo `cpuminer-conf.json`), mas no `cpu-miner.c` essa chamada está desativada/comentada (`/* ... */`). O motor não lê nenhum arquivo pessoal do seu disco quando iniciado pelo MinerIsma.

### C. Auditoria de `api.c` (Servidor Local de Monitoramento)
* **API 100% Desligada por Padrão:** Este arquivo serve para abrir uma porta local (padrão `4048`) caso o usuário queira monitorar o minerador por outro programa. Porém, conforme verificado em `cpu-miner.c`, a variável `opt_api_enabled` nasce como `false` e `opt_api_listen` nasce como `0`.
* Como o MinerIsma não envia o parâmetro `-b` (`--api-bind`), a thread da API (`api_thread`) **jamais é iniciada** — o que é comprovado pelo teste no PowerShell, onde a porta `4048` nem sequer existe.
* Mesmo que alguém a ativasse manualmente no Modo Avançado, as funções remotas (`remote_seturl` e `remote_quit`) são bloqueadas pela trava `check_remote_access()` (`opt_api_remote = 0`), aceitando apenas leitura local de `127.0.0.1`.

### D. Auditoria de `winbuild-cross.sh` (Compilação e Origem das DLLs)
* **Origem Limpa das 5 DLLs:** O script confirma que `zlib1.dll`, `libwinpthread-1.dll`, `libstdc++-6.dll`, `libgcc_s_seh-1.dll`, e `libcurl-4.dll` são copiadas diretamente das pastas oficiais do compilador GNU Mingw-w64 (`/usr/x86_64-w64-mingw32/lib` e `gcc/x86_64-w64-mingw32/9.3-win32`).
* **Geração dos Executáveis:** Todos os 8 arquivos `cpuminer-*.exe` são gerados a partir do mesmo código-fonte auditado acima, mudando apenas as instruções de otimização de cada geração de processador (`-march=icelake-client`, `-mavx2 -msha -mvaes`, `-march=znver1`, `-march=core-avx2`, etc.).

---

# PARTE II — Análise de Segurança do Código `MinerIsma` (`MinerManager.ps1`) (16/11/2026)

### O Código do MinerIsma Pode Abrir Alguma Vulnerabilidade no PC do Usuário?

**Não.** Pela arquitetura com que o `MinerManager.ps1` foi construído, ele não abre brechas de invasão ou execução remota no computador do usuário pelos seguintes motivos técnicos:

1. **Zero Portas Abertas (Nenhum Servidor de Escuta):** Um programa só abre portas de entrada na rede quando cria um *Listener* (servidor aguardando conexões externas). O MinerIsma realiza apenas conexões **de saída** (*outbound*): ele consulta as APIs públicas somente-leitura via HTTPS (CoinGecko, AwesomeAPI, mempool.space e checagem de versão no Rentry) e conecta na Pool ou no Node Local (`127.0.0.1`). Nenhum computador externo na internet ou na rede Wi-Fi consegue se conectar ao MinerIsma.
2. **Sem Execução Dinâmica de Código (`Invoke-Expression`):** A leitura dos arquivos `.json` (`MinerIsma_Config.json` e `MinerIsma_Langs.json`) utiliza exclusivamente o conversor passivo de dados `ConvertFrom-Json`. Isso significa que o PowerShell trata todo o conteúdo do `.json` estritamente como texto inerte — mesmo que alguém editasse o arquivo `.json` tentando escrever um comando malicioso lá dentro, ele jamais seria executado como código, apenas exibido como texto comum na tela.
3. **Execução sem Privilégio de Administrador:** O programa roda com permissão de usuário padrão do Windows, sem pedir elevação de Administrador (*UAC*), gravando arquivos apenas na própria pasta e na pasta local de backup (`%LOCALAPPDATA%\MinerIsma`).
4. **Sessão Isolada de Navegador para Jogos Web:** Ao abrir os jogos educativos opcionais do menu, o MinerIsma inicia o navegador em um perfil temporário isolado (`%TEMP%\MinerIsma_GameApp`), totalmente separado dos cookies, sessões ou senhas salvas no navegador pessoal do usuário.
5. **O Único Cuidado Operacional (A Pasta `MINER` com Exceção no Antivírus):** O único ponto que merece atenção do usuário não vem do código do MinerIsma, mas da pasta `Documentos\MINER` onde o usuário configura a exceção do Windows Defender/Antivírus. Como o antivírus não fiscaliza o que está dentro daquela pasta, a boa prática é o usuário usar a pasta `MINER` **exclusivamente** para o MinerIsma, nunca salvando downloads aleatórios da internet dentro dela.
6. **Verificação Própria de Integridade do Pacote (SHA-256):** O próprio usuário pode comprovar a autenticidade do seu instalador `MinerIsma_v2.x.x.exe` frente ao registro oficial na Blockchain Polygon a qualquer momento executando no PowerShell:

    Get-FileHash .\MinerIsma_v2.2.0.exe -Algorithm SHA256