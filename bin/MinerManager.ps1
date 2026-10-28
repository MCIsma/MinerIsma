# ============================================================================
# MinerManager.ps1 - MinerIsma v2.0.2 - Alpha (Gerenciador Solo com Tray Icon)
# ============================================================================
# REGISTRO DE PROPRIEDADE INTELECTUAL EM BLOCKCHAIN (PROVA DE EXISTENCIA)
# [REGISTRO #06 - BASE CONSOLIDADA V1.9.7 - Alpha]
# Data do Registro : 25/10/2026
# Autor / Carteira : 0xF72C0Ee272eEf5c52018dA877ED2EF61c9434015 (MetaMask / EVM)
# Pacote Base (RAR): BTC_MinerIsma_v1.9.7.rar
# Hash SHA-256     : 903463835AF1E04C1C215CD88052DFB4A423D599B17FBCD9B7A238E985C1DDE7
# Rede Blockchain  : Polygon Mainnet
# Transacao (TxID) : 0x832537a1b1dc4f5632bb12c64f291862b666ec14208ba19faf1b3b1f1413641b
# Link Verificador : https://polygonscan.com/tx/0x832537a1b1dc4f5632bb12c64f291862b666ec14208ba19faf1b3b1f1413641b
# Historico detalhado disponivel em: resources\REGISTRO_PROPRIEDADE_INTELECTUAL.txt
# ============================================================================

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

# ================================================================
#  1. CONFIGURACOES GERAIS E CONEXAO
# ================================================================
$global:Wallet               = "minha_carteira.WORKER"   # <<< TROQUE pela sua Carteira e Trabalhador
$global:PoolUrl              = "stratum+tcp://public-pool.io:3333"

$global:MinerExeName         = "cpuminer-avx2-sha.exe"   
$global:LauncherFileName     = "START_MinerIsma.exe"     # Nome do seu arquivo Lancador na pasta raiz
$global:TutorialFileName     = "Tutorial.html"           # Nome do arquivo HTML na pasta resources
$global:SoundFileKMS         = "alerta_de_bloco-KMS.mp3"
$global:SoundFileSenna       = "alerta_de_bloco-Senna.mp3"
$global:SoundFileMforN       = "alerta_de_bloco-MforN.mp3"
$global:SoundFileCoins       = "alerta_de_bloco-Coins.mp3"
$global:SoundFileName        = $global:SoundFileKMS      # Audio padrao inicial (KMS)
$global:DefaultStartupDelay  = 5         # << Delay padrao (5s) ao iniciar manualmente
$global:StartupDelaySeconds  = $global:DefaultStartupDelay
$global:TtfWarmupSeconds     = 60        # << Segundos iniciais ignorados no log TTF para evitar distorcoes de partida
$global:ExtraArgs            = "--cpu-priority=1"   

# --- Filtro Inteligente de TTF (Dias limite baseados na qtd de Threads em uso) ---
$global:TtfThresholds = @{
    10 = 240    # ~8 meses
    8  = 300    # ~10 meses
    7  = 330    # ~11 meses
    6  = 365    # 1 ano
    5  = 547    # 1,5 anos
    4  = 730    # 2 anos
    3  = 912    # 2,5 anos
    2  = 1095   # 3 anos
    1  = 1277   # 3,5 anos
}

# --- Links da Web: Submenu Bitcoin Links ---
$global:BtcPriceUrl          = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd"
$global:UrlPoolDashboard     = "https://web.public-pool.io/#/app/"
$global:UrlDriveUpdates      = "https://drive.proton.me/urls/WF022MG27W#YknkVYHMQO4w"
$global:UrlMempool           = "https://mempool.space/pt/"
$global:UrlTimeline          = "https://chaintimeline.com/"
$global:UrlMercadoCripto     = "https://mercado.bitnada.com.br/"
$global:UrlBlueWallet        = "https://bluewallet.io/"
$global:UrlAprendaCripto     = "https://bitcoinpuzzles.io/pt/aulas"
$global:UrlBitNoticias       = "https://bitnoticias.com.br/"
$global:UrlCartaoCripto      = "https://usepicnic.com/br"
$global:UrlMissao1Btc        = "https://missao-1-btc.onrender.com/"
$global:UrlAposentadoriaBtc  = "https://aaronlil.github.io/btc-retirement-planner/"
$global:UrlBitcoinMaps       = "https://btcmap.org/"
$global:UrlTutorial          = ""   # <<< Preencha futuramente com o link web de MinerIsma na web
$global:UrlGpuMiner          = "https://www.kryptex.com/?ref=2103d720"
$global:UrlCryptoBubbles     = "https://cryptobubbles.net/pt"

# --- Links da Web: Submenu Bitcoin Games ---
$global:UrlGame21Million     = "https://kwertykwerty2.itch.io/21-million-demo"
$global:UrlGamePuzzle1000    = "https://bitcoinpuzzles.io/pt/puzzles/1000btc"
$global:UrlGameDesafios      = "https://bitcoinpuzzles.io/pt"
$global:UrlGamePuzzle71      = "https://krackpot.io/"
$global:UrlGameToTheMoon     = "https://bitcoincreative.org/biblioteca/to-the-moon-jogo-de-tabuleiro/"
$global:UrlGameSunnyLand     = "https://alzahira.itch.io/en-busca-del-bitcoin-en-sunnyland"

# --- Links da Web: Submenu Canais Cripto (YouTube) ---
$trezoitaoName = "Renato Trezoit" + [char]0x00E3 + "o"
$global:CryptoChannels = [ordered]@{
    "Denny Torres"        = "https://www.youtube.com/@dennytorres"
    "Bitnada"             = "https://www.youtube.com/@BitNada"
    "Prometheus HODL"     = "https://www.youtube.com/@PROmetheusHODL"
    "Area Bitcoin"        = "https://www.youtube.com/@AreaBitcoin"
    "Juliano Caju"        = "https://www.youtube.com/@JulianoCaju"
    "Joao Hazim"          = "https://www.youtube.com/@joaohazim"
    "Vela Trader"         = "https://www.youtube.com/@VelaTrader"
    "DK CriptoTrader"     = "https://www.youtube.com/@dkcriptotrader"
    "Investidor 4.20"     = "https://www.youtube.com/@investidor4.20"
    "Bitcoinheiros"       = "https://www.youtube.com/@Bitcoinheiros"
    "Augusto Backes"      = "https://www.youtube.com/@AugustoBackes"
    "Mestre Cacatal"      = "https://www.youtube.com/@mestrecacatal"
    "Bernardo Pascowitch" = "https://www.youtube.com/@bernardo-pascowitch"
    $trezoitaoName        = "https://www.youtube.com/@rotinadotrezoitao"
}

# ================================================================
#  2. INTELIGENCIA DE PERFIS DINAMICOS (Baseado na CPU)
# ================================================================
try {
    $sysObj = Get-CimInstance Win32_ComputerSystem | Select-Object -First 1
    $global:LogicalCores = $sysObj.NumberOfLogicalProcessors
} catch {
    $global:LogicalCores = 12 # Fallback seguro
}

$arrSym = [string][char]0x2192

if ($global:LogicalCores -ge 24) {
    # Perfil: CPUs 24 Threads ou mais
    $global:PowerHeaderTitle = "Power  |  CPU 24+ Threads"
    $global:ThreadProfiles = [ordered]@{
        10 = "0x555550"
        8  = "0x155540"
        6  = "0x155400"
        5  = "0x155000"
        4  = "0x154000"
        3  = "0x150000"
    }
    $global:ThreadLabels = @{
        10 = "~48% $arrSym" + "10....!.!.!.!.!.!.!.!.!.!."
        8  = "~38% $arrSym 8......!.!.!.!.!.!.!.!..."
        6  = "~28% $arrSym 6..........!.!.!.!.!.!..."
        5  = "~24% $arrSym 5............!.!.!.!.!..."
        4  = "~20% $arrSym 4..............!.!.!.!..."
        3  = "~15% $arrSym 3................!.!.!..."
    }
}
elseif ($global:LogicalCores -ge 16) {
    # Perfil: CPUs 16 a 20 Threads
    $global:PowerHeaderTitle = "Power | CPU 16+ Threads"
    $global:ThreadProfiles = [ordered]@{
        7 = "0x5554"
        6 = "0x5550"
        5 = "0x5540"
        4 = "0x1540"
        3 = "0x1500"
        2 = "0x1400"
    }
    $global:ThreadLabels = @{
        7 = "~50% $arrSym 7 ..!.!.!.!.!.!.!."
        6 = "~42% $arrSym 6 ....!.!.!.!.!.!."
        5 = "~36% $arrSym 5 ......!.!.!.!.!."
        4 = "~28% $arrSym 4 ......!.!.!.!..."
        3 = "~22% $arrSym 3 ........!.!.!..."
        2 = "~15% $arrSym 2 ..........!.!..."
    }
}
elseif ($global:LogicalCores -ge 12) {
    # Perfil: CPUs 12 Threads
    $global:PowerHeaderTitle = "Power | CPU 12 Threads"
    $global:ThreadProfiles = [ordered]@{
        5 = "0x554"
        4 = "0x550"
        3 = "0x150"
        2 = "0x50"
        1 = "0x010"
    }
    $global:ThreadLabels = @{
        5 = "~46% $arrSym 5  ..!.!.!.!.!."
        4 = "~38% $arrSym 4  ....!.!.!.!."
        3 = "~28% $arrSym 3  ....!.!.!..."
        2 = "~20% $arrSym 2  ....!.!....."
        1 = "~10% $arrSym 1  ....!......."
    }
}
else {
    # Perfil: CPUs 10 Threads ou menos
    $global:PowerHeaderTitle = "Power | CPU 10-Threads"
    $global:ThreadProfiles = [ordered]@{
        4 = "0x154"
        3 = "0x54"
        2 = "0x50"
        1 = "0x010"
    }
    $global:ThreadLabels = @{
        4 = "~45% $arrSym  4  ..!.!.!.!."
        3 = "~35% $arrSym  3  ..!.!.!..."
        2 = "~22% $arrSym  2  ....!.!..."
        1 = "~12% $arrSym  1  ....!....."
    }
}

# ================================================================
#  3. TABELA DE IDIOMAS (PT / EN / ES)
# ================================================================
$lblMissaoPT    = "Miss" + [char]0x00E3 + "o 1 Bitcoin"
$lblMissaoES    = "Misi" + [char]0x00F3 + "n 1 Bitcoin"
$lblRetireES    = "Jubilaci" + [char]0x00F3 + "n BTC"
$lblGpuMiner    = "GPU miner " + [char]0x2192 + " $$$"
$lblPrizeHdrPT  = "Pr" + [char]0x00EA + "mio Atual do Bloco"
$lblAvgHdrPT    = "Tempo M" + [char]0x00E9 + "dio Estimado"
$lblAvgSubPT    = "(at" + [char]0x00E9 + " um Bloco / Sorte)"
$lblHalvPT1     = "Pr" + [char]0x00F3 + "ximo Halving em "
$lblHalvES1     = "Pr" + [char]0x00F3 + "ximo Halving en "
$lblAreaPT      = "Link de download copiado para a " + [char]0x00E1 + "rea de transfer" + [char]0x00EA + "ncia!"

$global:Language = "PT"
$global:LangTable = @{
    PT = @{
        BtcUpdating      = "itcoin agora: Atualizando..."
        BtcNowPrefix     = "itcoin agora: US$ "
        BtcLinks         = "itcoin Links"
        MenuChannels     = "Canais Cripto"
        GameDesafios     = "Cripto Desafios $"
        GameBoard        = "TotheMoon Tabuleiro"
        LinkPool         = "Seu Miner na Pool"
        LinkUpdates      = "Atualizacoes MinerIsma"
        LinkMempool      = "Mempool Bitcoin"
        LinkTimeline     = "TimeLine Bitcoin"
        LinkMonitor      = "Monitor Cripto"
        LinkBlueWallet   = "Blue Wallet"
        LinkLearn        = "Aprenda Cripto"
        LinkNews         = "BitNoticias"
        LinkGlobalAcc    = "Conta Global Cripto"
        LinkMissao1Btc   = $lblMissaoPT
        LinkRetireBtc    = "Aposentadoria BTC"
        LinkBtcMaps      = "Bitcoin Maps"
        LinkWeb          = "MinerIsma na web"
        LinkGpuMiner     = $lblGpuMiner
        LinkBubbles      = "Crypto Bubbles"
        MsgWebSoon       = "A pagina do MinerIsma na web sera disponibilizada em breve."
        MenuStartup      = "Iniciar com Windows"
        DelayHeader      = "Delay:"
        DelayDefault     = "Padrao"
        MenuWallet       = "Sua Carteira Bitcoin"
        MenuTestAlert    = "Testar Alerta de Bloco"
        MenuTtfStats     = "Estatisticas TTF: Sua Sorte"
        MenuLanguage     = "Idioma"
        MenuTutorial     = "Tutorial MinerIsma"
        MenuShare        = "Compartilhar MinerIsma"
        ShareCopiedShort = "Link copiado!"
        ShareCopiedMsg   = $lblAreaPT
        TutorialWinTitle = "Tutorial"
        MenuShowHide     = "Mostrar / Ocultar Miner"
        MenuPause        = "Pausar Mineracao"
        MenuResume       = "Retomar Mineracao"
        PauseManual      = "Manual"
        Pause1h          = "1 hora"
        Pause2h          = "2 horas"
        Pulse2h          = "Pulsar 2hx5"
        Pulse4h          = "Pulsar 4hx5"
        MenuExit         = "Fechar Mineracao"
        TrayWaitStart    = "Aguardando inicio..."
        TrayWaitWallet   = "AGUARDANDO CARTEIRA"
        TrayCalculating  = "Calculando..."
        TrayPaused       = "PAUSADO"
        TrayPausedUntil  = "PAUSADO (ate"
        TrayPulsePause   = "PAUSA (ate"
        TrayResuming     = "Retomando..."
        BalloonStart1    = "Gerenciador na bandeja. Mineracao inicia em"
        BalloonStart2    = "segundos."
        BtnSave          = "Salvar"
        BtnSaveImg       = "Salvar Imagem"
        BtnResetTtf      = "Zerar TTF"
        BtnClose         = "Fechar"
        BtnCreateWallet  = "Criar Carteira"
        BtnCelebrate     = "Comemorar!"
        WalletWinTitle   = "Sua Carteira Bitcoin"
        WalletHeader     = "Configure endereco Bitcoin para iniciar Miner:"
        WalletLblAddr    = "Insira seu endereco de carteira Bitcoin (Ex.: bc1...):"
        WalletLblWorker  = "Insira seu Trabalhador (Ex.: Pc_Gamer):"
        WalletWarn1      = "Endereco errado significa perder um possivel premio, confira!"
        WalletWarn2      = "Para o Trabalhador, evite caracteres especiais, espacos e acentuacao"
        WalletEmptyMsg   = "Por favor, insira um endereco de carteira Bitcoin."
        WalletInvalid1   = "O endereco inserido nao parece ser uma carteira Bitcoin valida."
        WalletInvalid2   = "Certifique-se de que ele comeca com '1', '3' ou 'bc1'."
        TtfNoDataMsg     = "Ainda nao ha dados suficientes no log de TTF."
        TtfWaitAvg       = "Aguardando..."
        TtfNoDataBox1    = "Ainda nao ha dados suficientes para estatistica de sorte."
        TtfNoDataBox2    = "Deixe o MinerIsma rodando para registrar suas aproximacoes!"
        TtfResetConfirm  = "Deseja realmente zerar todo o historico de estatisticas TTF?"
        TtfWinTitle      = "Estatisticas TTF (Estimativa do Bloco)"
        TtfPrizeHeader   = $lblPrizeHdrPT
        TtfPrizeBtc      = "3.125 BTC"
        TtfPrizeUsdPref  = "$ ~US$ "
        TtfPrizeUsdWait  = "$ Atualizando cotacao..."
        TtfDrawInfo      = '"Sorteio" a cada ~10 min'
        TtfHalving1      = $lblHalvPT1
        TtfHalving2      = " Blocos"
        TtfAvgHeader     = $lblAvgHdrPT
        TtfAvgSub        = $lblAvgSubPT
        TtfCountLbl      = "Registros Coletados:"
        TtfBestLbl       = "Melhor Aproximacao (Recorde de Sorte):"
        TtfDate          = "Data:"
        TtfLuck          = "Sua Sorte:"
        TtfPower         = "Poder:"
        AlertWinTitle    = "SUCESSO ABSOLUTO"
        AlertHeader      = "VOCE ENCONTROU UM BLOCO!!!"
        AlertBlockHeight = "Bloco (altura):"
        AlertCheckWallet = "Confira a carteira"
        AlertRewardInfo  = "Seu premio em Bitcoin estara disponivel apos 100 Blocos (~24 horas)."
        AlertLogInfo     = "Confira o registro no Log"
        AlertInFolder    = "na pasta do MinerIsma."
    }
    EN = @{
        BtcUpdating      = "itcoin now: Updating..."
        BtcNowPrefix     = "itcoin now: US$ "
        BtcLinks         = "itcoin Links"
        MenuChannels     = "Crypto Channels"
        GameDesafios     = "Crypto Challenges $"
        GameBoard        = "TotheMoon Board Game"
        LinkPool         = "Your Miner on Pool"
        LinkUpdates      = "MinerIsma Updates"
        LinkMempool      = "Bitcoin Mempool"
        LinkTimeline     = "Bitcoin TimeLine"
        LinkMonitor      = "Crypto Monitor"
        LinkBlueWallet   = "Blue Wallet"
        LinkLearn        = "Learn Crypto"
        LinkNews         = "BitNoticias"
        LinkGlobalAcc    = "Crypto Global Account"
        LinkMissao1Btc   = "Mission 1 Bitcoin"
        LinkRetireBtc    = "BTC Retirement"
        LinkBtcMaps      = "Bitcoin Maps"
        LinkWeb          = "MinerIsma on the Web"
        LinkGpuMiner     = $lblGpuMiner
        LinkBubbles      = "Crypto Bubbles"
        MsgWebSoon       = "The MinerIsma web page will be available soon."
        MenuStartup      = "Start with Windows"
        DelayHeader      = "Delay:"
        DelayDefault     = "Default"
        MenuWallet       = "Your Bitcoin Wallet"
        MenuTestAlert    = "Test Block Alert"
        MenuTtfStats     = "TTF Stats: Your Luck"
        MenuLanguage     = "Language"
        MenuTutorial     = "MinerIsma Tutorial"
        MenuShare        = "Share MinerIsma"
        ShareCopiedShort = "Link copied!"
        ShareCopiedMsg   = "Download link copied to clipboard!"
        TutorialWinTitle = "Tutorial"
        MenuShowHide     = "Show / Hide Miner"
        MenuPause        = "Pause Mining"
        MenuResume       = "Resume Mining"
        PauseManual      = "Manual"
        Pause1h          = "1 hour"
        Pause2h          = "2 hours"
        Pulse2h          = "Pulse 2hx5"
        Pulse4h          = "Pulse 4hx5"
        MenuExit         = "Exit Mining"
        TrayWaitStart    = "Waiting to start..."
        TrayWaitWallet   = "WAITING FOR WALLET"
        TrayCalculating  = "Calculating..."
        TrayPaused       = "PAUSED"
        TrayPausedUntil  = "PAUSED (until"
        TrayPulsePause   = "PAUSE (until"
        TrayResuming     = "Resuming..."
        BalloonStart1    = "Manager in system tray. Mining starts in"
        BalloonStart2    = "seconds."
        BtnSave          = "Save"
        BtnSaveImg       = "Save Image"
        BtnResetTtf      = "Reset TTF"
        BtnClose         = "Close"
        BtnCreateWallet  = "Create Wallet"
        BtnCelebrate     = "Celebrate!"
        WalletWinTitle   = "Your Bitcoin Wallet"
        WalletHeader     = "Configure Bitcoin address to start Miner:"
        WalletLblAddr    = "Enter your Bitcoin wallet address (e.g., bc1...):"
        WalletLblWorker  = "Enter your Worker name (e.g., Gaming_PC):"
        WalletWarn1      = "A wrong address means losing a possible reward, double-check!"
        WalletWarn2      = "For the Worker name, avoid special characters, spaces, and accents"
        WalletEmptyMsg   = "Please enter a Bitcoin wallet address."
        WalletInvalid1   = "The entered address does not look like a valid Bitcoin wallet."
        WalletInvalid2   = "Make sure it starts with '1', '3', or 'bc1'."
        TtfNoDataMsg     = "Not enough data in the TTF log yet."
        TtfWaitAvg       = "Waiting..."
        TtfNoDataBox1    = "Not enough data for luck statistics yet."
        TtfNoDataBox2    = "Keep MinerIsma running to record your estimates!"
        TtfResetConfirm  = "Do you really want to reset all TTF statistics history?"
        TtfWinTitle      = "TTF Statistics (Block Estimate)"
        TtfPrizeHeader   = "Current Block Reward"
        TtfPrizeBtc      = "3.125 BTC"
        TtfPrizeUsdPref  = "$ ~US$ "
        TtfPrizeUsdWait  = "$ Updating price..."
        TtfDrawInfo      = '"Draw" every ~10 min'
        TtfHalving1      = "Next Halving in "
        TtfHalving2      = " Blocks"
        TtfAvgHeader     = "Estimated Average Time"
        TtfAvgSub        = "(until a Block / Luck)"
        TtfCountLbl      = "Collected Records:"
        TtfBestLbl       = "Closest Estimate (Luck Record):"
        TtfDate          = "Date:"
        TtfLuck          = "Your Luck:"
        TtfPower         = "Power:"
        AlertWinTitle    = "ABSOLUTE SUCCESS"
        AlertHeader      = "YOU FOUND A BLOCK!!!"
        AlertBlockHeight = "Block (height):"
        AlertCheckWallet = "Check wallet"
        AlertRewardInfo  = "Your Bitcoin reward will be available after 100 Blocks (~24 hours)."
        AlertLogInfo     = "Check the record in Log"
        AlertInFolder    = "in the MinerIsma folder."
    }
    ES = @{
        BtcUpdating      = "itcoin ahora: Actualizando..."
        BtcNowPrefix     = "itcoin ahora: US$ "
        BtcLinks         = "itcoin Links"
        MenuChannels     = "Canales Cripto"
        GameDesafios     = "Desafios Cripto $"
        GameBoard        = "TotheMoon Juego de Mesa"
        LinkPool         = "Tu Miner en la Pool"
        LinkUpdates      = "Actualizaciones MinerIsma"
        LinkMempool      = "Mempool Bitcoin"
        LinkTimeline     = "TimeLine Bitcoin"
        LinkMonitor      = "Monitor Cripto"
        LinkBlueWallet   = "Blue Wallet"
        LinkLearn        = "Aprende Cripto"
        LinkNews         = "BitNoticias"
        LinkGlobalAcc    = "Cuenta Global Cripto"
        LinkMissao1Btc   = $lblMissaoES
        LinkRetireBtc    = $lblRetireES
        LinkBtcMaps      = "Bitcoin Maps"
        LinkWeb          = "MinerIsma en la web"
        LinkGpuMiner     = $lblGpuMiner
        LinkBubbles      = "Crypto Bubbles"
        MsgWebSoon       = "La pagina web de MinerIsma estara disponible pronto."
        MenuStartup      = "Iniciar con Windows"
        DelayHeader      = "Delay:"
        DelayDefault     = "Por defecto"
        MenuWallet       = "Tu Billetera Bitcoin"
        MenuTestAlert    = "Probar Alerta de Bloque"
        MenuTtfStats     = "Estadisticas TTF: Tu Suerte"
        MenuLanguage     = "Idioma"
        MenuTutorial     = "Tutorial MinerIsma"
        MenuShare        = "Compartir MinerIsma"
        ShareCopiedShort = "Enlace copiado!"
        ShareCopiedMsg   = "Enlace de descarga copiado al portapapeles!"
        TutorialWinTitle = "Tutorial"
        MenuShowHide     = "Mostrar / Ocultar Miner"
        MenuPause        = "Pausar Mineria"
        MenuResume       = "Reanudar Mineria"
        PauseManual      = "Manual"
        Pause1h          = "1 hora"
        Pause2h          = "2 horas"
        Pulse2h          = "Pulsar 2hx5"
        Pulse4h          = "Pulsar 4hx5"
        MenuExit         = "Cerrar Mineria"
        TrayWaitStart    = "Esperando inicio..."
        TrayWaitWallet   = "ESPERANDO BILLETERA"
        TrayCalculating  = "Calculando..."
        TrayPaused       = "PAUSADO"
        TrayPausedUntil  = "PAUSADO (hasta"
        TrayPulsePause   = "PAUSA (hasta"
        TrayResuming     = "Reanudando..."
        BalloonStart1    = "Administrador en bandeja. La mineria inicia en"
        BalloonStart2    = "segundos."
        BtnSave          = "Guardar"
        BtnSaveImg       = "Guardar Imagen"
        BtnResetTtf      = "Reiniciar TTF"
        BtnClose         = "Cerrar"
        BtnCreateWallet  = "Crear Billetera"
        BtnCelebrate     = "Celebrar!"
        WalletWinTitle   = "Tu Billetera Bitcoin"
        WalletHeader     = "Configura direccion Bitcoin para iniciar Miner:"
        WalletLblAddr    = "Ingresa tu direccion de billetera Bitcoin (Ej.: bc1...):"
        WalletLblWorker  = "Ingresa tu Trabajador (Ej.: Pc_Gamer):"
        WalletWarn1      = "Una direccion erronea significa perder un posible premio, verifica!"
        WalletWarn2      = "Para el Trabajador, evita caracteres especiales, espacios y acentos"
        WalletEmptyMsg   = "Por favor, ingresa una direccion de billetera Bitcoin."
        WalletInvalid1   = "La direccion ingresada no parece ser una billetera Bitcoin valida."
        WalletInvalid2   = "Asegurate de que comience con '1', '3' o 'bc1'."
        TtfNoDataMsg     = "Aun no hay datos suficientes en el registro TTF."
        TtfWaitAvg       = "Esperando..."
        TtfNoDataBox1    = "Aun no hay datos suficientes para estadisticas de suerte."
        TtfNoDataBox2    = "Deja MinerIsma corriendo para registrar tus estimaciones!"
        TtfResetConfirm  = "Realmente deseas reiniciar todo el historial de estadisticas TTF?"
        TtfWinTitle      = "Estadisticas TTF (Estimacion de Bloque)"
        TtfPrizeHeader   = "Premio Actual del Bloque"
        TtfPrizeBtc      = "3.125 BTC"
        TtfPrizeUsdPref  = "$ ~US$ "
        TtfPrizeUsdWait  = "$ Actualizando cotizacion..."
        TtfDrawInfo      = '"Sorteo" cada ~10 min'
        TtfHalving1      = $lblHalvES1
        TtfHalving2      = " Bloques"
        TtfAvgHeader     = "Tiempo Promedio Estimado"
        TtfAvgSub        = "(hasta un Bloque / Suerte)"
        TtfCountLbl      = "Registros Recolectados:"
        TtfBestLbl       = "Mejor Aproximacion (Record de Suerte):"
        TtfDate          = "Fecha:"
        TtfLuck          = "Tu Suerte:"
        TtfPower         = "Poder:"
        AlertWinTitle    = "EXITO ABSOLUTO"
        AlertHeader      = "ENCONTRASTE UN BLOQUE!!!"
        AlertBlockHeight = "Bloque (altura):"
        AlertCheckWallet = "Verifica la billetera"
        AlertRewardInfo  = "Tu premio en Bitcoin estara disponible tras 100 Bloques (~24 horas)."
        AlertLogInfo     = "Verifica el registro en el Log"
        AlertInFolder    = "en la carpeta de MinerIsma."
    }
}

function Get-Text {
    param([string]$Key)
    $langDict = $global:LangTable[$global:Language]
    if ($null -eq $langDict) { $langDict = $global:LangTable["PT"] }
    $val = $langDict[$Key]
    if ([string]::IsNullOrWhiteSpace($val)) { return $Key }
    return [string]$val
}

# ================================================================
#  DAQUI PARA BAIXO NAO PRECISA EDITAR
# ================================================================
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationCore
[System.Windows.Forms.Application]::EnableVisualStyles()

$global:AppVersion        = "MinerIsma_v2.0.2 - Alpha"
$global:ShortVersion      = "MinerIsma v2.0"
$global:BtcSym            = [string][char]0x20BF
$global:BoltSym           = [string][char]0x26A1
$global:StarSym           = [string][char]0x2605
$global:Theme             = "Dark" # Padrao inicial de fabrica (Dark = Obsidiana / Light = Perola)
$global:ColorObsidian     = [System.Drawing.Color]::FromArgb(16, 21, 28)
$global:ColorPearl        = [System.Drawing.Color]::FromArgb(244, 241, 234)
$global:ColorBronzeBorder = [System.Drawing.Color]::FromArgb(90, 60, 24)

# Estrutura de Pastas: bin (atual), Raiz (pai), resources e Backup Oficial em AppData\Local\MinerIsma
$global:BasePath         = $PSScriptRoot
$global:RootPath         = Split-Path -Parent $global:BasePath
$global:ResPath          = Join-Path $global:RootPath "resources"
if (-not (Test-Path $global:ResPath)) {
    try { New-Item -ItemType Directory -Path $global:ResPath -Force | Out-Null } catch {}
}

$global:BackupDir        = Join-Path $env:LOCALAPPDATA "MinerIsma"
if (-not (Test-Path $global:BackupDir)) {
    try { New-Item -ItemType Directory -Path $global:BackupDir -Force | Out-Null } catch {}
}

$global:MinerExe         = Join-Path $global:BasePath $global:MinerExeName
$global:LauncherPath     = Join-Path $global:RootPath $global:LauncherFileName
$global:LogFile          = Join-Path $global:RootPath "BLOCK_FOUND_LOG.txt"
$global:TtfLogFile       = Join-Path $global:ResPath "MinerIsma_TTF_LOG.txt"
$global:LegacyTtfLogFile = Join-Path $global:ResPath "TTF_BLOCO_LOG.txt"
$global:ErrorLog         = Join-Path $global:ResPath "MinerManager_ERROS.log"
$global:ConfigFile       = Join-Path $global:ResPath "MinerIsma_Config.json"
$global:TutorialFile     = Join-Path $global:ResPath $global:TutorialFileName

# Caminhos de Backup Automatico em $env:LOCALAPPDATA\MinerIsma
$global:BackupConfigFile = Join-Path $global:BackupDir "MinerIsma_Config.json"
$global:BackupTtfLogFile = Join-Path $global:BackupDir "MinerIsma_TTF_LOG.txt"

# 1. Migrador Automatico: Converte TTF_BLOCO_LOG.txt antigo para MinerIsma_TTF_LOG.txt
try {
    if ((Test-Path -LiteralPath $global:LegacyTtfLogFile) -and (-not (Test-Path -LiteralPath $global:TtfLogFile))) {
        Move-Item -LiteralPath $global:LegacyTtfLogFile -Destination $global:TtfLogFile -Force -ErrorAction SilentlyContinue
    }
} catch {}

# 2. Fallback Inteligente na Partida: Restaura de AppData\Local\MinerIsma se ausente em resources, ou sincroniza 1x
try {
    if ((-not (Test-Path -LiteralPath $global:ConfigFile)) -and (Test-Path -LiteralPath $global:BackupConfigFile)) {
        Copy-Item -LiteralPath $global:BackupConfigFile -Destination $global:ConfigFile -Force -ErrorAction SilentlyContinue
    } elseif (Test-Path -LiteralPath $global:ConfigFile) {
        Copy-Item -LiteralPath $global:ConfigFile -Destination $global:BackupConfigFile -Force -ErrorAction SilentlyContinue
    }

    if ((-not (Test-Path -LiteralPath $global:TtfLogFile)) -and (Test-Path -LiteralPath $global:BackupTtfLogFile)) {
        Copy-Item -LiteralPath $global:BackupTtfLogFile -Destination $global:TtfLogFile -Force -ErrorAction SilentlyContinue
    } elseif (Test-Path -LiteralPath $global:TtfLogFile) {
        Copy-Item -LiteralPath $global:TtfLogFile -Destination $global:BackupTtfLogFile -Force -ErrorAction SilentlyContinue
    }
} catch {}

# Variaveis para Iniciar com Windows (Atalho Startup + Chave Run do Usuario)
$global:StartupFolder = [Environment]::GetFolderPath("Startup")
$global:ShortcutPath  = Join-Path $global:StartupFolder "MinerIsma.lnk"
$global:RunRegKey     = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
$global:RunRegName    = "MinerIsma"

# --- Inicio Padrao Inteligente (4 Threads para >= 16Th, 3 Threads para < 16Th) e Leitura do Config.json ---
$global:DefaultThreads     = if ($global:LogicalCores -ge 16) { 4 } else { 3 }
$global:ConfiguredDelay    = $global:DefaultStartupDelay
$global:StartupInitialized = $false
$global:StartupEnabled     = $true  # Habilitado por padrao na 1a vez
$global:SavedPulseMode     = ""     # Desabilitado de fabrica, salvo se escolhido pelo usuario
$global:CurrentBlockHeight = 0

if (Test-Path $global:ConfigFile) {
    try {
        $cfg = Get-Content $global:ConfigFile -Raw | ConvertFrom-Json
        if (($null -ne $cfg.LastThreads) -and ($global:ThreadProfiles.Contains([int]$cfg.LastThreads))) {
            $global:DefaultThreads = [int]$cfg.LastThreads
        }
        if (-not [string]::IsNullOrWhiteSpace($cfg.Wallet)) {
            $savedAddr = ($cfg.Wallet -replace '\..*?$', '').Trim()
            if ((-not [string]::IsNullOrWhiteSpace($savedAddr)) -and ($savedAddr -ne "minha_carteira")) {
                $global:Wallet = [string]$cfg.Wallet
            }
        }
        if ($null -ne $cfg.StartupDelay) {
            $dVal = [int]$cfg.StartupDelay
            if ($dVal -in @(5, 15, 30, 60)) {
                $global:ConfiguredDelay = $dVal
            }
        }
        if (-not [string]::IsNullOrWhiteSpace($cfg.SoundFileName)) {
            if ($cfg.SoundFileName -in @($global:SoundFileKMS, $global:SoundFileSenna, $global:SoundFileMforN, $global:SoundFileCoins)) {
                $global:SoundFileName = [string]$cfg.SoundFileName
            }
        }
        if ($null -ne $cfg.StartupInitialized) {
            $global:StartupInitialized = [bool]$cfg.StartupInitialized
        }
        if ($null -ne $cfg.StartupEnabled) {
            $global:StartupEnabled = [bool]$cfg.StartupEnabled
        }
        if (-not [string]::IsNullOrWhiteSpace($cfg.PulseMode)) {
            if ($cfg.PulseMode -in @("2hx5", "4hx5")) {
                $global:SavedPulseMode = [string]$cfg.PulseMode
            }
        }
        if (-not [string]::IsNullOrWhiteSpace($cfg.Language)) {
            if ($cfg.Language -in @("PT", "EN", "ES")) {
                $global:Language = [string]$cfg.Language
            }
        }
        if (-not [string]::IsNullOrWhiteSpace($cfg.Theme)) {
            if ($cfg.Theme -in @("Dark", "Light")) {
                $global:Theme = [string]$cfg.Theme
            }
        }
        if (($null -ne $cfg.LastBlockHeight) -and ([int]$cfg.LastBlockHeight -gt 840000)) {
            $global:CurrentBlockHeight = [int]$cfg.LastBlockHeight
        }
    } catch {}
}

$global:SoundFile = Join-Path $global:ResPath $global:SoundFileName

trap {
    $nl = [Environment]::NewLine
    $msg = "[{0}] ERRO CATCH: {1}{2}{3}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $_.Exception.Message, $nl, $_.InvocationInfo.PositionMessage
    try { Add-Content -Path $global:ErrorLog -Value $msg } catch {}
    continue
}

$global:CurrentProc         = $null
$global:IsPaused            = $false
$global:PauseResumeAt       = $null
$global:PulseMode           = ""
$global:PulseActiveMins     = 0
$global:PulsePauseMins      = 0
$global:PulseNextSwitch     = $null
$global:LastBtcUsdFormatted = ""
$global:LastBtcUsdValue     = 0.0

if ($global:SavedPulseMode -eq "2hx5") {
    $global:PulseMode       = "2hx5"
    $global:PulseActiveMins = 120
    $global:PulsePauseMins  = 5
    $global:PulseNextSwitch = (Get-Date).AddMinutes(120)
}
elseif ($global:SavedPulseMode -eq "4hx5") {
    $global:PulseMode       = "4hx5"
    $global:PulseActiveMins = 240
    $global:PulsePauseMins  = 5
    $global:PulseNextSwitch = (Get-Date).AddMinutes(240)
}

$global:TtfLogAllowedAt    = (Get-Date).AddSeconds($global:TtfWarmupSeconds)
$global:Visible            = $false
$global:BlockFoundLine     = $null
$global:CurrentThreads     = $global:DefaultThreads
$global:RestartAt          = $null
$global:CrashNotified      = $false
$global:StopRequested      = $false
$global:SoundPlayer        = $null
$global:LastTtfLogged      = ""
$global:DetectedMinerExe   = $global:MinerExeName
$global:WalletWarningShown = $false
$global:LogQueue           = New-Object System.Collections.Concurrent.ConcurrentQueue[string]
$global:RecentLines        = New-Object System.Collections.Generic.Queue[string]

# ============================================================
# API DO WINDOWS (THREADS + DWM + MENU E SCROLLBAR CLARO/ESCURO)
# ============================================================
Add-Type -ReferencedAssemblies System.Windows.Forms, System.Drawing -TypeDefinition @"
using System;
using System.Drawing;
using System.Windows.Forms;
using System.Runtime.InteropServices;

[StructLayout(LayoutKind.Sequential)]
public struct DwmRect {
    public int Left;
    public int Top;
    public int Right;
    public int Bottom;
}

public class ProcCtl {
    [DllImport("kernel32.dll")] public static extern IntPtr OpenThread(int access, bool inherit, uint tid);
    [DllImport("kernel32.dll")] public static extern uint SuspendThread(IntPtr hThread);
    [DllImport("kernel32.dll")] public static extern int ResumeThread(IntPtr hThread);
    [DllImport("kernel32.dll")] public static extern bool CloseHandle(IntPtr h);
    [DllImport("dwmapi.dll")] public static extern int DwmSetWindowAttribute(IntPtr hwnd, int attr, ref int attrValue, int attrSize);
    [DllImport("dwmapi.dll")] public static extern int DwmGetWindowAttribute(IntPtr hwnd, int attr, out DwmRect rect, int rectSize);
    [DllImport("user32.dll")] public static extern IntPtr SendMessage(IntPtr hWnd, int msg, IntPtr wParam, IntPtr lParam);
}

public class ObsidianVScrollBar : Control {
    public RichTextBox TargetBox { get; set; }
    public bool IsLightMode { get; set; }
    private bool isDragging = false;
    private bool isHoverThumb = false;
    private int dragOffsetY = 0;
    private int arrowHeight = 16;

    private Color borderCol = Color.FromArgb(90, 60, 24);
    private Color arrowCol  = Color.FromArgb(247, 147, 26);

    public ObsidianVScrollBar() {
        this.SetStyle(ControlStyles.UserPaint | ControlStyles.AllPaintingInWmPaint | ControlStyles.OptimizedDoubleBuffer | ControlStyles.ResizeRedraw, true);
        this.Width = 16;
        this.BackColor = Color.FromArgb(16, 21, 28);
    }

    private int GetVisibleLines() {
        if (TargetBox == null || TargetBox.Font == null) return 25;
        int fh = Math.Max(12, TargetBox.Font.Height);
        return Math.Max(1, TargetBox.ClientSize.Height / fh);
    }

    private int GetTotalLines() {
        if (TargetBox == null || !TargetBox.IsHandleCreated) return 1;
        int count = (int)ProcCtl.SendMessage(TargetBox.Handle, 0x00BA, IntPtr.Zero, IntPtr.Zero);
        return Math.Max(1, count);
    }

    private int GetFirstVisibleLine() {
        if (TargetBox == null || !TargetBox.IsHandleCreated) return 0;
        return Math.Max(0, (int)ProcCtl.SendMessage(TargetBox.Handle, 0x00CE, IntPtr.Zero, IntPtr.Zero));
    }

    private Rectangle GetThumbRect() {
        int trackTop = arrowHeight;
        int trackH = Math.Max(10, this.Height - (arrowHeight * 2));
        int total = GetTotalLines();
        int vis = GetVisibleLines();
        if (total <= vis) {
            return new Rectangle(2, trackTop, this.Width - 4, trackH);
        }
        int thumbH = Math.Max(26, (int)((double)vis / total * trackH));
        int maxFirst = Math.Max(1, total - vis);
        int first = Math.Min(maxFirst, GetFirstVisibleLine());
        int availH = Math.Max(1, trackH - thumbH);
        int thumbY = trackTop + (int)((double)first / maxFirst * availH);
        return new Rectangle(2, thumbY, this.Width - 4, thumbH);
    }

    protected override void OnPaint(PaintEventArgs e) {
        Graphics g = e.Graphics;
        g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;

        Color trackCol      = IsLightMode ? Color.FromArgb(232, 226, 214) : Color.FromArgb(16, 21, 28);
        Color thumbCol      = IsLightMode ? Color.FromArgb(196, 176, 148) : Color.FromArgb(42, 32, 20);
        Color thumbHoverCol = IsLightMode ? Color.FromArgb(168, 142, 108) : Color.FromArgb(68, 48, 26);

        using (SolidBrush bTrack = new SolidBrush(trackCol)) {
            g.FillRectangle(bTrack, this.ClientRectangle);
        }
        using (Pen pBorder = new Pen(borderCol, 1)) {
            g.DrawLine(pBorder, 0, 0, 0, this.Height);
            g.DrawRectangle(pBorder, 0, 0, this.Width - 1, arrowHeight - 1);
            g.DrawRectangle(pBorder, 0, this.Height - arrowHeight, this.Width - 1, arrowHeight - 1);
        }
        using (SolidBrush bArrow = new SolidBrush(arrowCol)) {
            Point[] upPts = new Point[] {
                new Point(this.Width / 2, 4),
                new Point(4, arrowHeight - 4),
                new Point(this.Width - 4, arrowHeight - 4)
            };
            Point[] dnPts = new Point[] {
                new Point(this.Width / 2, this.Height - 4),
                new Point(4, this.Height - arrowHeight + 4),
                new Point(this.Width - 4, this.Height - arrowHeight + 4)
            };
            g.FillPolygon(bArrow, upPts);
            g.FillPolygon(bArrow, dnPts);
        }

        Rectangle tr = GetThumbRect();
        Color tCol = (isDragging || isHoverThumb) ? thumbHoverCol : thumbCol;
        using (SolidBrush bThumb = new SolidBrush(tCol)) {
            g.FillRectangle(bThumb, tr);
        }
        using (Pen pThumb = new Pen(borderCol, 1)) {
            g.DrawRectangle(pThumb, tr.X, tr.Y, tr.Width - 1, tr.Height - 1);
        }
    }

    private void ScrollTargetLines(int deltaLines) {
        if (TargetBox == null || !TargetBox.IsHandleCreated || deltaLines == 0) return;
        ProcCtl.SendMessage(TargetBox.Handle, 0x00B6, IntPtr.Zero, (IntPtr)deltaLines);
        this.Invalidate();
    }

    protected override void OnMouseDown(MouseEventArgs e) {
        base.OnMouseDown(e);
        if (e.Button != MouseButtons.Left || TargetBox == null) return;
        if (e.Y < arrowHeight) {
            ScrollTargetLines(-3);
            return;
        }
        if (e.Y > this.Height - arrowHeight) {
            ScrollTargetLines(3);
            return;
        }
        Rectangle tr = GetThumbRect();
        if (tr.Contains(e.Location)) {
            isDragging = true;
            dragOffsetY = e.Y - tr.Y;
            this.Invalidate();
        } else if (e.Y < tr.Y) {
            ScrollTargetLines(-GetVisibleLines());
        } else if (e.Y > tr.Bottom) {
            ScrollTargetLines(GetVisibleLines());
        }
    }

    protected override void OnMouseMove(MouseEventArgs e) {
        base.OnMouseMove(e);
        if (isDragging && TargetBox != null && TargetBox.IsHandleCreated) {
            int trackTop = arrowHeight;
            int trackH = Math.Max(10, this.Height - (arrowHeight * 2));
            Rectangle tr = GetThumbRect();
            int availH = Math.Max(1, trackH - tr.Height);
            int newThumbY = Math.Max(trackTop, Math.Min(trackTop + availH, e.Y - dragOffsetY));
            double ratio = (double)(newThumbY - trackTop) / availH;
            int total = GetTotalLines();
            int vis = GetVisibleLines();
            int maxFirst = Math.Max(1, total - vis);
            int targetFirst = (int)Math.Round(ratio * maxFirst);
            int curFirst = GetFirstVisibleLine();
            ScrollTargetLines(targetFirst - curFirst);
        } else {
            bool hov = GetThumbRect().Contains(e.Location);
            if (hov != isHoverThumb) {
                isHoverThumb = hov;
                this.Invalidate();
            }
        }
    }

    protected override void OnMouseUp(MouseEventArgs e) {
        base.OnMouseUp(e);
        if (isDragging) {
            isDragging = false;
            this.Invalidate();
        }
    }

    protected override void OnMouseLeave(EventArgs e) {
        base.OnMouseLeave(e);
        if (isHoverThumb) {
            isHoverThumb = false;
            this.Invalidate();
        }
    }
}

public class ObsidianMenuColors : ProfessionalColorTable {
    public static bool IsLightMode = false;
    public static string CurrentLangBadge = "BR";

    private Color BgColor     { get { return IsLightMode ? Color.FromArgb(244, 241, 234) : Color.FromArgb(16, 21, 28); } }
    private Color MarginColor { get { return IsLightMode ? Color.FromArgb(232, 226, 214) : Color.FromArgb(10, 14, 20); } }
    private Color HoverColor  { get { return IsLightMode ? Color.FromArgb(255, 236, 209) : Color.FromArgb(40, 28, 14); } }
    private Color BtcOrange   { get { return Color.FromArgb(247, 147, 26); } }
    private Color BorderCol   { get { return Color.FromArgb(90, 60, 24); } }

    public override Color ToolStripDropDownBackground   { get { return BgColor; } }
    public override Color ImageMarginGradientBegin      { get { return MarginColor; } }
    public override Color ImageMarginGradientMiddle     { get { return MarginColor; } }
    public override Color ImageMarginGradientEnd        { get { return MarginColor; } }
    public override Color MenuBorder                    { get { return BorderCol; } }
    public override Color MenuItemBorder                { get { return BtcOrange; } }
    public override Color MenuItemSelected              { get { return HoverColor; } }
    public override Color MenuItemSelectedGradientBegin { get { return HoverColor; } }
    public override Color MenuItemSelectedGradientEnd   { get { return HoverColor; } }
    public override Color MenuItemPressedGradientBegin  { get { return HoverColor; } }
    public override Color MenuItemPressedGradientEnd    { get { return HoverColor; } }
    public override Color SeparatorDark                 { get { return BorderCol; } }
    public override Color SeparatorLight                { get { return BgColor; } }
    public override Color CheckBackground               { get { return HoverColor; } }
    public override Color CheckSelectedBackground       { get { return HoverColor; } }
    public override Color CheckPressedBackground        { get { return HoverColor; } }
}

public class ObsidianMenuRenderer : ToolStripProfessionalRenderer {
    public ObsidianMenuRenderer() : base(new ObsidianMenuColors()) {
        this.RoundedEdges = false;
    }
    protected override void OnRenderMenuItemBackground(ToolStripItemRenderEventArgs e) {
        if (e.Item != null && e.Item.Name == "HeaderItem") {
            return;
        }
        base.OnRenderMenuItemBackground(e);
    }
    protected override void OnRenderArrow(ToolStripArrowRenderEventArgs e) {
        e.ArrowColor = Color.FromArgb(247, 147, 26);
        base.OnRenderArrow(e);
    }
    protected override void OnRenderItemText(ToolStripItemTextRenderEventArgs e) {
        if (e.Item != null && e.Item.Name == "HeaderItem") {
            e.TextRectangle = new Rectangle(4, 0, Math.Max(80, e.Item.Width - 78), e.Item.Height);
            e.TextFormat = TextFormatFlags.Left | TextFormatFlags.VerticalCenter;
            base.OnRenderItemText(e);

            Graphics g = e.Graphics;
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
            int boxH   = 20;
            int boxY   = (e.Item.Height - boxH) / 2;
            int langW  = 26;
            int themeW = 24;
            int langX  = e.Item.Width - langW - 18;
            int themeX = langX - themeW - 4;

            Rectangle rTheme = new Rectangle(themeX, boxY, themeW, boxH);
            Rectangle rLang  = new Rectangle(langX, boxY, langW, boxH);

            Color boxBg  = ObsidianMenuColors.IsLightMode ? Color.FromArgb(232, 226, 214) : Color.FromArgb(26, 33, 44);
            Color symCol = ObsidianMenuColors.IsLightMode ? Color.FromArgb(205, 102, 0) : Color.FromArgb(247, 147, 26);

            using (SolidBrush b = new SolidBrush(boxBg)) {
                g.FillRectangle(b, rTheme);
                g.FillRectangle(b, rLang);
            }
            using (Pen p = new Pen(Color.FromArgb(90, 60, 24), 1)) {
                g.DrawRectangle(p, rTheme.X, rTheme.Y, rTheme.Width - 1, rTheme.Height - 1);
                g.DrawRectangle(p, rLang.X, rLang.Y, rLang.Width - 1, rLang.Height - 1);
            }
            string sym = ObsidianMenuColors.IsLightMode ? "\u2600" : "\u263E";
            TextRenderer.DrawText(g, sym, e.TextFont, rTheme, symCol, TextFormatFlags.HorizontalCenter | TextFormatFlags.VerticalCenter | TextFormatFlags.NoPadding);

            using (Font fLang = new Font("Segoe UI", 8.25f, FontStyle.Bold)) {
                TextRenderer.DrawText(g, ObsidianMenuColors.CurrentLangBadge, fLang, rLang, symCol, TextFormatFlags.HorizontalCenter | TextFormatFlags.VerticalCenter | TextFormatFlags.NoPadding);
            }
            return;
        }
        if (e.Item != null && e.Item.Name == "ThreadItem") {
            string txt = e.Text;
            int dotIdx = txt.IndexOf('.');
            if (dotIdx > 0) {
                string prefix  = txt.Substring(0, dotIdx);
                string pattern = txt.Substring(dotIdx);

                int refPrefW = TextRenderer.MeasureText(e.Graphics, "~48% \u219210 ", e.TextFont, new Size(300, e.Item.Height), TextFormatFlags.NoPadding).Width;
                int stepX    = Math.Max(4, TextRenderer.MeasureText(e.Graphics, "!", e.TextFont, new Size(50, e.Item.Height), TextFormatFlags.NoPadding).Width + 1);

                Rectangle prefRect = new Rectangle(e.TextRectangle.Left, 0, refPrefW + 10, e.Item.Height);
                TextRenderer.DrawText(e.Graphics, prefix, e.TextFont, prefRect, e.TextColor, TextFormatFlags.Left | TextFormatFlags.VerticalCenter | TextFormatFlags.NoPadding);

                Color bangCol = ObsidianMenuColors.IsLightMode ? Color.FromArgb(205, 102, 0) : Color.FromArgb(247, 147, 26);
                int startX = e.TextRectangle.Left + refPrefW;
                for (int i = 0; i < pattern.Length; i++) {
                    string ch = pattern.Substring(i, 1);
                    Color cCol = (ch == "!") ? bangCol : e.TextColor;
                    Rectangle chRect = new Rectangle(startX + (i * stepX), 0, stepX + 4, e.Item.Height);
                    TextRenderer.DrawText(e.Graphics, ch, e.TextFont, chRect, cCol, TextFormatFlags.HorizontalCenter | TextFormatFlags.VerticalCenter | TextFormatFlags.NoPadding);
                }
                return;
            }
        }
        base.OnRenderItemText(e);
    }
    protected override void OnRenderItemCheck(ToolStripItemImageRenderEventArgs e) {
        Graphics g = e.Graphics;
        g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
        Rectangle r = e.ImageRectangle;
        Color chkBg = ObsidianMenuColors.IsLightMode ? Color.FromArgb(255, 236, 209) : Color.FromArgb(40, 28, 14);
        using (SolidBrush b = new SolidBrush(chkBg)) {
            g.FillRectangle(b, r);
        }
        using (Pen pBorder = new Pen(Color.FromArgb(247, 147, 26), 1)) {
            g.DrawRectangle(pBorder, r.X, r.Y, r.Width - 1, r.Height - 1);
        }
        using (Pen pCheck = new Pen(Color.FromArgb(247, 147, 26), 2)) {
            g.DrawLines(pCheck, new Point[] {
                new Point(r.Left + 3, r.Top + r.Height / 2),
                new Point(r.Left + r.Width / 2 - 1, r.Bottom - 4),
                new Point(r.Right - 3, r.Top + 4)
            });
        }
    }
}
"@

function Get-WindowBgColor {
    if ($global:Theme -eq "Light") { return $global:ColorPearl }
    return $global:ColorObsidian
}

function Get-PrimaryTextColor {
    if ($global:Theme -eq "Light") { return [System.Drawing.Color]::FromArgb(26, 20, 14) }
    return [System.Drawing.Color]::White
}

function Get-SecondaryTextColor {
    if ($global:Theme -eq "Light") { return [System.Drawing.Color]::FromArgb(85, 70, 55) }
    return [System.Drawing.Color]::LightGray
}

function Get-AccentOrangeColor {
    if ($global:Theme -eq "Light") { return [System.Drawing.Color]::FromArgb(205, 102, 0) }
    return [System.Drawing.Color]::FromArgb(255, 247, 147, 26)
}

function Set-WindowDarkTheme {
    param([System.Windows.Forms.Form]$Form)
    if ($null -eq $Form) { return }
    try {
        $isLight = ($global:Theme -eq "Light")
        $Form.BackColor = Get-WindowBgColor
        $hwnd = $Form.Handle
        $dark = if ($isLight) { 0 } else { 1 }
        [ProcCtl]::DwmSetWindowAttribute($hwnd, 20, [ref]$dark, 4) | Out-Null
        [ProcCtl]::DwmSetWindowAttribute($hwnd, 19, [ref]$dark, 4) | Out-Null

        if ($isLight) {
            $borderColor  = 0x00183C5A
            $captionColor = 0x00D6E2E8
            $textColor    = 0x00005CC4
        } else {
            $borderColor  = 0x0014202A
            $captionColor = 0x00140E0A
            $textColor    = 0x001A93F7
        }
        [ProcCtl]::DwmSetWindowAttribute($hwnd, 34, [ref]$borderColor, 4) | Out-Null
        [ProcCtl]::DwmSetWindowAttribute($hwnd, 35, [ref]$captionColor, 4) | Out-Null
        [ProcCtl]::DwmSetWindowAttribute($hwnd, 36, [ref]$textColor, 4) | Out-Null
    } catch {}
}

function Copy-WindowScreenImage {
    param([System.Windows.Forms.Form]$Form, [System.Windows.Forms.Control]$FocusCtrl)
    if ($null -eq $Form) { return $null }
    try {
        if ($null -ne $FocusCtrl) { $FocusCtrl.Focus() | Out-Null }
        $Form.Refresh()
        [System.Windows.Forms.Application]::DoEvents()
        Start-Sleep -Milliseconds 60

        $dwmRect = New-Object DwmRect
        $res = [ProcCtl]::DwmGetWindowAttribute($Form.Handle, 9, [ref]$dwmRect, [System.Runtime.InteropServices.Marshal]::SizeOf($dwmRect))
        if (($res -eq 0) -and (($dwmRect.Right - $dwmRect.Left) -gt 100)) {
            $x = $dwmRect.Left
            $y = $dwmRect.Top
            $w = $dwmRect.Right - $dwmRect.Left
            $h = $dwmRect.Bottom - $dwmRect.Top
        } else {
            $x = $Form.Bounds.X
            $y = $Form.Bounds.Y
            $w = $Form.Bounds.Width
            $h = $Form.Bounds.Height
        }

        $bmp = New-Object System.Drawing.Bitmap($w, $h)
        $g = [System.Drawing.Graphics]::FromImage($bmp)
        $g.CopyFromScreen($x, $y, 0, 0, (New-Object System.Drawing.Size($w, $h)))
        $g.Dispose()
        return $bmp
    } catch {
        return $null
    }
}

function Set-ObsidianButtonStyle {
    param([System.Windows.Forms.Button]$Btn, [bool]$IsAccent = $false)
    if ($null -eq $Btn) { return }
    $isLight = ($global:Theme -eq "Light")
    $Btn.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $Btn.FlatAppearance.BorderSize = 1
    $Btn.FlatAppearance.BorderColor = $global:ColorBronzeBorder
    if ($isLight) {
        $Btn.BackColor = [System.Drawing.Color]::FromArgb(232, 226, 214)
        $Btn.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::FromArgb(255, 236, 209)
        $Btn.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::FromArgb(245, 218, 180)
        $Btn.ForeColor = if ($IsAccent) { [System.Drawing.Color]::FromArgb(205, 102, 0) } else { [System.Drawing.Color]::FromArgb(26, 20, 14) }
    } else {
        $Btn.BackColor = [System.Drawing.Color]::FromArgb(22, 29, 38)
        $Btn.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::FromArgb(40, 28, 14)
        $Btn.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::FromArgb(62, 42, 20)
        $Btn.ForeColor = if ($IsAccent) { [System.Drawing.Color]::FromArgb(255, 247, 147, 26) } else { [System.Drawing.Color]::White }
    }
}

function Set-MenuObsidianTheme {
    param([System.Windows.Forms.ToolStripDropDown]$MenuStrip)
    if ($null -eq $MenuStrip) { return }
    $isLight = ($global:Theme -eq "Light")
    [ObsidianMenuColors]::IsLightMode = $isLight
    [ObsidianMenuColors]::CurrentLangBadge = if ($global:Language -eq "PT") { "BR" } else { $global:Language }

    $bgCol       = if ($isLight) { $global:ColorPearl } else { $global:ColorObsidian }
    $txtCol      = if ($isLight) { [System.Drawing.Color]::FromArgb(26, 20, 14) } else { [System.Drawing.Color]::FromArgb(230, 237, 243) }
    $btcCol      = if ($isLight) { [System.Drawing.Color]::FromArgb(205, 102, 0) } else { [System.Drawing.Color]::FromArgb(255, 247, 147, 26) }
    $lightOrgCol = if ($isLight) { [System.Drawing.Color]::FromArgb(215, 115, 20) } else { [System.Drawing.Color]::FromArgb(255, 185, 95) }
    $goldCol     = if ($isLight) { [System.Drawing.Color]::FromArgb(180, 95, 0) } else { [System.Drawing.Color]::FromArgb(255, 209, 102) }

    $MenuStrip.Renderer  = New-Object ObsidianMenuRenderer
    $MenuStrip.BackColor = $bgCol
    $MenuStrip.ForeColor = $txtCol

    foreach ($item in $MenuStrip.Items) {
        $item.BackColor = $bgCol
        if ($item -eq $headerItem) {
            $item.ForeColor = $btcCol
        } elseif ($item -eq $global:btcPriceItem) {
            $item.ForeColor = $goldCol
        } elseif ($item -eq $global:lblPowerHeader) {
            $item.ForeColor = $lightOrgCol
        } else {
            $item.ForeColor = $txtCol
        }

        if ($item -is [System.Windows.Forms.ToolStripMenuItem] -and $item.HasDropDownItems) {
            $item.DropDown.BackColor = $bgCol
            $item.DropDown.ForeColor = $txtCol
            foreach ($sub in $item.DropDownItems) {
                $sub.BackColor = $bgCol
                if ($sub -eq $global:lblDelayHeader) {
                    $sub.ForeColor = $lightOrgCol
                } else {
                    $sub.ForeColor = $txtCol
                }
            }
        }
    }
    $MenuStrip.Invalidate()
}

function Set-AppTheme {
    param([string]$NewTheme)
    if ($NewTheme -notin @("Dark", "Light")) { return }
    $global:Theme = $NewTheme
    Save-MinerConfig

    Set-MenuObsidianTheme $menu
    if ($null -ne $global:logForm) {
        Set-WindowDarkTheme $global:logForm
    }
    if ($null -ne $global:logScrollBar) {
        $global:logScrollBar.IsLightMode = ($global:Theme -eq "Light")
        $global:logScrollBar.Invalidate()
    }
    $global:LogQueue.Enqueue("[SISTEMA] Tema visual alterado para: $NewTheme")
}

$global:shareBalloonTimer = New-Object System.Windows.Forms.Timer
$global:shareBalloonTimer.Interval = 150
$global:shareBalloonTimer.Add_Tick({
    $global:shareBalloonTimer.Stop()
    try {
        $global:notifyIcon.ShowBalloonTip(3000, "$($global:ShortVersion)", (Get-Text "ShareCopiedShort"), [System.Windows.Forms.ToolTipIcon]::Info)
    } catch {}
})

function Invoke-ShareMinerIsma {
    try {
        [System.Windows.Forms.Clipboard]::SetText([string]$global:UrlDriveUpdates)
        $global:LogQueue.Enqueue("[SISTEMA] $(Get-Text 'ShareCopiedMsg') ($($global:UrlDriveUpdates))")
        $global:shareBalloonTimer.Stop()
        $global:shareBalloonTimer.Start()
    } catch {}
}

function Open-GameWindow {
    param([string]$Url)
    if ([string]::IsNullOrWhiteSpace($Url)) { return }
    try {
        $workArea = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea
        $winW = [Math]::Min(1024, [Math]::Max(800, $workArea.Width - 40))
        $winH = [Math]::Min(768, [Math]::Max(600, $workArea.Height - 40))
        $posX = [Math]::Max(10, [int](($workArea.Width - $winW) / 2))
        $posY = [Math]::Max(10, [int](($workArea.Height - $winH) / 2))

        $gameProfileDir = Join-Path $env:TEMP "MinerIsma_GameApp"
        $prefFile = Join-Path $gameProfileDir "Default\Preferences"
        if (Test-Path -LiteralPath $prefFile) {
            Remove-Item -LiteralPath $prefFile -Force -ErrorAction SilentlyContinue
        }

        $q = [char]34
        $appArgs = "--user-data-dir=" + $q + $gameProfileDir + $q + " --app=" + $q + $Url + $q + " --window-size=$winW,$winH --window-position=$posX,$posY --no-first-run --no-default-browser-check"

        $edgePaths = @(
            (Join-Path ${env:ProgramFiles(x86)} "Microsoft\Edge\Application\msedge.exe"),
            (Join-Path $env:ProgramFiles "Microsoft\Edge\Application\msedge.exe")
        )
        foreach ($ep in $edgePaths) {
            if (($null -ne $ep) -and (Test-Path -LiteralPath $ep)) {
                Start-Process -FilePath $ep -ArgumentList $appArgs
                return
            }
        }
        $chromePaths = @(
            (Join-Path $env:ProgramFiles "Google\Chrome\Application\chrome.exe"),
            (Join-Path ${env:ProgramFiles(x86)} "Google\Chrome\Application\chrome.exe")
        )
        foreach ($cp in $chromePaths) {
            if (($null -ne $cp) -and (Test-Path -LiteralPath $cp)) {
                Start-Process -FilePath $cp -ArgumentList $appArgs
                return
            }
        }
        Start-Process $Url
    } catch {
        try { Start-Process $Url } catch {}
    }
}

function Initialize-CpuDetection {
    try {
        $cpuObj = Get-CimInstance Win32_Processor | Select-Object -First 1
        $cpuName = $cpuObj.Name
        $global:LogQueue.Enqueue("[SISTEMA] Processador detectado: $cpuName ($($global:LogicalCores) Threads)")
        
        $bestExe = $global:MinerExeName # O Curinga Padrao (cpuminer-avx2-sha.exe)

        if ($cpuName -match "AMD") {
            if ($cpuName -match "Ryzen.+ ([789]\d{3}|AI\s*[3579]\d{2})") { $bestExe = "cpuminer-avx512-sha-vaes.exe" } 
            elseif ($cpuName -match "Ryzen.+ [56]\d{3}")                 { $bestExe = "cpuminer-avx2-sha-vaes.exe" }   
            elseif ($cpuName -match "Ryzen|EPYC|Threadripper")           { $bestExe = "cpuminer-avx2-sha.exe" }        
        }
        elseif ($cpuName -match "Intel") {
            if ($cpuName -match "Core.*Ultra|i\d-(1[2-9]|[2-9]\d)\d{3}") { $bestExe = "cpuminer-avx2-sha-vaes.exe" }  
            elseif ($cpuName -match "i\d-11\d{3}")                       { $bestExe = "cpuminer-avx512-sha-vaes.exe" } 
            elseif ($cpuName -match "i\d-10\d{3}")                       { $bestExe = "cpuminer-avx2.exe" }            
            elseif ($cpuName -match "i\d-[4-9]\d{3}")                    { $bestExe = "cpuminer-avx2.exe" }            
            elseif ($cpuName -match "i\d-[23]\d{3}")                     { $bestExe = "cpuminer-avx.exe" }             
        }

        $testPath = Join-Path $global:BasePath $bestExe
        if (Test-Path $testPath) {
            $global:DetectedMinerExe = $bestExe
            $global:MinerExe = $testPath
            $global:LogQueue.Enqueue("[SISTEMA] Motor Otimizado Selecionado: $bestExe")
        } else {
            $global:LogQueue.Enqueue("[SISTEMA] Motor ($bestExe) nao encontrado. Usando curinga: $($global:MinerExeName)")
            $global:DetectedMinerExe = $global:MinerExeName
            $global:MinerExe = Join-Path $global:BasePath $global:DetectedMinerExe
        }
    } catch {
        $global:LogQueue.Enqueue("[SISTEMA] Falha na auto-deteccao de CPU. Usando curinga padrao.")
        $global:DetectedMinerExe = $global:MinerExeName
        $global:MinerExe = Join-Path $global:BasePath $global:DetectedMinerExe
    }
}

# ============================================================
# CONFIGURACAO DE CARTEIRA, TUTORIAL E FUNCOES AUXILIARES
# ============================================================
function Test-WalletConfigured {
    if ([string]::IsNullOrWhiteSpace($global:Wallet)) { return $false }
    $addr = ($global:Wallet -replace '\..*?$', '').Trim()
    if ([string]::IsNullOrWhiteSpace($addr) -or ($addr -eq "minha_carteira")) { return $false }
    return $true
}

function Save-MinerConfig {
    try {
        $cfg = @{
            LastThreads        = $global:CurrentThreads
            Wallet             = $global:Wallet
            StartupDelay       = $global:ConfiguredDelay
            SoundFileName      = $global:SoundFileName
            StartupInitialized = $global:StartupInitialized
            StartupEnabled     = $global:StartupEnabled
            PulseMode          = $global:PulseMode
            Language           = $global:Language
            Theme              = $global:Theme
            LastBlockHeight    = $global:CurrentBlockHeight
        }
        $jsonOut = $cfg | ConvertTo-Json
        $jsonOut | Out-File -FilePath $global:ConfigFile -Encoding utf8
        # Sincroniza tambem no Backup em AppData\Local\MinerIsma
        $jsonOut | Out-File -FilePath $global:BackupConfigFile -Encoding utf8
    } catch {}
}

function Show-Tutorial {
    if (-not (Test-Path $global:TutorialFile)) {
        [System.Windows.Forms.MessageBox]::Show("O arquivo '$($global:TutorialFileName)' ainda nao foi colocado na pasta 'resources'.", "$($global:ShortVersion) - Tutorial", 0, 64) | Out-Null
        return
    }

    # Padrao 1024x768 ajustavel automaticamente caso a tela do notebook seja menor
    $workArea = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea
    $winW = [Math]::Min(1024, [Math]::Max(820, $workArea.Width - 40))
    $winH = [Math]::Min(768, [Math]::Max(600, $workArea.Height - 40))

    $winBg = Get-WindowBgColor

    $tutForm = New-Object System.Windows.Forms.Form
    $tutForm.Text = "$($global:ShortVersion) - $(Get-Text 'TutorialWinTitle')"
    $tutForm.Size = New-Object System.Drawing.Size($winW, $winH)
    $tutForm.MinimumSize = New-Object System.Drawing.Size(820, 600)
    $tutForm.StartPosition = "CenterScreen"
    $tutForm.BackColor = $winBg
    $tutForm.Icon = $global:notifyIcon.Icon

    $bottomPanel = New-Object System.Windows.Forms.Panel
    $bottomPanel.Dock = "Bottom"
    $bottomPanel.Height = 56
    $bottomPanel.BackColor = $winBg

    $web = New-Object System.Windows.Forms.WebBrowser
    $web.Dock = "Fill"
    $web.IsWebBrowserContextMenuEnabled = $true
    $web.WebBrowserShortcutsEnabled = $true
    $web.ScriptErrorsSuppressed = $true
    $web.Navigate($global:TutorialFile)

    # Sincroniza o idioma da pagina Tutorial.html e aplica as cores da moldura na barra de rolagem
    $web.Add_DocumentCompleted({
        param($sender, $e)
        try {
            if ($null -ne $sender.Document) {
                if ($null -ne $sender.Document.Body) {
                    if ($global:Theme -eq "Light") {
                        $sender.Document.Body.Style = "scrollbar-face-color: #C4B094; scrollbar-track-color: #E8E2D6; scrollbar-arrow-color: #F7931A; scrollbar-highlight-color: #5A3C18; scrollbar-shadow-color: #5A3C18; scrollbar-3dlight-color: #E8E2D6; scrollbar-darkshadow-color: #5A3C18;"
                    } else {
                        $sender.Document.Body.Style = "scrollbar-face-color: #2A2014; scrollbar-track-color: #10151C; scrollbar-arrow-color: #F7931A; scrollbar-highlight-color: #5A3C18; scrollbar-shadow-color: #5A3C18; scrollbar-3dlight-color: #10151C; scrollbar-darkshadow-color: #0A0E14;"
                    }
                }
                $sender.Document.InvokeScript("setTutorialLang", @([string]$global:Language)) | Out-Null
            }
        } catch {}
    })

    # Qualquer link externo http/https clicado dentro do Tutorial abre no navegador padrao
    $web.Add_Navigating({
        param($sender, $e)
        if ($e.Url.Scheme -match "^https?$") {
            $e.Cancel = $true
            Start-Process $e.Url.AbsoluteUri
        }
    })

    # Acopla primeiro os paineis na janela para que o bottomPanel assuma a largura real
    $tutForm.Controls.Add($web)
    $tutForm.Controls.Add($bottomPanel)

    $btnShare = New-Object System.Windows.Forms.Button
    $btnShare.Text = Get-Text "MenuShare"
    $btnShare.Size = New-Object System.Drawing.Size(210, 40)
    $btnShare.Location = New-Object System.Drawing.Point(24, 8)
    $btnShare.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left
    $btnShare.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    Set-ObsidianButtonStyle $btnShare $true
    $btnShare.Add_Click({
        Invoke-ShareMinerIsma
        $this.Text = Get-Text "ShareCopiedShort"
    })
    $bottomPanel.Controls.Add($btnShare)

    $btnClose = New-Object System.Windows.Forms.Button
    $btnClose.Text = Get-Text "BtnClose"
    $btnClose.Size = New-Object System.Drawing.Size(140, 40)
    $btnX = [Math]::Max(20, ($bottomPanel.ClientSize.Width - 164))
    $btnClose.Location = New-Object System.Drawing.Point($btnX, 8)
    $btnClose.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right
    $btnClose.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    Set-ObsidianButtonStyle $btnClose $false
    $btnClose.Add_Click({ $tutForm.Close() })
    $bottomPanel.Controls.Add($btnClose)

    $tutForm.Add_Shown({
        Set-WindowDarkTheme $tutForm
        $btnClose.Left = [Math]::Max(20, ($bottomPanel.ClientSize.Width - $btnClose.Width - 24))
        $btnClose.Focus() | Out-Null
    })

    $tutForm.ShowDialog() | Out-Null
    $tutForm.Dispose()
}

function Show-WalletConfig {
    $walletForm = New-Object System.Windows.Forms.Form
    $walletForm.Text = "$($global:ShortVersion) - $(Get-Text 'WalletWinTitle')"
    $walletForm.Size = New-Object System.Drawing.Size(580, 380)
    $walletForm.StartPosition = "CenterScreen"
    $walletForm.BackColor = Get-WindowBgColor
    $walletForm.FormBorderStyle = "FixedDialog"
    $walletForm.MaximizeBox = $false
    $walletForm.Icon = $global:notifyIcon.Icon

    $colorBitcoin = Get-AccentOrangeColor
    $txtPrimary   = Get-PrimaryTextColor
    $txtSecondary = Get-SecondaryTextColor
    $darkBoxBg    = [System.Drawing.Color]::FromArgb(9, 13, 18)

    $lblHeader = New-Object System.Windows.Forms.Label
    $lblHeader.Text = Get-Text "WalletHeader"
    $lblHeader.Location = New-Object System.Drawing.Point(20, 20)
    $lblHeader.AutoSize = $true
    $lblHeader.ForeColor = $colorBitcoin
    $lblHeader.Font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)

    $lblWallet = New-Object System.Windows.Forms.Label
    $lblWallet.Text = Get-Text "WalletLblAddr"
    $lblWallet.Location = New-Object System.Drawing.Point(20, 62)
    $lblWallet.AutoSize = $true
    $lblWallet.ForeColor = $txtPrimary
    $lblWallet.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Regular)

    $currentAddr = ($global:Wallet -replace '\..*?$', '').Trim()
    if ($currentAddr -eq "minha_carteira") { $currentAddr = "" }

    $currentWorker = "WORKER"
    if ($global:Wallet -match '\.(.+)$') {
        $currentWorker = ($Matches[1]).Trim()
    }

    # Campo visivel para ~42 caracteres com contorno fino Bronze (sem borda 3D branca)
    $script:txtWallet = New-Object System.Windows.Forms.TextBox
    $script:txtWallet.Text = $currentAddr
    $script:txtWallet.MaxLength = 0
    $script:txtWallet.BorderStyle = "None"
    $script:txtWallet.Location = New-Object System.Drawing.Point(25, 95)
    $script:txtWallet.Size = New-Object System.Drawing.Size(400, 19)
    $script:txtWallet.BackColor = $darkBoxBg
    $script:txtWallet.ForeColor = [System.Drawing.Color]::Gold
    $script:txtWallet.Font = New-Object System.Drawing.Font("Consolas", 11)

    $lblWorker = New-Object System.Windows.Forms.Label
    $lblWorker.Text = Get-Text "WalletLblWorker"
    $lblWorker.Location = New-Object System.Drawing.Point(20, 130)
    $lblWorker.AutoSize = $true
    $lblWorker.ForeColor = $txtPrimary
    $lblWorker.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Regular)

    # Campo visivel para ~10-12 caracteres com contorno fino Bronze (sem borda 3D branca)
    $script:txtWorker = New-Object System.Windows.Forms.TextBox
    $script:txtWorker.Text = $currentWorker
    $script:txtWorker.MaxLength = 0
    $script:txtWorker.BorderStyle = "None"
    $script:txtWorker.Location = New-Object System.Drawing.Point(25, 163)
    $script:txtWorker.Size = New-Object System.Drawing.Size(110, 19)
    $script:txtWorker.BackColor = $darkBoxBg
    $script:txtWorker.ForeColor = [System.Drawing.Color]::Cyan
    $script:txtWorker.Font = New-Object System.Drawing.Font("Consolas", 11)

    # Desenha os quadros escuros e o contorno fino Bronze de 1px ao redor dos 2 campos
    $walletForm.Add_Paint({
        param($s, $e)
        $bFill = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(9, 13, 18))
        $pBronze = New-Object System.Drawing.Pen($global:ColorBronzeBorder, 1)
        $e.Graphics.FillRectangle($bFill, 20, 90, 410, 28)
        $e.Graphics.DrawRectangle($pBronze, 20, 90, 409, 27)
        $e.Graphics.FillRectangle($bFill, 20, 158, 120, 28)
        $e.Graphics.DrawRectangle($pBronze, 20, 158, 119, 27)
        $bFill.Dispose()
        $pBronze.Dispose()
    })

    $lblWarn1 = New-Object System.Windows.Forms.Label
    $lblWarn1.Text = Get-Text "WalletWarn1"
    $lblWarn1.Location = New-Object System.Drawing.Point(20, 205)
    $lblWarn1.AutoSize = $true
    $lblWarn1.ForeColor = $colorBitcoin
    $lblWarn1.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)

    $lblWarn2 = New-Object System.Windows.Forms.Label
    $lblWarn2.Text = Get-Text "WalletWarn2"
    $lblWarn2.Location = New-Object System.Drawing.Point(20, 230)
    $lblWarn2.AutoSize = $true
    $lblWarn2.ForeColor = $txtSecondary
    $lblWarn2.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Regular)

    $script:WalletSavedNow = $false

    $btnSave = New-Object System.Windows.Forms.Button
    $btnSave.Text = Get-Text "BtnSave"
    $btnSave.Location = New-Object System.Drawing.Point(20, 275)
    $btnSave.Size = New-Object System.Drawing.Size(140, 40)
    $btnSave.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    Set-ObsidianButtonStyle $btnSave $false
    $btnSave.Add_Click({
        $newAddr = ($script:txtWallet.Text -replace '\s+', '').Trim('.')
        $newWrk  = ($script:txtWorker.Text -replace '\s+', '').Trim('.')

        if ([string]::IsNullOrWhiteSpace($newAddr) -or ($newAddr -eq "minha_carteira")) {
            [System.Windows.Forms.MessageBox]::Show((Get-Text "WalletEmptyMsg"), "$($global:ShortVersion)", 0, 48) | Out-Null
            return
        }

        # Validacao do formato padrao do Bitcoin (comeca com 1, 3 ou bc1) e tamanho minimo/maximo aceitavel
        if ($newAddr -notmatch '^(1|3|bc1)[a-zA-HJ-NP-Z0-9]{25,62}$') {
            $nl = [Environment]::NewLine
            $msgFormato = (Get-Text "WalletInvalid1") + $nl + $nl + (Get-Text "WalletInvalid2")
            [System.Windows.Forms.MessageBox]::Show($msgFormato, "$($global:ShortVersion)", 0, 16) | Out-Null
            return
        }

        if ([string]::IsNullOrWhiteSpace($newWrk)) {
            $newWrk = "WORKER"
        }

        $global:Wallet = "$newAddr.$newWrk"
        Save-MinerConfig
        $global:LogQueue.Enqueue("[SISTEMA] Carteira atualizada: $($global:Wallet)")
        $script:WalletSavedNow = $true
        $walletForm.Close()
    })

    $btnCreate = New-Object System.Windows.Forms.Button
    $btnCreate.Text = Get-Text "BtnCreateWallet"
    $btnCreate.Location = New-Object System.Drawing.Point(210, 275)
    $btnCreate.Size = New-Object System.Drawing.Size(140, 40)
    $btnCreate.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    Set-ObsidianButtonStyle $btnCreate $true
    $btnCreate.Add_Click({
        Start-Process $global:UrlBlueWallet
    })

    $btnClose = New-Object System.Windows.Forms.Button
    $btnClose.Text = Get-Text "BtnClose"
    $btnClose.Location = New-Object System.Drawing.Point(400, 275)
    $btnClose.Size = New-Object System.Drawing.Size(140, 40)
    $btnClose.Font = New-Object System.Drawing.Font("Segoe UI", 10)
    Set-ObsidianButtonStyle $btnClose $false
    $btnClose.Add_Click({ $walletForm.Close() })

    $walletForm.Controls.Add($lblHeader)
    $walletForm.Controls.Add($lblWallet)
    $walletForm.Controls.Add($script:txtWallet)
    $walletForm.Controls.Add($lblWorker)
    $walletForm.Controls.Add($script:txtWorker)
    $walletForm.Controls.Add($lblWarn1)
    $walletForm.Controls.Add($lblWarn2)
    $walletForm.Controls.Add($btnSave)
    $walletForm.Controls.Add($btnCreate)
    $walletForm.Controls.Add($btnClose)

    # Tira o foco do TextBox para impedir o texto selecionado em azul ao abrir
    $walletForm.Add_Shown({
        Set-WindowDarkTheme $walletForm
        $btnSave.Focus() | Out-Null
    })

    $walletForm.ShowDialog() | Out-Null
    $walletForm.Dispose()

    if ($script:WalletSavedNow) {
        if ($global:IsPaused) {
            $global:itemPause.Text = Get-Text "MenuPause"
            $global:IsPaused = $false
            $global:PauseResumeAt = $null
        }
        if ($global:PulseMode -ne "") {
            $global:PulseNextSwitch = (Get-Date).AddMinutes($global:PulseActiveMins)
        }
        $global:notifyIcon.Text = "$($global:ShortVersion)" + [Environment]::NewLine + "$($global:CurrentThreads) Threads | $(Get-Text 'TrayCalculating')"
        Start-MinerTask $global:CurrentThreads
    }
}

# ============================================================
# FUNCOES AUXILIARES E ESTATISTICAS TTF
# ============================================================
function Get-Affinity {
    param([int]$Threads)
    foreach ($entry in $global:ThreadProfiles.GetEnumerator()) {
        if ([int]$entry.Key -eq $Threads) { return [string]$entry.Value }
    }
    return $null
}

function Write-ErrorLog {
    param([string]$Message)
    $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    try { Add-Content -Path $global:ErrorLog -Value "[$stamp] $Message" } catch {}
}

function Convert-TtfToDays {
    param([string]$ttf)
    if ($ttf -notmatch "\d") { return $null }
    $days = 0.0
    if ($ttf -match "(\d+)y") { $days += 365.0 * [int]$Matches[1] }
    if ($ttf -match "(\d+)d") { $days += [int]$Matches[1] }
    if ($ttf -match "(\d+)h") { $days += [int]$Matches[1] / 24.0 }
    if ($ttf -match "(\d+)m") { $days += [int]$Matches[1] / 1440.0 }
    if ($ttf -match "(\d+)s") { $days += [int]$Matches[1] / 86400.0 }
    return $days
}

function Get-RemainingHalvingBlocks {
    # Captura a altura mais recente dos logs ativos ou usa estimativa matematica pelo relogio de 10 min do Bloco 840.000
    foreach ($l in @($global:RecentLines)) {
        if ($l -match "Block\s+(\d{6,7})\b") {
            $bNum = [int]$Matches[1]
            if ($bNum -gt $global:CurrentBlockHeight) {
                $global:CurrentBlockHeight = $bNum
            }
        }
    }
    $anchorUtc = [datetime]::new(2024, 4, 20, 0, 9, 27, [System.DateTimeKind]::Utc)
    $elapsedMins = ([datetime]::UtcNow - $anchorUtc).TotalMinutes
    $estHeight = 840000 + [int][Math]::Floor($elapsedMins / 10.0)
    $effectiveHeight = [Math]::Max($global:CurrentBlockHeight, $estHeight)
    return [Math]::Max(1, (1050000 - $effectiveHeight))
}

function Show-TtfStats {
    $lines = @()
    if (Test-Path $global:TtfLogFile) {
        $lines = @(Get-Content $global:TtfLogFile)
    }

    $bestLine = ""
    $bestDays = 999999.0
    $sumDays = 0.0
    $count = 0

    foreach ($l in $lines) {
        if ($l -match "TTF Bloco:\s*([^ |]+)") {
            $ttfStr = $Matches[1].Trim()
            $d = Convert-TtfToDays $ttfStr
            if ($null -ne $d) {
                $sumDays += $d
                $count++
                if ($d -lt $bestDays) {
                    $bestDays = $d
                    $bestLine = $l
                }
            }
        }
    }

    $hasData = ($count -gt 0)
    $avgStr  = Get-Text "TtfWaitAvg"
    $bDate   = ""
    $bThr    = ""
    $bHash   = ""
    $bTtf    = ""
    $isParsed = $false

    if ($hasData) {
        $avg = $sumDays / $count
        $avgYears = [Math]::Floor($avg / 365)
        $remDays = $avg % 365
        $avgDaysF = [Math]::Floor($remDays)
        $avgHours = [Math]::Floor(($remDays - $avgDaysF) * 24)
        $avgStr = ""
        if ($avgYears -gt 0) { $avgStr += $avgYears.ToString() + "y " }
        $avgStr += $avgDaysF.ToString() + "d " + $avgHours.ToString() + "h"

        if ($bestLine -match "\x5B(.*?)\x5D Threads: (\d+) \| Hashrate: (.*?) \| TTF Bloco: (.*?) \|") {
            $bDate = $Matches[1]
            $bThr = $Matches[2]
            $bHash = $Matches[3]
            $bTtf = $Matches[4]
            $isParsed = $true
        }
    }

    $statForm = New-Object System.Windows.Forms.Form
    $statForm.Text = Get-Text "TtfWinTitle"
    $statForm.Size = New-Object System.Drawing.Size(580, 380)
    $statForm.StartPosition = "CenterScreen"
    $statForm.BackColor = Get-WindowBgColor
    $statForm.FormBorderStyle = "FixedDialog"
    $statForm.MaximizeBox = $false
    $statForm.Icon = $global:notifyIcon.Icon

    $isLight      = ($global:Theme -eq "Light")
    $cardBgCol    = if ($isLight) { [System.Drawing.Color]::FromArgb(236, 231, 220) } else { [System.Drawing.Color]::FromArgb(12, 17, 24) }
    $colorBitcoin = Get-AccentOrangeColor
    $colorGold    = if ($isLight) { [System.Drawing.Color]::FromArgb(185, 95, 0) } else { [System.Drawing.Color]::Gold }
    $colorUsd     = if ($isLight) { [System.Drawing.Color]::FromArgb(18, 120, 52) } else { [System.Drawing.Color]::LimeGreen }
    $colorSubInfo = Get-SecondaryTextColor

    # --- PAINEL ESQUERDO (X=20, Y=14, W=252, H=130): Premio do Bloco e Contagem em Blocos ---
    $lblPrizeHdr = New-Object System.Windows.Forms.Label
    $lblPrizeHdr.Text = "$($global:BtcSym) $(Get-Text 'TtfPrizeHeader')"
    $lblPrizeHdr.Location = New-Object System.Drawing.Point(21, 18)
    $lblPrizeHdr.Size = New-Object System.Drawing.Size(250, 22)
    $lblPrizeHdr.AutoSize = $false
    $lblPrizeHdr.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $lblPrizeHdr.BackColor = $cardBgCol
    $lblPrizeHdr.ForeColor = $colorBitcoin
    $lblPrizeHdr.Font = New-Object System.Drawing.Font("Segoe UI", 11.5, [System.Drawing.FontStyle]::Bold)

    $lblPrizeBtc = New-Object System.Windows.Forms.Label
    $lblPrizeBtc.Text = Get-Text "TtfPrizeBtc"
    $lblPrizeBtc.Location = New-Object System.Drawing.Point(21, 41)
    $lblPrizeBtc.Size = New-Object System.Drawing.Size(250, 28)
    $lblPrizeBtc.AutoSize = $false
    $lblPrizeBtc.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $lblPrizeBtc.BackColor = $cardBgCol
    $lblPrizeBtc.ForeColor = $colorGold
    $lblPrizeBtc.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)

    $prizeUsdText = Get-Text "TtfPrizeUsdWait"
    if ($global:LastBtcUsdValue -gt 0) {
        $totalPrizeUsd = 3.125 * $global:LastBtcUsdValue
        $culture = [System.Globalization.CultureInfo]::InvariantCulture
        $prizeUsdText = "$(Get-Text 'TtfPrizeUsdPref')$($totalPrizeUsd.ToString('N2', $culture))"
    }

    $lblPrizeUsd = New-Object System.Windows.Forms.Label
    $lblPrizeUsd.Text = $prizeUsdText
    $lblPrizeUsd.Location = New-Object System.Drawing.Point(21, 71)
    $lblPrizeUsd.Size = New-Object System.Drawing.Size(250, 21)
    $lblPrizeUsd.AutoSize = $false
    $lblPrizeUsd.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $lblPrizeUsd.BackColor = $cardBgCol
    $lblPrizeUsd.ForeColor = $colorUsd
    $lblPrizeUsd.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)

    $lblDrawInfo = New-Object System.Windows.Forms.Label
    $lblDrawInfo.Text = Get-Text "TtfDrawInfo"
    $lblDrawInfo.Location = New-Object System.Drawing.Point(21, 95)
    $lblDrawInfo.Size = New-Object System.Drawing.Size(250, 19)
    $lblDrawInfo.AutoSize = $false
    $lblDrawInfo.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $lblDrawInfo.BackColor = $cardBgCol
    $lblDrawInfo.ForeColor = $colorSubInfo
    $lblDrawInfo.Font = New-Object System.Drawing.Font("Segoe UI", 9.5, [System.Drawing.FontStyle]::Regular)

    $remBlocks = Get-RemainingHalvingBlocks
    $numCulture = if ($global:Language -eq "EN") {
        [System.Globalization.CultureInfo]::InvariantCulture
    } else {
        [System.Globalization.CultureInfo]::GetCultureInfo("pt-BR")
    }
    $remBlocksStr = $remBlocks.ToString("N0", $numCulture)

    $lblHalving = New-Object System.Windows.Forms.Label
    $lblHalving.Text = "$(Get-Text 'TtfHalving1')$remBlocksStr$(Get-Text 'TtfHalving2')"
    $lblHalving.Location = New-Object System.Drawing.Point(21, 115)
    $lblHalving.Size = New-Object System.Drawing.Size(250, 20)
    $lblHalving.AutoSize = $false
    $lblHalving.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $lblHalving.BackColor = $cardBgCol
    $lblHalving.ForeColor = $colorSubInfo
    $lblHalving.Font = New-Object System.Drawing.Font("Segoe UI", 9.5, [System.Drawing.FontStyle]::Bold)

    # --- PAINEL DIREITO (X=288, Y=14, W=252, H=130): Calculo da Sorte / TTF ---
    $lblAvgHdr = New-Object System.Windows.Forms.Label
    $lblAvgHdr.Text = "$($global:BoltSym) $(Get-Text 'TtfAvgHeader')"
    $lblAvgHdr.Location = New-Object System.Drawing.Point(289, 18)
    $lblAvgHdr.Size = New-Object System.Drawing.Size(250, 22)
    $lblAvgHdr.AutoSize = $false
    $lblAvgHdr.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $lblAvgHdr.BackColor = $cardBgCol
    $lblAvgHdr.ForeColor = $colorBitcoin
    $lblAvgHdr.Font = New-Object System.Drawing.Font("Segoe UI", 11.5, [System.Drawing.FontStyle]::Bold)

    $lblAvgSub = New-Object System.Windows.Forms.Label
    $lblAvgSub.Text = Get-Text "TtfAvgSub"
    $lblAvgSub.Location = New-Object System.Drawing.Point(289, 40)
    $lblAvgSub.Size = New-Object System.Drawing.Size(250, 18)
    $lblAvgSub.AutoSize = $false
    $lblAvgSub.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $lblAvgSub.BackColor = $cardBgCol
    $lblAvgSub.ForeColor = $colorSubInfo
    $lblAvgSub.Font = New-Object System.Drawing.Font("Segoe UI", 9.5, [System.Drawing.FontStyle]::Regular)

    $lblAvgVal = New-Object System.Windows.Forms.Label
    $lblAvgVal.Text = $avgStr
    $lblAvgVal.Location = New-Object System.Drawing.Point(289, 62)
    $lblAvgVal.Size = New-Object System.Drawing.Size(250, 30)
    $lblAvgVal.AutoSize = $false
    $lblAvgVal.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $lblAvgVal.BackColor = $cardBgCol
    $lblAvgVal.ForeColor = $colorGold
    $lblAvgVal.Font = New-Object System.Drawing.Font("Segoe UI", 15.5, [System.Drawing.FontStyle]::Bold)

    $lblCount = New-Object System.Windows.Forms.Label
    $lblCount.Text = "$(Get-Text 'TtfCountLbl') $count"
    $lblCount.Location = New-Object System.Drawing.Point(289, 107)
    $lblCount.Size = New-Object System.Drawing.Size(250, 24)
    $lblCount.AutoSize = $false
    $lblCount.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $lblCount.BackColor = $cardBgCol
    $lblCount.ForeColor = $colorBitcoin
    $lblCount.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)

    # --- PARTE INFERIOR CENTRALIZADA: Melhor Aproximacao (Recorde de Sorte) ---
    $lblBestTitle = New-Object System.Windows.Forms.Label
    $lblBestTitle.Text = "$($global:StarSym) $(Get-Text 'TtfBestLbl')"
    $lblBestTitle.Location = New-Object System.Drawing.Point(20, 153)
    $lblBestTitle.Size = New-Object System.Drawing.Size(520, 24)
    $lblBestTitle.AutoSize = $false
    $lblBestTitle.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $lblBestTitle.ForeColor = $colorBitcoin
    $lblBestTitle.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)

    $txtBest = New-Object System.Windows.Forms.RichTextBox
    $txtBest.Multiline = $true
    $txtBest.BorderStyle = "None"
    $txtBest.Location = New-Object System.Drawing.Point(21, 184)
    $txtBest.Size = New-Object System.Drawing.Size(518, 74)
    $txtBest.ReadOnly = $true
    $txtBest.ScrollBars = "None"
    $txtBest.BackColor = [System.Drawing.Color]::FromArgb(9, 13, 18)
    $txtBest.ForeColor = [System.Drawing.Color]::Gold
    $fontRegular = New-Object System.Drawing.Font("Consolas", 13, [System.Drawing.FontStyle]::Regular)
    $fontBold    = New-Object System.Drawing.Font("Consolas", 13, [System.Drawing.FontStyle]::Bold)
    $fontNoData  = New-Object System.Drawing.Font("Consolas", 11, [System.Drawing.FontStyle]::Regular)
    $txtBest.Font = $fontRegular

    $statForm.Add_Paint({
        param($s, $e)
        $cBg = if ($global:Theme -eq "Light") { [System.Drawing.Color]::FromArgb(236, 231, 220) } else { [System.Drawing.Color]::FromArgb(12, 17, 24) }
        $bCard   = New-Object System.Drawing.SolidBrush($cBg)
        $bVisor  = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(9, 13, 18))
        $pBronze = New-Object System.Drawing.Pen($global:ColorBronzeBorder, 1)

        # Card Esquerdo (Premio) e Card Direito (Sorte)
        $e.Graphics.FillRectangle($bCard, 20, 14, 252, 130)
        $e.Graphics.DrawRectangle($pBronze, 20, 14, 251, 129)
        $e.Graphics.FillRectangle($bCard, 288, 14, 252, 130)
        $e.Graphics.DrawRectangle($pBronze, 288, 14, 251, 129)
        $e.Graphics.DrawLine($pBronze, 310, 100, 518, 100)

        # Visor Inferior (Melhor Aproximacao)
        $e.Graphics.FillRectangle($bVisor, 20, 183, 520, 76)
        $e.Graphics.DrawRectangle($pBronze, 20, 183, 519, 75)

        $bCard.Dispose()
        $bVisor.Dispose()
        $pBronze.Dispose()
    })

    $nl = [Environment]::NewLine
    if (-not $hasData) {
        $txtBest.SelectionFont = $fontNoData
        $txtBest.AppendText((Get-Text "TtfNoDataBox1") + $nl + $nl + (Get-Text "TtfNoDataBox2"))
    } elseif ($isParsed) {
        $txtBest.SelectionFont = $fontRegular
        $txtBest.AppendText("$(Get-Text 'TtfDate') $bDate" + $nl + "$(Get-Text 'TtfLuck') ")
        $txtBest.SelectionFont = $fontBold
        $txtBest.AppendText($bTtf)
        $txtBest.SelectionFont = $fontRegular
        $txtBest.AppendText($nl + "$(Get-Text 'TtfPower') $bHash ($bThr Threads)")
    } else {
        $txtBest.Text = $bestLine
    }
    $txtBest.SelectAll()
    $txtBest.SelectionAlignment = [System.Windows.Forms.HorizontalAlignment]::Center
    $txtBest.SelectionLength = 0
    $txtBest.SelectionStart = 0
    $txtBest.ScrollToCaret()

    $btnSave = New-Object System.Windows.Forms.Button
    $btnSave.Text = Get-Text "BtnSaveImg"
    $btnSave.Location = New-Object System.Drawing.Point(20, 280)
    $btnSave.Size = New-Object System.Drawing.Size(140, 40)
    $btnSave.Font = New-Object System.Drawing.Font("Segoe UI", 10)
    Set-ObsidianButtonStyle $btnSave $false

    $btnReset = New-Object System.Windows.Forms.Button
    $btnReset.Text = Get-Text "BtnResetTtf"
    $btnReset.Location = New-Object System.Drawing.Point(210, 280)
    $btnReset.Size = New-Object System.Drawing.Size(140, 40)
    $btnReset.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    Set-ObsidianButtonStyle $btnReset $true
    $btnReset.Add_Click({
        $ans = [System.Windows.Forms.MessageBox]::Show((Get-Text "TtfResetConfirm"), "$($global:ShortVersion)", [System.Windows.Forms.MessageBoxButtons]::OKCancel, [System.Windows.Forms.MessageBoxIcon]::Warning)
        if ($ans -eq [System.Windows.Forms.DialogResult]::OK) {
            Remove-Item -LiteralPath $global:TtfLogFile -Force -ErrorAction SilentlyContinue
            Remove-Item -LiteralPath $global:BackupTtfLogFile -Force -ErrorAction SilentlyContinue
            Remove-Item -LiteralPath $global:LegacyTtfLogFile -Force -ErrorAction SilentlyContinue
            $global:LastTtfLogged = ""
            $global:LogQueue.Enqueue("[SISTEMA] Historico de estatisticas TTF zerado pelo usuario.")
            $statForm.Close()
        }
    })

    $btnClose = New-Object System.Windows.Forms.Button
    $btnClose.Text = Get-Text "BtnClose"
    $btnClose.Location = New-Object System.Drawing.Point(400, 280)
    $btnClose.Size = New-Object System.Drawing.Size(140, 40)
    $btnClose.Font = New-Object System.Drawing.Font("Segoe UI", 10)
    Set-ObsidianButtonStyle $btnClose $false
    $btnClose.Add_Click({ $statForm.Close() })

    $btnSave.Add_Click({
        $bmp = Copy-WindowScreenImage $statForm $btnClose
        $sfd = New-Object System.Windows.Forms.SaveFileDialog
        $sfd.Filter = "PNG Image|*.png"
        $sfd.FileName = "MinerIsma_Stats_$(Get-Date -Format 'yyyyMMdd_HHmmss').png"
        if (($sfd.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) -and ($null -ne $bmp)) {
            $bmp.Save($sfd.FileName, [System.Drawing.Imaging.ImageFormat]::Png)
        }
        if ($null -ne $bmp) { $bmp.Dispose() }
    })

    $statForm.Controls.Add($lblPrizeHdr)
    $statForm.Controls.Add($lblPrizeBtc)
    $statForm.Controls.Add($lblPrizeUsd)
    $statForm.Controls.Add($lblDrawInfo)
    $statForm.Controls.Add($lblHalving)
    $statForm.Controls.Add($lblAvgHdr)
    $statForm.Controls.Add($lblAvgSub)
    $statForm.Controls.Add($lblAvgVal)
    $statForm.Controls.Add($lblCount)
    $statForm.Controls.Add($lblBestTitle)
    $statForm.Controls.Add($txtBest)
    $statForm.Controls.Add($btnSave)
    $statForm.Controls.Add($btnReset)
    $statForm.Controls.Add($btnClose)

    $statForm.Add_Shown({
        Set-WindowDarkTheme $statForm
        $btnClose.Focus() | Out-Null
    })

    $statForm.ShowDialog() | Out-Null
    $statForm.Dispose()
}

# ============================================================
# ALERTA DE BLOCO (DESIGN V2.0)
# ============================================================
function Invoke-BlockAlert {
    param([string]$bLine)

    $time = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    $blockHeight = $null
    foreach ($l in @($global:RecentLines)) {
        if ($l -match "Block\s+(\d+)") { $blockHeight = $Matches[1] }
    }

    $nl = [Environment]::NewLine
    $ctx = @($global:RecentLines) -join $nl
    $logText  = "[$time] ===== BLOCO ENCONTRADO =====" + $nl
    if ($blockHeight) { $logText += "Bloco (altura): $blockHeight" + $nl }
    $logText += "Threads em uso: $($global:CurrentThreads)" + $nl + "Linha do evento: $bLine" + $nl
    $logText += "--- Contexto ---" + $nl + $ctx + $nl
    $logText | Out-File -FilePath $global:LogFile -Append -Encoding utf8

    $global:SoundFile = Join-Path $global:ResPath $global:SoundFileName
    if (Test-Path $global:SoundFile) {
        try {
            if ($null -ne $global:SoundPlayer) { $global:SoundPlayer.Stop(); $global:SoundPlayer.Close() }
            $global:SoundPlayer = New-Object System.Windows.Media.MediaPlayer
            $global:SoundPlayer.Open([Uri]$global:SoundFile)
            $global:SoundPlayer.Play()
        } catch {}
    }

    if (-not $global:Visible) { Toggle-LogWindow }

    $alertForm = New-Object System.Windows.Forms.Form
    $alertForm.Text = "MINERISMA v2.0 - $(Get-Text 'AlertWinTitle')"
    $alertForm.Size = New-Object System.Drawing.Size(580, 380)
    $alertForm.StartPosition = "CenterScreen"
    $alertForm.BackColor = Get-WindowBgColor
    $alertForm.FormBorderStyle = "FixedDialog"
    $alertForm.MaximizeBox = $false
    $alertForm.Icon = $global:notifyIcon.Icon

    $colorBitcoin = Get-AccentOrangeColor
    $txtPrimary   = Get-PrimaryTextColor

    $lblTitle = New-Object System.Windows.Forms.Label
    $lblTitle.Text = Get-Text "AlertHeader"
    $lblTitle.Location = New-Object System.Drawing.Point(110, 20)
    $lblTitle.AutoSize = $true
    $lblTitle.ForeColor = $colorBitcoin
    $lblTitle.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)

    $lblInfo = New-Object System.Windows.Forms.Label
    $cleanWallet = $global:Wallet -replace '\..*?$', ''
    $q = [char]34
    $infoText = ""
    if ($blockHeight) { $infoText += "$(Get-Text 'AlertBlockHeight') $blockHeight" + $nl }
    $infoText += "$(Get-Text 'AlertCheckWallet') " + $q + $cleanWallet + $q + $nl
    $infoText += "$(Get-Text 'AlertRewardInfo')" + $nl
    $infoText += "$(Get-Text 'AlertLogInfo') " + $q + "BLOCK_FOUND_LOG.txt" + $q + " $(Get-Text 'AlertInFolder')"
    $lblInfo.Text = $infoText
    $lblInfo.Location = New-Object System.Drawing.Point(20, 62)
    $lblInfo.AutoSize = $true
    $lblInfo.ForeColor = $txtPrimary
    $lblInfo.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Regular)

    $txtDetails = New-Object System.Windows.Forms.TextBox
    $txtDetails.Text = $bLine
    $txtDetails.Multiline = $true
    $txtDetails.BorderStyle = "None"
    $txtDetails.Location = New-Object System.Drawing.Point(25, 175)
    $txtDetails.Size = New-Object System.Drawing.Size(510, 65)
    $txtDetails.ReadOnly = $true
    $txtDetails.BackColor = [System.Drawing.Color]::FromArgb(9, 13, 18)
    $txtDetails.ForeColor = [System.Drawing.Color]::LimeGreen
    $txtDetails.Font = New-Object System.Drawing.Font("Consolas", 11)

    $alertForm.Add_Paint({
        param($s, $e)
        $bFill = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(9, 13, 18))
        $pBronze = New-Object System.Drawing.Pen($global:ColorBronzeBorder, 1)
        $e.Graphics.FillRectangle($bFill, 20, 170, 520, 75)
        $e.Graphics.DrawRectangle($pBronze, 20, 170, 519, 74)
        $bFill.Dispose()
        $pBronze.Dispose()
    })

    $btnSave = New-Object System.Windows.Forms.Button
    $btnSave.Text = Get-Text "BtnSaveImg"
    $btnSave.Location = New-Object System.Drawing.Point(20, 275)
    $btnSave.Size = New-Object System.Drawing.Size(140, 40)
    $btnSave.Font = New-Object System.Drawing.Font("Segoe UI", 10)
    Set-ObsidianButtonStyle $btnSave $false

    $btnClose = New-Object System.Windows.Forms.Button
    $btnClose.Text = Get-Text "BtnCelebrate"
    $btnClose.Location = New-Object System.Drawing.Point(400, 275)
    $btnClose.Size = New-Object System.Drawing.Size(140, 40)
    $btnClose.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    Set-ObsidianButtonStyle $btnClose $false
    $btnClose.Add_Click({ if ($null -ne $global:SoundPlayer) { $global:SoundPlayer.Stop() }; $alertForm.Close() })

    $btnSave.Add_Click({
        $bmp = Copy-WindowScreenImage $alertForm $btnClose
        $sfd = New-Object System.Windows.Forms.SaveFileDialog
        $sfd.Filter = "PNG Image|*.png"
        $sfd.FileName = "MinerIsma_Bloco_$(Get-Date -Format 'yyyyMMdd_HHmmss').png"
        if (($sfd.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) -and ($null -ne $bmp)) {
            $bmp.Save($sfd.FileName, [System.Drawing.Imaging.ImageFormat]::Png)
        }
        if ($null -ne $bmp) { $bmp.Dispose() }
    })

    $alertForm.Add_FormClosing({
        if ($null -ne $global:SoundPlayer) { $global:SoundPlayer.Stop() }
    })

    $alertForm.Controls.Add($lblTitle)
    $alertForm.Controls.Add($lblInfo)
    $alertForm.Controls.Add($txtDetails)
    $alertForm.Controls.Add($btnSave)
    $alertForm.Controls.Add($btnClose)

    $alertForm.Add_Shown({
        Set-WindowDarkTheme $alertForm
        $btnClose.Focus() | Out-Null
    })

    $alertForm.ShowDialog() | Out-Null
    $alertForm.Dispose()
}

# ============================================================
# API NATIVA DO BITCOIN (COINGECKO) E ICONE DO TRAY
# ============================================================
function Update-BtcPrice {
    try {
        $url = $global:BtcPriceUrl + "&t=" + [DateTimeOffset]::Now.ToUnixTimeMilliseconds()
        $req = [System.Net.WebRequest]::Create($url)
        $req.Method = "GET"
        $req.Timeout = 3000
        $req.UserAgent = "MinerIsma/2.0.2"
        
        $res = $req.GetResponse()
        $stream = $res.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($stream)
        $jsonText = $reader.ReadToEnd()
        $reader.Close()
        $stream.Close()
        $res.Close()
        
        $json = $jsonText | ConvertFrom-Json
        if ($json.bitcoin.usd) {
            $price = [double]$json.bitcoin.usd
            $global:LastBtcUsdValue = $price
            $culture = [System.Globalization.CultureInfo]::InvariantCulture
            $global:LastBtcUsdFormatted = $price.ToString("N2", $culture)
            $global:btcPriceItem.Text = "$($global:BtcSym)$(Get-Text 'BtcNowPrefix')$($global:LastBtcUsdFormatted)"
        }
    } catch {}
}

function New-TrayIcon {
    $bmp = New-Object System.Drawing.Bitmap(32, 32)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.Clear([System.Drawing.Color]::Transparent)
    $colorOrange = [System.Drawing.Color]::FromArgb(255, 247, 147, 26)
    $brushOrange = New-Object System.Drawing.SolidBrush($colorOrange)
    $g.FillEllipse($brushOrange, 1, 1, 30, 30)

    $penWhite = New-Object System.Drawing.Pen([System.Drawing.Color]::White, 3)
    $penWhite.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $penWhite.EndCap   = [System.Drawing.Drawing2D.LineCap]::Round
    $g.DrawLine($penWhite, 8, 24, 22, 10)
    $g.DrawLine($penWhite, 16, 6, 26, 16)
    $brushOrange.Dispose()
    $penWhite.Dispose()
    $g.Dispose()
    return [System.Drawing.Icon]::FromHandle($bmp.GetHicon())
}

$global:notifyIcon = New-Object System.Windows.Forms.NotifyIcon
$global:notifyIcon.Icon = New-TrayIcon
$global:notifyIcon.Text = "$($global:ShortVersion)" + [Environment]::NewLine + (Get-Text "TrayWaitStart")
$global:notifyIcon.Visible = $true

$global:logForm = New-Object System.Windows.Forms.Form
$global:logForm.Text = "$($global:ShortVersion) - Console"
$global:logForm.Size = New-Object System.Drawing.Size(900, 520)
$global:logForm.StartPosition = "CenterScreen"
$global:logForm.ShowInTaskbar = $false
$global:logForm.BackColor = Get-WindowBgColor
$global:logForm.Icon = $global:notifyIcon.Icon

# Painel que oculta os 17px da barra branca nativa do RichTextBox e exibe a ObsidianVScrollBar em Bronze/Obsidiana
$global:logHostPanel = New-Object System.Windows.Forms.Panel
$global:logHostPanel.Dock = "Fill"
$global:logHostPanel.BackColor = [System.Drawing.Color]::FromArgb(9, 13, 18)

$global:logScrollBar = New-Object ObsidianVScrollBar
$global:logScrollBar.Dock = "Right"
$global:logScrollBar.IsLightMode = ($global:Theme -eq "Light")

$global:logBox = New-Object System.Windows.Forms.RichTextBox
$global:logBox.ReadOnly = $true
$global:logBox.ScrollBars = [System.Windows.Forms.RichTextBoxScrollBars]::ForcedVertical
$global:logBox.BackColor = [System.Drawing.Color]::FromArgb(9, 13, 18)
$global:logBox.ForeColor = [System.Drawing.Color]::DarkGray
$global:logBox.Font = New-Object System.Drawing.Font("Consolas", 10)
$global:logBox.BorderStyle = "None"

$global:logScrollBar.TargetBox = $global:logBox
$global:logBox.Add_VScroll({ $global:logScrollBar.Invalidate() })
$global:logBox.Add_TextChanged({ $global:logScrollBar.Invalidate() })

$global:logHostPanel.Add_Resize({
    $sbW = [System.Windows.Forms.SystemInformation]::VerticalScrollBarWidth
    $global:logBox.SetBounds(0, 0, ($global:logHostPanel.ClientSize.Width + $sbW), $global:logHostPanel.ClientSize.Height)
    $global:logScrollBar.Invalidate()
})

$global:logHostPanel.Controls.Add($global:logBox)
$global:logForm.Controls.Add($global:logHostPanel)
$global:logForm.Controls.Add($global:logScrollBar)

$sbInitW = [System.Windows.Forms.SystemInformation]::VerticalScrollBarWidth
$global:logBox.SetBounds(0, 0, ($global:logHostPanel.ClientSize.Width + $sbInitW), $global:logHostPanel.ClientSize.Height)
Set-WindowDarkTheme $global:logForm

$global:logForm.Add_FormClosing({
    param($s, $e)
    if ($e.CloseReason -eq [System.Windows.Forms.CloseReason]::UserClosing) {
        $e.Cancel = $true
        $global:logForm.Hide()
        $global:Visible = $false
    }
})

function Toggle-LogWindow {
    if ($global:Visible) {
        $global:Visible = $false
        $global:logForm.Hide()
    } else {
        $global:Visible = $true
        $global:logForm.Show()
        Set-WindowDarkTheme $global:logForm
        if ($global:logForm.WindowState -eq "Minimized") { $global:logForm.WindowState = "Normal" }
        $global:logBox.SelectionStart = $global:logBox.TextLength
        $global:logBox.ScrollToCaret()
        $global:logScrollBar.Invalidate()
        $global:logForm.Activate()
    }
}

# ============================================================
# FUNCOES DE PAUSA / RETOMADA, MODO PULSAR E MOTOR DO MINERADOR
# ============================================================
function Suspend-MinerProcess {
    if (-not $global:CurrentProc -or $global:CurrentProc.HasExited) { return }
    $global:CurrentProc.Refresh()
    foreach ($t in $global:CurrentProc.Threads) {
        $h = [ProcCtl]::OpenThread(0x0002, $false, [uint32]$t.Id)
        if ($h -ne [IntPtr]::Zero) {
            [ProcCtl]::SuspendThread($h) | Out-Null
            [ProcCtl]::CloseHandle($h) | Out-Null
        }
    }
}

function Resume-MinerProcess {
    if (-not $global:CurrentProc -or $global:CurrentProc.HasExited) { return }
    $global:CurrentProc.Refresh()
    foreach ($t in $global:CurrentProc.Threads) {
        $h = [ProcCtl]::OpenThread(0x0002, $false, [uint32]$t.Id)
        if ($h -ne [IntPtr]::Zero) {
            [ProcCtl]::ResumeThread($h) | Out-Null
            [ProcCtl]::CloseHandle($h) | Out-Null
        }
    }
}

function Disable-PulseMode {
    param([bool]$Silent = $false)
    if ($global:PulseMode -ne "") {
        $oldMode = $global:PulseMode
        $global:PulseMode       = ""
        $global:PulseActiveMins = 0
        $global:PulsePauseMins  = 0
        $global:PulseNextSwitch = $null
        Save-MinerConfig
        if ($null -ne $global:itemPulse1) { $global:itemPulse1.Checked = $false }
        if ($null -ne $global:itemPulse2) { $global:itemPulse2.Checked = $false }
        if (-not $Silent) {
            $global:LogQueue.Enqueue("[SISTEMA] Modo Pulsar ($oldMode): DESATIVADO.")
        }
    }
}

function Set-PulseMode {
    param([string]$ModeName, [int]$ActiveMins, [int]$PauseMins)
    if ($global:PulseMode -eq $ModeName) {
        Disable-PulseMode $false
        if ($global:IsPaused) {
            Invoke-ResumeMining $false
        }
        return
    }

    $global:PulseMode       = $ModeName
    $global:PulseActiveMins = $ActiveMins
    $global:PulsePauseMins  = $PauseMins
    Save-MinerConfig

    if ($global:IsPaused) {
        Resume-MinerProcess
        $global:IsPaused = $false
        $global:PauseResumeAt = $null
        $global:itemPause.Text = Get-Text "MenuPause"
        $global:TtfLogAllowedAt = (Get-Date).AddSeconds($global:TtfWarmupSeconds)
    }

    if ($null -ne $global:itemPulse1) { $global:itemPulse1.Checked = ($global:PulseMode -eq "2hx5") }
    if ($null -ne $global:itemPulse2) { $global:itemPulse2.Checked = ($global:PulseMode -eq "4hx5") }

    $global:PulseNextSwitch = (Get-Date).AddMinutes($ActiveMins)
    $nextPauseStr = $global:PulseNextSwitch.ToString("HH:mm")
    $global:notifyIcon.Text = "$($global:ShortVersion)" + [Environment]::NewLine + "$($global:CurrentThreads) Threads | Pulsar $ModeName"
    $global:LogQueue.Enqueue("[SISTEMA] Modo Pulsar ($ModeName) ATIVADO: $($ActiveMins)m ativo x $($PauseMins)m pausa (proxima pausa as $nextPauseStr).")
}

function Set-MinerPause {
    param([int]$Minutes = 0)
    # Mantem o Modo Pulsar salvo/selecionado em espera durante qualquer pausa manual ou temporizada
    if ($global:PulseMode -ne "") {
        $global:PulseNextSwitch = $null
    }
    if (-not $global:IsPaused) {
        Suspend-MinerProcess
        $global:IsPaused = $true
    }
    $global:itemPause.Text = Get-Text "MenuResume"
    if ($Minutes -gt 0) {
        $global:PauseResumeAt = (Get-Date).AddMinutes($Minutes)
        $resumeStr = $global:PauseResumeAt.ToString("HH:mm")
        $global:notifyIcon.Text = "$($global:ShortVersion)" + [Environment]::NewLine + "$($global:CurrentThreads) Threads | $(Get-Text 'TrayPausedUntil') $resumeStr)"
        $global:LogQueue.Enqueue("[SISTEMA] Mineracao PAUSADA por $Minutes min (retoma as $resumeStr).")
    } else {
        $global:PauseResumeAt = $null
        $global:notifyIcon.Text = "$($global:ShortVersion)" + [Environment]::NewLine + "$($global:CurrentThreads) Threads | $(Get-Text 'TrayPaused')"
        $global:LogQueue.Enqueue("[SISTEMA] Mineracao PAUSADA manualmente. Threads suspensas.")
    }
}

function Invoke-ResumeMining {
    param([bool]$Auto = $false)
    if (-not $global:IsPaused) { return }
    Resume-MinerProcess
    $global:IsPaused = $false
    $global:PauseResumeAt = $null
    $global:TtfLogAllowedAt = (Get-Date).AddSeconds($global:TtfWarmupSeconds)
    $global:itemPause.Text = Get-Text "MenuPause"
    $global:notifyIcon.Text = "$($global:ShortVersion)" + [Environment]::NewLine + "$($global:CurrentThreads) Threads | $(Get-Text 'TrayResuming')"
    if ($global:PulseMode -ne "") {
        $global:PulseNextSwitch = (Get-Date).AddMinutes($global:PulseActiveMins)
        $nextPauseStr = $global:PulseNextSwitch.ToString("HH:mm")
        $global:LogQueue.Enqueue("[SISTEMA] Modo Pulsar ($($global:PulseMode)): Mineracao RETOMADA por $($global:PulseActiveMins) min (proxima pausa as $nextPauseStr).")
    } elseif ($Auto) {
        $global:LogQueue.Enqueue("[SISTEMA] Tempo de pausa concluido. Mineracao RETOMADA automaticamente.")
    } else {
        $global:LogQueue.Enqueue("[SISTEMA] Mineracao RETOMADA.")
    }
}

function Start-MinerTask {
    param([int]$Threads)

    # --- Previne partida sem carteira configurada e abre janela de configuracao ---
    if (-not (Test-WalletConfigured)) {
        $global:notifyIcon.Text = "$($global:ShortVersion)" + [Environment]::NewLine + (Get-Text "TrayWaitWallet")
        if (-not ($global:WalletWarningShown)) {
            $global:WalletWarningShown = $true
            $global:LogQueue.Enqueue("[SISTEMA] AVISO: Carteira nao detectada. Configure seu endereco Bitcoin.")
            Show-WalletConfig
        }
        return
    }

    if (($global:CurrentProc) -and (-not ($global:CurrentProc.HasExited))) {
        $global:StopRequested = $true
        $global:CurrentProc.Kill()
        Start-Sleep -Milliseconds 500
    }
    
    Get-Process -Name "cpuminer*" -ErrorAction SilentlyContinue | Stop-Process -Force

    if (-not (Test-Path $global:MinerExe)) {
        $global:LogQueue.Enqueue("[SISTEMA] ERRO: miner nao encontrado: $($global:MinerExe)")
        Write-ErrorLog "Minerador nao encontrado em $($global:BasePath)"
        return
    }

    $global:CurrentThreads = $Threads
    $Affinity = Get-Affinity $Threads
    
    if ([string]::IsNullOrWhiteSpace($Affinity)) {
        $chaves = ($global:ThreadProfiles.Keys | ForEach-Object { [string]$_ }) -join ", "
        $msg = "Perfil de $Threads threads nao existe. Configurados: $chaves"
        $global:LogQueue.Enqueue("[SISTEMA] ERRO: $msg")
        Write-ErrorLog $msg
        try { $global:notifyIcon.ShowBalloonTip(8000, "$($global:ShortVersion) - Erro", $msg, [System.Windows.Forms.ToolTipIcon]::Error) } catch {}
        return
    }

    $AffinityPart = "--cpu-affinity $Affinity"
    $ArgList = "-a sha256d -o $($global:PoolUrl) -u $($global:Wallet) -p x -t $Threads $AffinityPart $($global:ExtraArgs)".Trim() -replace '\s+',' '

    try {
        $StartInfo = New-Object System.Diagnostics.ProcessStartInfo
        $StartInfo.FileName = $global:MinerExe
        $StartInfo.Arguments = $ArgList
        $StartInfo.WorkingDirectory = $global:BasePath
        $StartInfo.UseShellExecute = $false
        $StartInfo.RedirectStandardOutput = $true
        $StartInfo.RedirectStandardError = $true
        $StartInfo.CreateNoWindow = $true

        $global:CurrentProc = New-Object System.Diagnostics.Process
        $global:CurrentProc.StartInfo = $StartInfo

        Get-EventSubscriber | Where-Object SourceIdentifier -match "MinerOut|MinerErr" | Unregister-Event -ErrorAction SilentlyContinue
        Get-Event | Where-Object SourceIdentifier -match "MinerOut|MinerErr" | Remove-Event -ErrorAction SilentlyContinue

        Register-ObjectEvent -InputObject $global:CurrentProc -EventName OutputDataReceived -SourceIdentifier "MinerOut" | Out-Null
        Register-ObjectEvent -InputObject $global:CurrentProc -EventName ErrorDataReceived -SourceIdentifier "MinerErr" | Out-Null

        $global:CurrentProc.Start() | Out-Null
        $global:CurrentProc.BeginOutputReadLine()
        $global:CurrentProc.BeginErrorReadLine()

        $global:StopRequested   = $false
        $global:CrashNotified   = $false
        $global:TtfLogAllowedAt = (Get-Date).AddSeconds($global:TtfWarmupSeconds)
        $global:LogQueue.Enqueue("[SISTEMA] Comando: $($global:DetectedMinerExe) $ArgList")
        $global:LogQueue.Enqueue("[SISTEMA] $($global:AppVersion) iniciado com $Threads Threads (Afinidade $Affinity)")
        if ($global:PulseMode -ne "") {
            $global:PulseNextSwitch = (Get-Date).AddMinutes($global:PulseActiveMins)
            $nextPauseStr = $global:PulseNextSwitch.ToString("HH:mm")
            $global:LogQueue.Enqueue("[SISTEMA] Modo Pulsar ($($global:PulseMode)) ativo na memoria (proxima pausa as $nextPauseStr).")
        }
        $global:LogQueue.Enqueue("[SISTEMA] Para opcoes, clique com o botao Direito no icone do Tray")
    }
    catch {
        $global:LogQueue.Enqueue("[SISTEMA] ERRO ao iniciar o miner: $($_.Exception.Message)")
        Write-ErrorLog "Falha ao iniciar miner: $($_.Exception.Message)"
    }
}

# ============================================================
# MENUS DO TRAY E SUBMENUS (V2.0.2 - Alpha)
# ============================================================
$menu = New-Object System.Windows.Forms.ContextMenuStrip

$global:notifyIcon.Add_MouseClick({
    param($s, $e)
    if ($e.Button -eq [System.Windows.Forms.MouseButtons]::Left) { Toggle-LogWindow }
})

# 1. Cabecalho Laranja como ToolStripMenuItem Nativo (com Submenu de Idioma e Setinha Lateral)
$headerItem = New-Object System.Windows.Forms.ToolStripMenuItem("  $($global:ShortVersion)                        ")
$headerItem.Name = "HeaderItem"
$headerItem.Padding = New-Object System.Windows.Forms.Padding(0, 4, 0, 4)
$headerItem.ForeColor = [System.Drawing.Color]::FromArgb(255, 247, 147, 26)
$headerItem.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)

$langOptions = [ordered]@{
    "PT" = "Portugues"
    "EN" = "English"
    "ES" = "Espanol"
}
$langMenuItems = @{}
foreach ($entry in $langOptions.GetEnumerator()) {
    $lCode = [string]$entry.Key
    $lName = [string]$entry.Value
    $lItem = New-Object System.Windows.Forms.ToolStripMenuItem($lName)
    $lItem.Tag = $lCode
    $lItem.Add_Click({
        $chosenLang = [string]$this.Tag
        Set-AppLanguage $chosenLang
    })
    $headerItem.DropDownItems.Add($lItem) | Out-Null
    $langMenuItems[$lCode] = $lItem
}

$headerItem.Add_MouseDown({
    param($sender, $e)
    if ($e.Button -eq [System.Windows.Forms.MouseButtons]::Left) {
        if (($e.X -ge ($sender.Width - 74)) -and ($e.X -lt ($sender.Width - 44))) {
            $nextTheme = if ($global:Theme -eq "Light") { "Dark" } else { "Light" }
            Set-AppTheme $nextTheme
        }
        elseif ($e.X -ge ($sender.Width - 44)) {
            $sender.ShowDropDown()
        }
    }
})
$menu.Items.Add($headerItem) | Out-Null
$menu.Items.Add("-") | Out-Null

# 2. Bitcoin Agora (CoinGecko) com simbolo Unicode seguro
$global:btcPriceItem = New-Object System.Windows.Forms.ToolStripLabel("$($global:BtcSym)$(Get-Text 'BtcUpdating')")
$global:btcPriceItem.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
$menu.Items.Add($global:btcPriceItem) | Out-Null
$menu.Items.Add("-") | Out-Null

# 3A. Submenu Bitcoin Links
$global:itemLinksMenu = New-Object System.Windows.Forms.ToolStripMenuItem("$($global:BtcSym)$(Get-Text 'BtcLinks')")

$global:lnkPool = $global:itemLinksMenu.DropDownItems.Add((Get-Text "LinkPool"))
$global:lnkPool.Add_Click({
    $addr = $global:Wallet -replace '\..*?$', ''
    $url = $global:UrlPoolDashboard + $addr
    Start-Process $url
})

$global:lnkUpdates = $global:itemLinksMenu.DropDownItems.Add((Get-Text "LinkUpdates"))
$global:lnkUpdates.Add_Click({ Start-Process $global:UrlDriveUpdates })

$global:lnkMempool = $global:itemLinksMenu.DropDownItems.Add((Get-Text "LinkMempool"))
$global:lnkMempool.Add_Click({ Start-Process $global:UrlMempool })

$global:lnkTimeline = $global:itemLinksMenu.DropDownItems.Add((Get-Text "LinkTimeline"))
$global:lnkTimeline.Add_Click({ Start-Process $global:UrlTimeline })

$global:lnkMonitor = $global:itemLinksMenu.DropDownItems.Add((Get-Text "LinkMonitor"))
$global:lnkMonitor.Add_Click({ Start-Process $global:UrlMercadoCripto })

$global:lnkBlueWallet = $global:itemLinksMenu.DropDownItems.Add((Get-Text "LinkBlueWallet"))
$global:lnkBlueWallet.Add_Click({ Start-Process $global:UrlBlueWallet })

$global:lnkLearn = $global:itemLinksMenu.DropDownItems.Add((Get-Text "LinkLearn"))
$global:lnkLearn.Add_Click({ Start-Process $global:UrlAprendaCripto })

$global:lnkNews = $global:itemLinksMenu.DropDownItems.Add((Get-Text "LinkNews"))
$global:lnkNews.Add_Click({ Start-Process $global:UrlBitNoticias })

$global:lnkGlobalAcc = $global:itemLinksMenu.DropDownItems.Add((Get-Text "LinkGlobalAcc"))
$global:lnkGlobalAcc.Add_Click({ Start-Process $global:UrlCartaoCripto })

$global:lnkMissao1Btc = $global:itemLinksMenu.DropDownItems.Add((Get-Text "LinkMissao1Btc"))
$global:lnkMissao1Btc.Add_Click({ Start-Process $global:UrlMissao1Btc })

$global:lnkRetireBtc = $global:itemLinksMenu.DropDownItems.Add((Get-Text "LinkRetireBtc"))
$global:lnkRetireBtc.Add_Click({ Start-Process $global:UrlAposentadoriaBtc })

$global:lnkBtcMaps = $global:itemLinksMenu.DropDownItems.Add((Get-Text "LinkBtcMaps"))
$global:lnkBtcMaps.Add_Click({ Start-Process $global:UrlBitcoinMaps })

$global:lnkWeb = $global:itemLinksMenu.DropDownItems.Add((Get-Text "LinkWeb"))
$global:lnkWeb.Add_Click({
    if (-not [string]::IsNullOrWhiteSpace($global:UrlTutorial)) {
        Start-Process $global:UrlTutorial
    } else {
        [System.Windows.Forms.MessageBox]::Show((Get-Text "MsgWebSoon"), "$($global:ShortVersion) - Web", 0, 64) | Out-Null
    }
})

$global:lnkGpuMiner = $global:itemLinksMenu.DropDownItems.Add((Get-Text "LinkGpuMiner"))
$global:lnkGpuMiner.Add_Click({ Start-Process $global:UrlGpuMiner })

$global:lnkBubbles = $global:itemLinksMenu.DropDownItems.Add((Get-Text "LinkBubbles"))
$global:lnkBubbles.Add_Click({ Start-Process $global:UrlCryptoBubbles })

$menu.Items.Add($global:itemLinksMenu) | Out-Null

# 3B. Submenu Bitcoin Games (entre Bitcoin Links e Canais Cripto)
$global:itemGamesMenu = New-Object System.Windows.Forms.ToolStripMenuItem("$($global:BtcSym)itcoin Games")

$global:game21M = $global:itemGamesMenu.DropDownItems.Add("21 Million")
$global:game21M.Add_Click({ Open-GameWindow $global:UrlGame21Million })

$global:gamePuzzle1000 = $global:itemGamesMenu.DropDownItems.Add("Puzzle 1000 BTC $")
$global:gamePuzzle1000.Add_Click({ Start-Process $global:UrlGamePuzzle1000 })

$global:gameDesafios = $global:itemGamesMenu.DropDownItems.Add((Get-Text "GameDesafios"))
$global:gameDesafios.Add_Click({ Start-Process $global:UrlGameDesafios })

$global:gamePuzzle71 = $global:itemGamesMenu.DropDownItems.Add("Puzzle 71 $")
$global:gamePuzzle71.Add_Click({ Start-Process $global:UrlGamePuzzle71 })

$global:gameBoard = $global:itemGamesMenu.DropDownItems.Add((Get-Text "GameBoard"))
$global:gameBoard.Add_Click({ Start-Process $global:UrlGameToTheMoon })

$global:gameSunnyLand = $global:itemGamesMenu.DropDownItems.Add("Sunny Land")
$global:gameSunnyLand.Add_Click({ Open-GameWindow $global:UrlGameSunnyLand })

$menu.Items.Add($global:itemGamesMenu) | Out-Null

# 3C. Submenu Canais Cripto (14 canais do YouTube)
$global:itemChannelsMenu = New-Object System.Windows.Forms.ToolStripMenuItem((Get-Text "MenuChannels"))
foreach ($entry in $global:CryptoChannels.GetEnumerator()) {
    $chName = [string]$entry.Key
    $chUrl  = [string]$entry.Value
    $chItem = New-Object System.Windows.Forms.ToolStripMenuItem($chName)
    $chItem.Tag = $chUrl
    $chItem.Add_Click({ Start-Process ([string]$this.Tag) })
    $global:itemChannelsMenu.DropDownItems.Add($chItem) | Out-Null
}
$menu.Items.Add($global:itemChannelsMenu) | Out-Null
$menu.Items.Add("-") | Out-Null

# 4. Subtitulo "Power | CPU ..." e Controle Dinamico de Threads (com '!' em Laranja Bitcoin)
$global:lblPowerHeader = New-Object System.Windows.Forms.ToolStripLabel($global:PowerHeaderTitle)
$global:lblPowerHeader.Padding = New-Object System.Windows.Forms.Padding(22, 2, 0, 2)
$global:lblPowerHeader.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Regular)
$menu.Items.Add($global:lblPowerHeader) | Out-Null

function Set-ThreadConfig {
    param([int]$t)
    if ($global:IsPaused) {
        $global:itemPause.Text = Get-Text "MenuPause"
        $global:IsPaused = $false
        $global:PauseResumeAt = $null
    }
    if ($global:PulseMode -ne "") {
        $global:PulseNextSwitch = (Get-Date).AddMinutes($global:PulseActiveMins)
    }
    
    $global:CurrentThreads = $t
    Save-MinerConfig
    
    $global:notifyIcon.Text = "$($global:ShortVersion)" + [Environment]::NewLine + "$t Threads | $(Get-Text 'TrayCalculating')"
    Start-MinerTask $t
}

$threadItems = @{}
foreach ($entry in $global:ThreadProfiles.GetEnumerator()) {
    $n = [int]$entry.Key
    $label = [string]$global:ThreadLabels[$n]
    $item = New-Object System.Windows.Forms.ToolStripMenuItem($label)
    $item.Name = "ThreadItem"
    $item.Tag = $n
    $item.Add_Click({ Set-ThreadConfig ([int]$this.Tag) })
    $menu.Items.Add($item) | Out-Null
    $threadItems[$n] = $item
}
$menu.Items.Add("-") | Out-Null

# 5. Startup Automatica (Atalho + Contingencia Registro Run), Carteira, Teste, Estatisticas, Tutorial e Compartilhar
$global:itemStartup = New-Object System.Windows.Forms.ToolStripMenuItem((Get-Text "MenuStartup"))

$global:lblDelayHeader = New-Object System.Windows.Forms.ToolStripLabel((Get-Text "DelayHeader"))
$global:lblDelayHeader.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
$global:itemStartup.DropDownItems.Add($global:lblDelayHeader) | Out-Null
$global:itemStartup.DropDownItems.Add("-") | Out-Null

function Test-StartupRegistered {
    if (Test-Path -LiteralPath $global:ShortcutPath) { return $true }
    try {
        $regObj = Get-ItemProperty -Path $global:RunRegKey -Name $global:RunRegName -ErrorAction SilentlyContinue
        if (($null -ne $regObj) -and (-not [string]::IsNullOrWhiteSpace($regObj.$($global:RunRegName)))) {
            return $true
        }
    } catch {}
    return $false
}

$delayOptions = [ordered]@{
    5  = (Get-Text "DelayDefault")
    15 = "15seg."
    30 = "30seg."
    60 = "60seg."
}
$delayMenuItems = @{}

function Update-StartupMenuChecks {
    $isReg = (Test-StartupRegistered)
    $global:itemStartup.Checked = $isReg
    foreach ($dKey in $delayMenuItems.Keys) {
        $delayMenuItems[$dKey].Checked = ($isReg -and ($global:ConfiguredDelay -eq $dKey))
    }
}

function Enable-WindowsStartup {
    param([int]$DelaySec, [bool]$Silent = $false)

    $global:ConfiguredDelay    = $DelaySec
    $global:StartupInitialized = $true
    $global:StartupEnabled     = $true
    Save-MinerConfig

    if (-not (Test-Path -LiteralPath $global:LauncherPath)) {
        if (-not $Silent) {
            [System.Windows.Forms.MessageBox]::Show("O arquivo '$global:LauncherFileName' nao foi encontrado na pasta raiz.", "Erro", 0, 16) | Out-Null
        }
        Update-StartupMenuChecks
        return
    }

    $registeredOk = $false

    # Tentativa 1: Atalho .lnk na pasta Startup
    try {
        if (-not (Test-Path -LiteralPath $global:StartupFolder)) {
            New-Item -ItemType Directory -Path $global:StartupFolder -Force -ErrorAction SilentlyContinue | Out-Null
        }
        if (Test-Path -LiteralPath $global:ShortcutPath) {
            Remove-Item -LiteralPath $global:ShortcutPath -Force -ErrorAction SilentlyContinue
        }
        $WshShell = New-Object -ComObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut($global:ShortcutPath)
        $Shortcut.TargetPath = [string]$global:LauncherPath
        $Shortcut.WorkingDirectory = [string]$global:RootPath
        $Shortcut.Save()
        $registeredOk = $true
        Remove-ItemProperty -Path $global:RunRegKey -Name $global:RunRegName -ErrorAction SilentlyContinue
    } catch {
        # Tentativa 2 (Contingencia Automatica): Chave Run do Usuario no Registro do Windows
        try {
            $q = [char]34
            $cmdVal = $q + $global:LauncherPath + $q
            Set-ItemProperty -Path $global:RunRegKey -Name $global:RunRegName -Value $cmdVal -Force -ErrorAction Stop
            $registeredOk = $true
        } catch {
            if (-not $Silent) {
                $global:LogQueue.Enqueue("[SISTEMA] ERRO ao ativar Iniciar com Windows: $($_.Exception.Message)")
            }
        }
    }

    Update-StartupMenuChecks
    if (($registeredOk) -and (-not $Silent)) {
        $global:LogQueue.Enqueue("[SISTEMA] Iniciar com Windows: ATIVADO (Delay: $($DelaySec)s).")
    }
}

function Disable-WindowsStartup {
    Remove-Item -LiteralPath $global:ShortcutPath -Force -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path $global:RunRegKey -Name $global:RunRegName -ErrorAction SilentlyContinue
    $global:ConfiguredDelay    = $global:DefaultStartupDelay
    $global:StartupInitialized = $true
    $global:StartupEnabled     = $false
    Save-MinerConfig
    Update-StartupMenuChecks
    $global:LogQueue.Enqueue("[SISTEMA] Iniciar com Windows: DESATIVADO (Delay Padrao: 5s).")
}

foreach ($entry in $delayOptions.GetEnumerator()) {
    $dKey  = [int]$entry.Key
    $dText = [string]$entry.Value
    $dItem = New-Object System.Windows.Forms.ToolStripMenuItem($dText)
    $dItem.Tag = $dKey
    $dItem.Add_Click({
        $chosenDelay = [int]$this.Tag
        if ((Test-StartupRegistered) -and ($global:ConfiguredDelay -eq $chosenDelay)) {
            Disable-WindowsStartup
        } else {
            Enable-WindowsStartup $chosenDelay $false
        }
    })
    $global:itemStartup.DropDownItems.Add($dItem) | Out-Null
    $delayMenuItems[$dKey] = $dItem
}

# Clicar direto no botao pai "Iniciar com Windows" alterna Ativo/Desativado atualizando os subbotoes na hora
$global:itemStartup.Add_Click({
    if (Test-StartupRegistered) {
        Disable-WindowsStartup
    } else {
        Enable-WindowsStartup $global:ConfiguredDelay $false
    }
})

# Garante que na 1a execucao (ou sempre que StartupEnabled estiver ativo) o atalho aponte para a pasta atual
if ((-not $global:StartupInitialized) -or ($global:StartupEnabled)) {
    $global:StartupInitialized = $true
    if (Test-Path -LiteralPath $global:LauncherPath) {
        Enable-WindowsStartup $global:ConfiguredDelay $true
    } else {
        Save-MinerConfig
    }
}

# Ajusta o delay de partida atual conforme o estado do Iniciar com Windows
if (Test-StartupRegistered) {
    $global:StartupDelaySeconds = $global:ConfiguredDelay
} else {
    $global:StartupDelaySeconds = $global:DefaultStartupDelay
}
Update-StartupMenuChecks

$menu.Items.Add($global:itemStartup) | Out-Null

$global:itemWallet = New-Object System.Windows.Forms.ToolStripMenuItem((Get-Text "MenuWallet"))
$global:itemWallet.Add_Click({ Show-WalletConfig })
$menu.Items.Add($global:itemWallet) | Out-Null

# Submenu Testar Alerta de Bloco (KMS, Senna, MforN e Coins)
function Invoke-TestBlockAlert {
    param([string]$SelectedSound)
    if (-not [string]::IsNullOrWhiteSpace($SelectedSound)) {
        $global:SoundFileName = $SelectedSound
        $global:SoundFile     = Join-Path $global:ResPath $global:SoundFileName
        Save-MinerConfig
    }
    $fakeLine = "TESTE MANUAL - Accepted 999 S0 R0 B1, 12.345 sec (yay!!!)"
    $global:LogQueue.Enqueue("[SISTEMA] Simulando descoberta com audio: $($global:SoundFileName)")
    $global:LogQueue.Enqueue($fakeLine)
    Invoke-BlockAlert $fakeLine
}

$global:itemTestAlert = New-Object System.Windows.Forms.ToolStripMenuItem((Get-Text "MenuTestAlert"))

$global:itemSoundKMS = New-Object System.Windows.Forms.ToolStripMenuItem("KMS")
$global:itemSoundKMS.Add_Click({
    Invoke-TestBlockAlert $global:SoundFileKMS
})
$global:itemTestAlert.DropDownItems.Add($global:itemSoundKMS) | Out-Null

$global:itemSoundSenna = New-Object System.Windows.Forms.ToolStripMenuItem("Senna")
$global:itemSoundSenna.Add_Click({
    Invoke-TestBlockAlert $global:SoundFileSenna
})
$global:itemTestAlert.DropDownItems.Add($global:itemSoundSenna) | Out-Null

$global:itemSoundMforN = New-Object System.Windows.Forms.ToolStripMenuItem("MforN")
$global:itemSoundMforN.Add_Click({
    Invoke-TestBlockAlert $global:SoundFileMforN
})
$global:itemTestAlert.DropDownItems.Add($global:itemSoundMforN) | Out-Null

$global:itemSoundCoins = New-Object System.Windows.Forms.ToolStripMenuItem("Coins")
$global:itemSoundCoins.Add_Click({
    Invoke-TestBlockAlert $global:SoundFileCoins
})
$global:itemTestAlert.DropDownItems.Add($global:itemSoundCoins) | Out-Null

$menu.Items.Add($global:itemTestAlert) | Out-Null

$global:itemTtfStats = New-Object System.Windows.Forms.ToolStripMenuItem((Get-Text "MenuTtfStats"))
$global:itemTtfStats.Add_Click({ Show-TtfStats })
$menu.Items.Add($global:itemTtfStats) | Out-Null

$global:itemTutorial = New-Object System.Windows.Forms.ToolStripMenuItem((Get-Text "MenuTutorial"))
$global:itemTutorial.Add_Click({ Show-Tutorial })
$menu.Items.Add($global:itemTutorial) | Out-Null

$global:itemShare = New-Object System.Windows.Forms.ToolStripMenuItem((Get-Text "MenuShare"))
$global:itemShare.Add_Click({ Invoke-ShareMinerIsma })
$menu.Items.Add($global:itemShare) | Out-Null
$menu.Items.Add("-") | Out-Null

# 6. Mostrar/Ocultar e Pausar (com Submenu Manual, Tempos e Modo Pulsar Persistente)
$global:itemShowHide = New-Object System.Windows.Forms.ToolStripMenuItem((Get-Text "MenuShowHide"))
$global:itemShowHide.Add_Click({ Toggle-LogWindow })
$menu.Items.Add($global:itemShowHide) | Out-Null

$global:itemPause = New-Object System.Windows.Forms.ToolStripMenuItem((Get-Text "MenuPause"))
$pauseOptions = [ordered]@{
    0   = (Get-Text "PauseManual")
    15  = "15min."
    30  = "30min."
    60  = (Get-Text "Pause1h")
    120 = (Get-Text "Pause2h")
}
$pauseMenuItems = @{}
foreach ($entry in $pauseOptions.GetEnumerator()) {
    $pKey  = [int]$entry.Key
    $pText = [string]$entry.Value
    $pItem = New-Object System.Windows.Forms.ToolStripMenuItem($pText)
    $pItem.Tag = $pKey
    $pItem.Add_Click({
        $mins = [int]$this.Tag
        if ($global:IsPaused -and ($mins -eq 0)) {
            Invoke-ResumeMining $false
        } else {
            Set-MinerPause $mins
        }
    })
    $global:itemPause.DropDownItems.Add($pItem) | Out-Null
    $pauseMenuItems[$pKey] = $pItem
}

$global:itemPause.DropDownItems.Add("-") | Out-Null

$global:itemPulse1 = New-Object System.Windows.Forms.ToolStripMenuItem((Get-Text "Pulse2h"))
$global:itemPulse1.Add_Click({
    Set-PulseMode "2hx5" 120 5
})
$global:itemPause.DropDownItems.Add($global:itemPulse1) | Out-Null

$global:itemPulse2 = New-Object System.Windows.Forms.ToolStripMenuItem((Get-Text "Pulse4h"))
$global:itemPulse2.Add_Click({
    Set-PulseMode "4hx5" 240 5
})
$global:itemPause.DropDownItems.Add($global:itemPulse2) | Out-Null

$global:itemPause.Add_Click({
    if ($global:IsPaused) {
        Invoke-ResumeMining $false
    } else {
        Set-MinerPause 0
    }
})
$menu.Items.Add($global:itemPause) | Out-Null
$menu.Items.Add("-") | Out-Null

# 7. Fechar Mineracao
$global:itemExit = New-Object System.Windows.Forms.ToolStripMenuItem((Get-Text "MenuExit"))
$global:itemExit.Add_Click({
    $timer.Stop()
    $startTimer.Stop()
    $btcTimer.Stop()
    $global:shareBalloonTimer.Stop()
    if (($global:CurrentProc) -and (-not ($global:CurrentProc.HasExited))) {
        $global:StopRequested = $true
        if ($global:IsPaused) { Resume-MinerProcess }
        $global:CurrentProc.Kill()
    }
    Get-Process -Name "cpuminer*" -ErrorAction SilentlyContinue | Stop-Process -Force
    $global:notifyIcon.Visible = $false
    $global:notifyIcon.Dispose()
    $global:logForm.Dispose()
    [System.Windows.Forms.Application]::Exit()
})
$menu.Items.Add($global:itemExit) | Out-Null

# Aplica o Tema (Escuro Obsidiana ou Claro Perola) em todo o Menu do Tray e seus Submenus
Set-MenuObsidianTheme $menu

# Funcao que comuta todo o idioma da interface em tempo real sem interromper a mineracao
function Set-AppLanguage {
    param([string]$LangCode)
    if ($LangCode -notin @("PT", "EN", "ES")) { return }
    $global:Language = $LangCode
    [ObsidianMenuColors]::CurrentLangBadge = if ($global:Language -eq "PT") { "BR" } else { $global:Language }
    Save-MinerConfig

    if (-not [string]::IsNullOrWhiteSpace($global:LastBtcUsdFormatted)) {
        $global:btcPriceItem.Text = "$($global:BtcSym)$(Get-Text 'BtcNowPrefix')$($global:LastBtcUsdFormatted)"
    } else {
        $global:btcPriceItem.Text = "$($global:BtcSym)$(Get-Text 'BtcUpdating')"
    }

    $global:itemLinksMenu.Text    = "$($global:BtcSym)$(Get-Text 'BtcLinks')"
    $global:itemChannelsMenu.Text = Get-Text "MenuChannels"
    $global:gameDesafios.Text     = Get-Text "GameDesafios"
    $global:gameBoard.Text        = Get-Text "GameBoard"

    $global:lnkPool.Text       = Get-Text "LinkPool"
    $global:lnkUpdates.Text    = Get-Text "LinkUpdates"
    $global:lnkMempool.Text    = Get-Text "LinkMempool"
    $global:lnkTimeline.Text   = Get-Text "LinkTimeline"
    $global:lnkMonitor.Text    = Get-Text "LinkMonitor"
    $global:lnkBlueWallet.Text = Get-Text "LinkBlueWallet"
    $global:lnkLearn.Text      = Get-Text "LinkLearn"
    $global:lnkNews.Text       = Get-Text "LinkNews"
    $global:lnkGlobalAcc.Text  = Get-Text "LinkGlobalAcc"
    $global:lnkMissao1Btc.Text = Get-Text "LinkMissao1Btc"
    $global:lnkRetireBtc.Text  = Get-Text "LinkRetireBtc"
    $global:lnkBtcMaps.Text    = Get-Text "LinkBtcMaps"
    $global:lnkWeb.Text        = Get-Text "LinkWeb"
    $global:lnkGpuMiner.Text   = Get-Text "LinkGpuMiner"
    $global:lnkBubbles.Text    = Get-Text "LinkBubbles"

    $global:itemStartup.Text    = Get-Text "MenuStartup"
    $global:lblDelayHeader.Text = Get-Text "DelayHeader"
    if ($null -ne $delayMenuItems[5]) { $delayMenuItems[5].Text = Get-Text "DelayDefault" }

    $global:itemWallet.Text    = Get-Text "MenuWallet"
    $global:itemTestAlert.Text = Get-Text "MenuTestAlert"
    $global:itemTtfStats.Text  = Get-Text "MenuTtfStats"
    $global:itemTutorial.Text  = Get-Text "MenuTutorial"
    $global:itemShare.Text     = Get-Text "MenuShare"
    $global:itemShowHide.Text  = Get-Text "MenuShowHide"

    if ($global:IsPaused) {
        $global:itemPause.Text = Get-Text "MenuResume"
    } else {
        $global:itemPause.Text = Get-Text "MenuPause"
    }
    if ($null -ne $pauseMenuItems[0])   { $pauseMenuItems[0].Text   = Get-Text "PauseManual" }
    if ($null -ne $pauseMenuItems[60])  { $pauseMenuItems[60].Text  = Get-Text "Pause1h" }
    if ($null -ne $pauseMenuItems[120]) { $pauseMenuItems[120].Text = Get-Text "Pause2h" }

    $global:itemPulse1.Text = Get-Text "Pulse2h"
    $global:itemPulse2.Text = Get-Text "Pulse4h"
    $global:itemExit.Text   = Get-Text "MenuExit"

    foreach ($lKey in $langMenuItems.Keys) {
        $langMenuItems[$lKey].Checked = ($lKey -eq $global:Language)
    }

    $menu.Invalidate()
    $global:LogQueue.Enqueue("[SISTEMA] $(Get-Text 'MenuLanguage'): $LangCode")
}

# Atualizacao dinamica dos checks ao abrir o menu
$menu.Add_Opening({
    [ObsidianMenuColors]::CurrentLangBadge = if ($global:Language -eq "PT") { "BR" } else { $global:Language }
    foreach ($n in $threadItems.Keys) {
        $threadItems[$n].Checked = ($n -eq $global:CurrentThreads)
    }
    Update-StartupMenuChecks
    $global:itemSoundKMS.Checked   = ($global:SoundFileName -eq $global:SoundFileKMS)
    $global:itemSoundSenna.Checked = ($global:SoundFileName -eq $global:SoundFileSenna)
    $global:itemSoundMforN.Checked = ($global:SoundFileName -eq $global:SoundFileMforN)
    $global:itemSoundCoins.Checked = ($global:SoundFileName -eq $global:SoundFileCoins)
    $global:itemPulse1.Checked     = ($global:PulseMode -eq "2hx5")
    $global:itemPulse2.Checked     = ($global:PulseMode -eq "4hx5")
    foreach ($lKey in $langMenuItems.Keys) {
        $langMenuItems[$lKey].Checked = ($lKey -eq $global:Language)
    }
})

$global:notifyIcon.ContextMenuStrip = $menu

# ============================================================
# TIMERS DE INICIO, PRECO E LEITURA PRINCIPAL
# ============================================================
Initialize-CpuDetection

$startTimer = New-Object System.Windows.Forms.Timer
$startTimer.Interval = [Math]::Max(1, $global:StartupDelaySeconds) * 1000
$startTimer.Add_Tick({
    $startTimer.Stop()
    Start-MinerTask $global:DefaultThreads
    if ((-not $global:IsPaused) -and (Test-WalletConfigured)) { 
        $global:notifyIcon.Text = "$($global:ShortVersion)" + [Environment]::NewLine + "$($global:DefaultThreads) Threads | $(Get-Text 'TrayCalculating')" 
    }
})
$startTimer.Start()

$btcTimer = New-Object System.Windows.Forms.Timer
$btcTimer.Interval = 60000 # 60 segundos exatos
$btcTimer.Add_Tick({ Update-BtcPrice })
$btcTimer.Start()
Update-BtcPrice # Dispara imediatamente na primeira abertura

$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 300
$timer.Add_Tick({
    try {
        # 1. Verifica se ha pausa temporizada (ou pausa termica do Pulsar) para retomar automaticamente
        if ($global:IsPaused) {
            if (($null -ne $global:PauseResumeAt) -and ((Get-Date) -ge ($global:PauseResumeAt))) {
                Invoke-ResumeMining $true
            }
        }
        # 2. Se estiver minerando ativo e com Modo Pulsar habilitado, verifica se chegou a hora da pausa termica
        elseif (($global:PulseMode -ne "") -and ($null -ne $global:PulseNextSwitch) -and ((Get-Date) -ge ($global:PulseNextSwitch))) {
            if (($null -ne $global:CurrentProc) -and (-not $global:CurrentProc.HasExited)) {
                Suspend-MinerProcess
                $global:IsPaused = $true
                $global:itemPause.Text = Get-Text "MenuResume"
                $global:PulseNextSwitch = (Get-Date).AddMinutes($global:PulsePauseMins)
                $global:PauseResumeAt = $global:PulseNextSwitch
                $resumeStr = $global:PulseNextSwitch.ToString("HH:mm")
                $global:notifyIcon.Text = "$($global:ShortVersion)" + [Environment]::NewLine + "Pulsar $($global:PulseMode) | $(Get-Text 'TrayPulsePause') $resumeStr)"
                $global:LogQueue.Enqueue("[SISTEMA] Modo Pulsar ($($global:PulseMode)): Pausa termica de $($global:PulsePauseMins) min iniciada (retoma as $resumeStr).")
            }
        }

        $events = Get-Event -SourceIdentifier "MinerOut" -ErrorAction SilentlyContinue
        $events += Get-Event -SourceIdentifier "MinerErr" -ErrorAction SilentlyContinue
        
        foreach ($e in $events) {
            $line = $e.SourceEventArgs.Data
            Remove-Event -EventIdentifier $e.EventIdentifier -ErrorAction SilentlyContinue
            
            if ([string]::IsNullOrWhiteSpace($line)) { continue }
            $line = [regex]::Replace($line, "\x1B\x5B[0-9;?]*[a-zA-Z]", "")
            
            $global:LogQueue.Enqueue($line)
            
            if ($line -match "(?i)yay" -or $line -match "S\d+\s+R\d+\s+B[1-9]" -or ($line -match "(?i)block" -and $line -match "(?i)found")) {
                $global:BlockFoundLine = $line
            }
        }

        $line = ""
        $added = $false
        while ($global:LogQueue.TryDequeue([ref]$line)) {
            $global:RecentLines.Enqueue($line)
            while ($global:RecentLines.Count -gt 15) { $global:RecentLines.Dequeue() | Out-Null }

            # Captura automaticamente a altura atual do Bloco da rede Bitcoin recebida via Stratum
            if ($line -match "Block\s+(\d{6,7})\b") {
                $bNum = [int]$Matches[1]
                if ($bNum -gt $global:CurrentBlockHeight) {
                    $global:CurrentBlockHeight = $bNum
                    Save-MinerConfig
                }
            }

            if ($line -match "TTF @\s*([\d.,]+\s*\S+/s):\s*Block\s*([^,]+),\s*Share\s*(.+?)\s*$") {
                $hr = $Matches[1]
                $ttfBlock = $Matches[2].Trim()
                $ttfShare = $Matches[3].Trim()
                
                # Tooltip limpo na tela
                if ((-not $global:IsPaused) -and (Test-WalletConfigured)) {
                    if ($global:PulseMode -ne "") {
                        $global:notifyIcon.Text = "$($global:ShortVersion) ($($global:PulseMode))" + [Environment]::NewLine + "$($global:CurrentThreads) Threads | $hr"
                    } else {
                        $global:notifyIcon.Text = "$($global:ShortVersion)" + [Environment]::NewLine + "$($global:CurrentThreads) Threads | $hr"
                    }
                }

                # Registra no log de TTF apenas apos os 60s de estabilizacao da partida/retomada
                if ((Get-Date) -ge $global:TtfLogAllowedAt) {
                    $dias = Convert-TtfToDays $ttfBlock
                    if ($null -ne $dias) {
                        # Filtro Inteligente: Busca o limite de dias baseado nos threads atuais
                        $limiteDias = $global:TtfThresholds[$global:CurrentThreads]
                        if ($null -eq $limiteDias) { $limiteDias = 365 } # Seguranca
                        
                        if (($dias -lt $limiteDias) -and ($ttfBlock -ne $global:LastTtfLogged)) {
                            $global:LastTtfLogged = $ttfBlock
                            $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
                            $ttfEntry = "[$stamp] Threads: $($global:CurrentThreads) | Hashrate: $hr | TTF Bloco: $ttfBlock | TTF Share: $ttfShare | Linha: $line"
                            $ttfEntry | Out-File -FilePath $global:TtfLogFile -Append -Encoding utf8
                            try { Copy-Item -LiteralPath $global:TtfLogFile -Destination $global:BackupTtfLogFile -Force -ErrorAction SilentlyContinue } catch {}
                        }
                    }
                }
            }

            $global:logBox.SelectionStart = $global:logBox.TextLength
            $global:logBox.SelectionLength = 0
            if ($line -match "(?i)accepted")         { $global:logBox.SelectionColor = [System.Drawing.Color]::LimeGreen }
            elseif ($line -match "(?i)rejected")     { $global:logBox.SelectionColor = [System.Drawing.Color]::Red }
            elseif ($line -match "(?i)yay|B[1-9]")   { $global:logBox.SelectionColor = [System.Drawing.Color]::Gold }
            elseif ($line -match "\x5BSISTEMA\x5D")  { $global:logBox.SelectionColor = [System.Drawing.Color]::Cyan }
            else                                     { $global:logBox.SelectionColor = [System.Drawing.Color]::DarkGray }
            $global:logBox.AppendText($line + [Environment]::NewLine)
            $added = $true
        }

        # Limpeza de memoria preservando o cabecalho inicial em Ciano e as cores RTF de cada linha
        if ($global:logBox.TextLength -gt 300000) {
            $headerEnd = 0
            if ($global:logBox.Lines.Count -gt 5) {
                $headerEnd = $global:logBox.GetFirstCharIndexFromLine(5)
            }
            if ($headerEnd -lt 0) { $headerEnd = 0 }
            $global:logBox.ReadOnly = $false
            $global:logBox.Select($headerEnd, 100000)
            $global:logBox.SelectedText = ""
            $global:logBox.ReadOnly = $true
            $global:logBox.SelectionStart = $global:logBox.TextLength
        }
        if (($added) -and ($global:Visible)) {
            $global:logBox.SelectionStart = $global:logBox.TextLength
            $global:logBox.ScrollToCaret()
            $global:logScrollBar.Invalidate()
        }

        if (($global:CurrentProc) -and ($global:CurrentProc.HasExited) -and (-not ($global:StopRequested)) -and (-not ($global:CrashNotified))) {
            $global:CrashNotified = $true
            $code = $global:CurrentProc.ExitCode
            $global:LogQueue.Enqueue("[SISTEMA] ATENCAO: o miner encerrou sozinho (codigo $code). Reiniciando em 15s...")
            $global:notifyIcon.ShowBalloonTip(8000, "MinerIsma", "O miner encerrou (codigo $code). Veja a janela/log para detalhes. Reiniciando em 15s.", [System.Windows.Forms.ToolTipIcon]::Warning)
            $global:RestartAt = (Get-Date).AddSeconds(15)
        }
        if (($global:RestartAt) -and ((Get-Date) -ge ($global:RestartAt))) {
            $global:RestartAt = $null
            Start-MinerTask $global:CurrentThreads
        }

        if ($global:BlockFoundLine) {
            $bLine = $global:BlockFoundLine
            $global:BlockFoundLine = $null
            Invoke-BlockAlert $bLine
        }
    } catch {}
})
$timer.Start()

$global:notifyIcon.ShowBalloonTip(5000, "$($global:ShortVersion)", "$(Get-Text 'BalloonStart1') $($global:StartupDelaySeconds) $(Get-Text 'BalloonStart2')", [System.Windows.Forms.ToolTipIcon]::Info)

[System.Windows.Forms.Application]::Run()