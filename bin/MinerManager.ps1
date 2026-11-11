# ===============================================================================
# MinerIsma v2.1.2 Alpha - MinerManager.ps1 Gerenciador Miner Solo BTC Tray Icon
# ===============================================================================
#  PROOF OF EXISTENCE / PRIOR ART RECORD / INTELLECTUAL PROPERTY REGISTRATION
# -------------------------------------------------------------------------------
# Registered Previous Version : MinerIsma_v2.1.1.exe (BTC_MinerIsma_v2.1.1.exe)
# Consolidated File Hex Hash  : (0x)6BBA5A122318F581CEB820C72C26AD03D2295B2226B98B29F1DC26C5A29C70CC
# Blockchain Network          : Polygon Mainnet / Ethereum Mainnet
# Transaction ID (polygonscan): 0xda0aed37e52cde8a3fbb6d59f6f091d931384a7923068f5e7f5ec7e701fa161c
# Link Verificador            : https://polygonscan.com/tx/0xda0aed37e52cde8a3fbb6d59f6f091d931384a7923068f5e7f5ec7e701fa161c
# Subscriber Wallet (Author)  : 0xF72C0Ee272eEf5c52018dA877ED2EF61c9434015
# Copyright (c) MCIsma / 2026 : GNU General Public License v3.0 - resources\LICENSE
# Algoritmo Hash              : SHA-256 (Get-FileHash) | Timestamp: 2026-11-07 23:42 UTC-03
# Historico detalhado disponivel em: resources\RELEASE_NOTES.md
# ===============================================================================

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

# ================================================================
#  1. CONFIGURACOES ESSENCIAIS E PADROES DE FABRICA
# ================================================================
$global:Wallet               = "minha_carteira.WORKER"   # <<< TROQUE pela sua Carteira e Trabalhador
$global:DefaultPoolUrl       = "stratum+tcp://public-pool.io:3333"
$global:DefaultExtraArgs     = "--cpu-priority=1"
$global:PoolUrl              = $global:DefaultPoolUrl
$global:ExtraArgs            = $global:DefaultExtraArgs

$global:MinerExeName         = "cpuminer-avx2-sha.exe"
$global:LauncherFileName     = "START_MinerIsma.exe"
$global:TutorialFileName     = "Tutorial.html"
$global:CustomIconFileName   = "iconeMinerIsmaFull4b.ico"
$global:DonateQrFileName     = "QRcode-LNURL-BTC_On-EVM-2300x720dpi.png"

$global:SoundFileKMS         = "alerta_de_bloco-KMS.mp3"
$global:SoundFileSenna       = "alerta_de_bloco-Senna.mp3"
$global:SoundFileMforN       = "alerta_de_bloco-MforN.mp3"
$global:SoundFileCoins       = "alerta_de_bloco-Coins.mp3"
$global:SoundFileName        = $global:SoundFileKMS
$global:SfxDonateRing        = "Apoie_sanic-collect-ring.mp3"
$global:SfxShareHarpsichord  = "Compartilhar_freesound-winharpsichord.mp3"
$global:SfxCelebrateMario    = "Comemorar_Super_Mario_Victory.mp3"

$global:DefaultStartupDelay  = 5
$global:StartupDelaySeconds  = $global:DefaultStartupDelay
$global:TtfWarmupSeconds     = 60

# --- Enderecos Oficiais de Doacao e Links de Sistema / Fallback ---
$global:DonateAddrLightning  = "lnurl1dp68gurn8ghj7mnpd4jhxtnrda5kummn9e5k7tmvde6hymrs9a5hxmtp2alrwl"
$global:DonateAddrBtcOnChain = "bc1qy2wuwjz0c5hcw4r835erf9w7kjz9kmzprvgd7m"
$global:DonateAddrEvm        = "0xF72C0Ee272eEf5c52018dA877ED2EF61c9434015"

$global:VersionCheckUrl      = "https://rentry.co/MinerIsma-V"
$global:BtcPriceUrl          = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd"
$global:FiatPriceUrl         = "https://economia.awesomeapi.com.br/last/USD-BRL,USD-EUR"
$global:UrlPoolDashboard     = "https://web.public-pool.io/#/app/"
$global:UrlDriveUpdates      = "https://drive.proton.me/urls/WF022MG27W#YknkVYHMQO4w"
$global:UrlMegaUpdates       = "https://mega.nz/folder/1pEAyJRB#ZsvFzL9K-00y0iPqmwc8mQ"
$global:UrlTutorial          = "https://github.com/MCIsma/MinerIsma"
$global:UrlBlueWallet        = "https://bluewallet.io/"
$global:UrlCoinGecko         = "https://www.coingecko.com/pt-br"
$global:UrlCalcConverter     = "https://coinmarketcap.com/pt-br/converter"

$global:UrlHalving1          = "https://boletimbitcoin.com/halving-bitcoin/"
$global:UrlHalving2          = "https://br.investing.com/academy/crypto/halving-bitcoin/"
$global:UrlHalving3          = "https://bitcoin-org.translate.goog/en/halving?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=pt&_x_tr_pto=sge"
$global:UrlLightningInfo1    = "https://kriptobr.com/lightning-network-o-que-e-e-como-usar-bitcoin-no-dia-a-dia"
$global:UrlLightningInfo2    = "https://blog.areabitcoin.com.br/lightning-network"

$global:TtfThresholds        = @{ 10 = 240; 8 = 300; 7 = 330; 6 = 365; 5 = 547; 4 = 730; 3 = 912; 2 = 1095; 1 = 1277 }

# ================================================================
#  2. INTELIGENCIA DE PERFIS DINAMICOS (Baseado na CPU)
# ================================================================
try {
    $global:LogicalCores = (Get-CimInstance Win32_ComputerSystem | Select-Object -First 1).NumberOfLogicalProcessors
} catch {
    $global:LogicalCores = 12
}

$arrSym = [string][char]0x2192
if ($global:LogicalCores -ge 24) {
    $global:PowerHeaderTitle = "Power  |  CPU 24+ Threads"
    $global:ThreadProfiles   = [ordered]@{ 10 = "0x555550"; 8 = "0x155540"; 6 = "0x155400"; 5 = "0x155000"; 4 = "0x154000"; 3 = "0x150000" }
    $global:ThreadLabels     = @{
        10 = "~48% $arrSym" + "10....!.!.!.!.!.!.!.!.!.!."
        8  = "~38% $arrSym 8......!.!.!.!.!.!.!.!..."
        6  = "~28% $arrSym 6..........!.!.!.!.!.!..."
        5  = "~24% $arrSym 5............!.!.!.!.!..."
        4  = "~20% $arrSym 4..............!.!.!.!..."
        3  = "~15% $arrSym 3................!.!.!..."
    }
} elseif ($global:LogicalCores -ge 16) {
    $global:PowerHeaderTitle = "Power | CPU 16+ Threads"
    $global:ThreadProfiles   = [ordered]@{ 7 = "0x5554"; 6 = "0x5550"; 5 = "0x5540"; 4 = "0x1540"; 3 = "0x1500"; 2 = "0x1400" }
    $global:ThreadLabels     = @{
        7 = "~50% $arrSym 7 ..!.!.!.!.!.!.!."
        6 = "~42% $arrSym 6 ....!.!.!.!.!.!."
        5 = "~36% $arrSym 5 ......!.!.!.!.!."
        4 = "~28% $arrSym 4 ......!.!.!.!..."
        3 = "~22% $arrSym 3 ........!.!.!..."
        2 = "~15% $arrSym 2 ..........!.!..."
    }
} elseif ($global:LogicalCores -ge 12) {
    $global:PowerHeaderTitle = "Power | CPU 12 Threads"
    $global:ThreadProfiles   = [ordered]@{ 5 = "0x554"; 4 = "0x550"; 3 = "0x150"; 2 = "0x50"; 1 = "0x010" }
    $global:ThreadLabels     = @{
        5 = "~46% $arrSym 5  ..!.!.!.!.!."
        4 = "~38% $arrSym 4  ....!.!.!.!."
        3 = "~28% $arrSym 3  ....!.!.!..."
        2 = "~20% $arrSym 2  ....!.!....."
        1 = "~10% $arrSym 1  ....!......."
    }
} else {
    $global:PowerHeaderTitle = "Power | CPU 10-Threads"
    $global:ThreadProfiles   = [ordered]@{ 4 = "0x154"; 3 = "0x54"; 2 = "0x50"; 1 = "0x010" }
    $global:ThreadLabels     = @{
        4 = "~45% $arrSym  4  ..!.!.!.!."
        3 = "~35% $arrSym  3  ..!.!.!..."
        2 = "~22% $arrSym  2  ....!.!..."
        1 = "~12% $arrSym  1  ....!....."
    }
}

# ================================================================
#  3. TABELA DE IDIOMAS UNIFICADA (Indice 0 = PT | 1 = EN | 2 = ES)
# ================================================================
$boltChar        = [string][char]0x26A1
$euroChar        = [string][char]0x20AC
$warnChar        = [string][char]0x26A0
$lblMissaoPT     = "Miss" + [char]0x00E3 + "o 1 Bitcoin"
$lblMissaoES     = "Misi" + [char]0x00F3 + "n 1 Bitcoin"
$lblRetireES     = "Jubilaci" + [char]0x00F3 + "n BTC"
$lblGpuMiner     = "GPU miner " + [char]0x2192 + " $$$"
$lblPrizeHdrPT   = "Pr" + [char]0x00EA + "mio Atual do Bloco"
$lblAvgHdrPT     = "Tempo M" + [char]0x00E9 + "dio Estimado"
$lblAvgSubPT     = "(at" + [char]0x00E9 + " um Bloco / Sorte)"
$lblHalvPT1      = "Pr" + [char]0x00F3 + "ximo Halving em "
$lblHalvES1      = "Pr" + [char]0x00F3 + "ximo Halving en "
$lblAreaPT       = "Link de download copiado para a " + [char]0x00E1 + "rea de transfer" + [char]0x00EA + "ncia!"
$lblUsefulPT     = "Links " + [char]0x00DA + "teis"
$lblUsefulES     = "Enlaces " + [char]0x00DA + "tiles"
$lblStatsMenuPT  = "Estat" + [char]0x00ED + "sticas: Sua Sorte"
$lblStatsMenuES  = "Estad" + [char]0x00ED + "sticas: Tu Suerte"
$lblBestCardPT   = "Melhor Aproxima" + [char]0x00E7 + [char]0x00E3 + "o"
$lblBestCardES   = "Mejor Aproximaci" + [char]0x00F3 + "n"
$lblSoloCardPT   = [char]0x00DA + "ltimo Bloco Minerado"
$lblSoloCardES   = [char]0x00DA + "ltimo Bloque Minado"
$lblSoloSubPT    = "(Por Minerador Solo igual a Voc" + [char]0x00EA + "!)"
$lblSoloPrizePT  = "Pr" + [char]0x00EA + "mio:"
$lblPadraoBtcPT  = "(BTC Padr" + [char]0x00E3 + "o)"
$lblPadraoBtcES  = "(BTC Est" + [char]0x00E1 + "ndar)"
$lblAddrCopiedPT = "Endere" + [char]0x00E7 + "o Copiado!"
$lblAddrCopiedES = "Direcci" + [char]0x00F3 + "n Copiada!"
$lblDonateCamPT  = "Certifique-se de que a c" + [char]0x00E2 + "mera capturou o QRcode da Rede desejada."
$lblDonateCamES  = "Aseg" + [char]0x00FA + "rate de que la c" + [char]0x00E1 + "mara captur" + [char]0x00F3 + " el QRcode de la Red deseada."
$lblLayer2Lgt    = "BTC Layer2:" + $boltChar + "Lightning"

$global:Language = "PT"
$global:LangTable = @{
    BtcUpdating       = @("itcoin agora: Atualizando...", "itcoin now: Updating...", "itcoin ahora: Actualizando...")
    BtcNowPrefix      = @("itcoin agora: US$ ", "itcoin now: US$ ", "itcoin ahora: US$ ")
    UsdUpdating       = @("Dolar agora: Atualizando...", "Dollar now: Updating...", "Dolar ahora: Actualizando...")
    UsdNowPrefix      = @("Dolar agora: R$", "Dollar now: $euroChar", "Dolar ahora: $euroChar")
    BtcLinks          = @("itcoin Links", "itcoin Links", "itcoin Links")
    MenuChannels      = @("Canais Cripto", "Crypto Channels", "Canales Cripto")
    MenuPortals       = @("Portais Cripto", "Crypto Portals", "Portales Cripto")
    UsefulLinksHdr    = @($lblUsefulPT, "Useful Links", $lblUsefulES)
    InspiringLinksHdr = @("Links Inspiradores", "Inspiring Links", "Enlaces Inspiradores")
    TradersHdr        = @("Cripto Traders", "Crypto Traders", "Cripto Traders")
    GameDesafios      = @("Cripto Desafios $", "Crypto Challenges $", "Desafios Cripto $")
    GameBoard         = @("TotheMoon Tabuleiro", "TotheMoon Board Game", "TotheMoon Juego de Mesa")
    MenuMinerPanel    = @("Painel do Minerador", "Miner Panel", "Panel del Minero")
    LinkPool          = @("Seu Miner na Pool", "Your Miner on Pool", "Tu Miner en la Pool")
    LinkUpdates       = @("Atualizacoes MinerIsma", "MinerIsma Updates", "Actualizaciones MinerIsma")
    LinkMempool       = @("Mempool Bitcoin", "Bitcoin Mempool", "Mempool Bitcoin")
    LinkTimeline      = @("TimeLine Bitcoin", "Bitcoin TimeLine", "TimeLine Bitcoin")
    LinkMonitor       = @("Monitor Cripto", "Crypto Monitor", "Monitor Cripto")
    LinkBlueWallet    = @("Blue Wallet", "Blue Wallet", "Blue Wallet")
    LinkHardWallet    = @("Hard Wallet", "Hard Wallet", "Hard Wallet")
    LinkP2pBtc        = @("P2P Bitcoin", "P2P Bitcoin", "P2P Bitcoin")
    LinkContaBtc      = @("Conta Bitcoin", "Bitcoin Account", "Cuenta Bitcoin")
    LinkAtomicBtc     = @("Troca Atomica BTC", "BTC Atomic Swap", "Intercambio Atomico BTC")
    LinkLearn         = @("Aprenda Bitcoin", "Learn Bitcoin", "Aprende Bitcoin")
    LinkBtcCore       = @("Bitcoin Core", "Bitcoin Core", "Bitcoin Core")
    LinkNews          = @("BitNoticias", "BitNoticias", "BitNoticias")
    LinkCoinGecko     = @("CoinGecko", "CoinGecko", "CoinGecko")
    LinkGlobalAcc     = @("Conta Global Cripto", "Crypto Global Account", "Cuenta Global Cripto")
    LinkMultiWallet   = @("Wallet Multimoedas", "Multi-coin Wallet", "Wallet Multimoneda")
    LinkAtomicSwap    = @("Troca Atomica", "Atomic Swap", "Intercambio Atomico")
    LinkRealizacao    = @("Realizacao Cripto", "Crypto Cashout", "Realizacion Cripto")
    LinkMinerEvolua   = @("Mineracao:Evolua!", "Mining:Evolve!", "Mineria:Evoluciona!")
    LinkMissao1Btc    = @($lblMissaoPT, "Mission 1 Bitcoin", $lblMissaoES)
    LinkRetireBtc     = @("Aposentadoria BTC", "BTC Retirement", $lblRetireES)
    LinkCalcCripto    = @("Calculadora Cripto", "Crypto Calculator", "Calculadora Cripto")
    LinkBtcMaps       = @("Bitcoin Maps", "Bitcoin Maps", "Bitcoin Maps")
    LinkWeb           = @("MinerIsma na web", "MinerIsma on the Web", "MinerIsma en la web")
    LinkLayer2Lgt     = @($lblLayer2Lgt, $lblLayer2Lgt, $lblLayer2Lgt)
    LinkWalletLgt     = @("Sua Wallet Lightning$boltChar", "Your Lightning Wallet$boltChar", "Tu Wallet Lightning$boltChar")
    LinkGpuMiner      = @($lblGpuMiner, $lblGpuMiner, $lblGpuMiner)
    LinkBubbles       = @("Crypto Bubbles", "Crypto Bubbles", "Crypto Bubbles")
    MsgWebSoon        = @("A pagina do MinerIsma na web sera disponibilizada em breve.", "The MinerIsma web page will be available soon.", "La pagina web de MinerIsma estara disponible pronto.")
    MenuStartup       = @("Iniciar com Windows", "Start with Windows", "Iniciar con Windows")
    DelayHeader       = @("Delay:", "Delay:", "Delay:")
    DelayDefault      = @("Padrao", "Default", "Por defecto")
    MenuWallet        = @("Sua Carteira Bitcoin", "Your Bitcoin Wallet", "Tu Billetera Bitcoin")
    MenuTestAlert     = @("Testar Alerta de Bloco", "Test Block Alert", "Probar Alerta de Bloque")
    MenuTtfStats      = @($lblStatsMenuPT, "Stats: Your Luck", $lblStatsMenuES)
    MenuDesktopIcon   = @("Criar Icone Desktop", "Create Desktop Icon", "Crear Icono Escritorio")
    MenuAdvanced      = @("Avancado (PERIGO!)", "Advanced (DANGER!)", "Avanzado (PELIGRO!)")
    MenuSupport       = @("Apoie este Projeto", "Support this Project", "Apoya este Proyecto")
    MenuLanguage      = @("Idioma", "Language", "Idioma")
    MenuTutorial      = @("Tutorial MinerIsma", "MinerIsma Tutorial", "Tutorial MinerIsma")
    MenuShare         = @("Compartilhar MinerIsma", "Share MinerIsma", "Compartir MinerIsma")
    MenuCopyLink      = @("Copiar Link", "Copy Link", "Copiar Enlace")
    ShareCopiedShort  = @("Link copiado!", "Link copied!", "Enlace copiado!")
    ShareCopiedMsg    = @($lblAreaPT, "Download link copied to clipboard!", "Enlace de descarga copiado al portapapeles!")
    AddrCopiedShort   = @($lblAddrCopiedPT, "Address Copied!", $lblAddrCopiedES)
    DonateWinTitle    = @("Apoie o Projeto MinerIsma, Doe:", "Support the MinerIsma Project, Donate:", "Apoya el Proyecto MinerIsma, Dona:")
    DonateBtcSub      = @($lblPadraoBtcPT, "(BTC Standard)", $lblPadraoBtcES)
    DonateCamWarn     = @($lblDonateCamPT, "Make sure your camera captured the desired Network QR code.", $lblDonateCamES)
    TutorialWinTitle  = @("Tutorial", "Tutorial", "Tutorial")
    MenuShowHide      = @("Mostrar / Ocultar Miner", "Show / Hide Miner", "Mostrar / Ocultar Miner")
    MenuPause         = @("Pausar Mineracao", "Pause Mining", "Pausar Mineria")
    MenuResume        = @("Retomar Mineracao", "Resume Mining", "Reanudar Mineria")
    PauseManual       = @("Manual", "Manual", "Manual")
    Pause1h           = @("1 hora", "1 hour", "1 hora")
    Pause2h           = @("2 horas", "2 hours", "2 horas")
    Pulse2h           = @("Pulsar 2hx5", "Pulse 2hx5", "Pulsar 2hx5")
    Pulse4h           = @("Pulsar 4hx5", "Pulse 4hx5", "Pulsar 4hx5")
    MenuExit          = @("Fechar Mineracao", "Exit Mining", "Cerrar Mineria")
    TrayWaitStart     = @("Aguardando inicio...", "Waiting to start...", "Esperando inicio...")
    TrayWaitWallet    = @("AGUARDANDO CARTEIRA", "WAITING FOR WALLET", "ESPERANDO BILLETERA")
    TrayCalculating   = @("Calculando...", "Calculating...", "Calculando...")
    TrayPaused        = @("PAUSADO", "PAUSED", "PAUSADO")
    TrayPausedUntil   = @("PAUSADO (ate", "PAUSED (until", "PAUSADO (hasta")
    TrayPulsePause    = @("PAUSA (ate", "PAUSE (until", "PAUSA (hasta")
    TrayResuming      = @("Retomando...", "Resuming...", "Reanudando...")
    BalloonStart1     = @("Gerenciador na bandeja. Mineracao inicia em", "Manager in system tray. Mining starts in", "Administrador en bandeja. La mineria inicia en")
    BalloonStart2     = @("segundos.", "seconds.", "segundos.")
    BtnSave           = @("Salvar", "Save", "Guardar")
    BtnSaveImg        = @("Salvar Imagem", "Save Image", "Guardar Imagen")
    BtnResetTtf       = @("Zerar TTF", "Reset TTF", "Reiniciar TTF")
    BtnClose          = @("Fechar", "Close", "Cerrar")
    BtnCreateWallet   = @("Criar Carteira", "Create Wallet", "Crear Billetera")
    BtnCelebrate      = @("Comemorar!", "Celebrate!", "Celebrar!")
    BtnSaveApply      = @("Salvar e Aplicar", "Save & Apply", "Guardar y Aplicar")
    BtnRestoreDef     = @("Restaurar Padrao", "Restore Default", "Restaurar Patron")
    AdvWinTitle       = @("Modo Avancado", "Advanced Mode", "Modo Avanzado")
    AdvDangerHdr      = @("$warnChar ZONA DE PERIGO - MODO AVANCADO", "$warnChar DANGER ZONE - ADVANCED MODE", "$warnChar ZONA DE PELIGRO - MODO AVANZADO")
    AdvWarn1          = @("- Atencao: Essas funcoes sao capazes de superaquecer ou desestabilizar o seu Pc!", "- Warning: These functions can overheat or destabilize your PC!", "- Atencion: Estas funciones pueden sobrecalentar o desestabilizar tu PC!")
    AdvWarn2          = @("So altere caso voce tenha certeza do que esta fazendo, e ciente de seu risco!", "Only change if you are sure of what you are doing and aware of the risk!", "Solo modifica si estas seguro de lo que haces y consciente del riesgo!")
    AdvWarn3          = @("* Mude Threads, Afinidades e Carteira somente nos menus proprios.", "* Change Threads, Affinity, and Wallet only in their respective menus.", "* Cambia Threads, Afinidad y Billetera solo en sus menus propios.")
    AdvLblPool        = @("Endereco da Pool Solo (Ex.: stratum+tcp://public-pool.io:3333):", "Solo Pool Address (e.g., stratum+tcp://public-pool.io:3333):", "Direccion de Pool Solo (Ej.: stratum+tcp://public-pool.io:3333):")
    AdvLblExtra       = @("Parametros Extras pertinentes ao motor cpuminer-opt:", "Extra Parameters for the cpuminer-opt engine:", "Parametros Extras pertinentes al motor cpuminer-opt:")
    AdvLblPreview     = @("Somente Visualizacao (Comando Completo):", "Read-Only Preview (Full Command):", "Solo Visualizacion (Comando Completo):")
    AdvConfirmMsg     = @("Confirmar alteracoes no Modo Avancado e reiniciar o minerador agora?", "Confirm Advanced Mode changes and restart the miner now?", "Confirmar cambios en Modo Avanzado y reiniciar el minero ahora?")
    AdvRestoreMsg     = @("Deseja restaurar a Pool e os Parametros Extras para o padrao de fabrica?", "Do you want to restore Pool and Extra Parameters to factory defaults?", "Deseas restaurar la Pool y los Parametros Extras al patron de fabrica?")
    AdvInvalidPool    = @("O endereco da Pool deve comecar com 'stratum+tcp://' ou 'stratum+ssl://'.", "Pool address must start with 'stratum+tcp://' or 'stratum+ssl://'.", "La direccion de la Pool debe comenzar con 'stratum+tcp://' o 'stratum+ssl://'.")
    AdvForbiddenArgs  = @("Nao insira parametros de Threads (-t), Afinidade, Pool (-o) ou Carteira (-u) nos Parametros Extras. Use os menus proprios.", "Do not insert Thread (-t), Affinity, Pool (-o), or Wallet (-u) flags in Extra Parameters. Use their own menus.", "No ingreses parametros de Threads (-t), Afinidad, Pool (-o) o Billetera (-u) en Parametros Extras. Usa sus menus propios.")
    WalletWinTitle    = @("Sua Carteira Bitcoin", "Your Bitcoin Wallet", "Tu Billetera Bitcoin")
    WalletHeader      = @("Configure endereco Bitcoin para iniciar Miner:", "Configure Bitcoin address to start Miner:", "Configura direccion Bitcoin para iniciar Miner:")
    WalletLblAddr     = @("Insira seu endereco de carteira Bitcoin (Ex.: bc1...):", "Enter your Bitcoin wallet address (e.g., bc1...):", "Ingresa tu direccion de billetera Bitcoin (Ej.: bc1...):")
    WalletLblWorker   = @("Insira seu Trabalhador (Ex.: Pc_Gamer):", "Enter your Worker name (e.g., Gaming_PC):", "Ingresa tu Trabajador (Ej.: Pc_Gamer):")
    WalletWarn1       = @("Endereco errado significa perder um possivel premio, confira!", "A wrong address means losing a possible reward, double-check!", "Una direccion erronea significa perder un posible premio, verifica!")
    WalletWarn2       = @("Para o Trabalhador, evite caracteres especiais, espacos e acentuacao", "For the Worker name, avoid special characters, spaces, and accents", "Para el Trabajador, evita caracteres especiales, espacios y acentos")
    WalletEmptyMsg    = @("Por favor, insira um endereco de carteira Bitcoin.", "Please enter a Bitcoin wallet address.", "Por favor, ingresa una direccion de billetera Bitcoin.")
    WalletInvalid1    = @("O endereco inserido nao parece ser uma carteira Bitcoin valida.", "The entered address does not look like a valid Bitcoin wallet.", "La direccion ingresada no parece ser una billetera Bitcoin valida.")
    WalletInvalid2    = @("Certifique-se de que ele comeca com '1', '3' ou 'bc1'.", "Make sure it starts with '1', '3', or 'bc1'.", "Asegurate de que comience con '1', '3' o 'bc1'.")
    TtfWaitAvg        = @("Aguardando...", "Waiting...", "Esperando...")
    TtfNoDataBox1     = @("Sem dados para estatistica.", "Not enough data for luck stats.", "Sin datos para estadisticas.")
    TtfNoDataBox2     = @("Deixe o MinerIsma rodando!", "Keep MinerIsma running!", "Deja MinerIsma corriendo!")
    TtfResetConfirm   = @("Deseja realmente zerar todo o historico de estatisticas TTF?", "Do you really want to reset all TTF statistics history?", "Realmente deseas reiniciar todo el historial de estadisticas TTF?")
    TtfWinTitle       = @("Estatisticas TTF (Estimativa do Bloco)", "TTF Statistics (Block Estimate)", "Estadisticas TTF (Estimacion de Bloque)")
    TtfPrizeHeader    = @($lblPrizeHdrPT, "Current Block Reward", "Premio Actual del Bloque")
    TtfPrizeBtc       = @("3.125 BTC", "3.125 BTC", "3.125 BTC")
    TtfPrizeUsdPref   = @("$ ~US$ ", "$ ~US$ ", "$ ~US$ ")
    TtfPrizeUsdWait   = @("$ Atualizando cotacao...", "$ Updating price...", "$ Actualizando cotizacion...")
    TtfDrawInfo       = @('"Sorteio" a cada ~10 min', '"Draw" every ~10 min', '"Sorteo" cada ~10 min')
    TtfHalving1       = @($lblHalvPT1, "Next Halving in ", $lblHalvES1)
    TtfHalving2       = @(" Blocos", " Blocks", " Bloques")
    TtfAvgHeader      = @($lblAvgHdrPT, "Estimated Average Time", "Tiempo Promedio Estimado")
    TtfAvgSub         = @($lblAvgSubPT, "(until a Block / Luck)", "(hasta un Bloque / Suerte)")
    TtfCountLbl       = @("Registros Elegiveis:", "Eligible Records:", "Registros Elegibles:")
    TtfBestLbl        = @($lblBestCardPT, "Closest Estimate", $lblBestCardES)
    TtfBestSub        = @("(Recorde de Sua Sorte)", "(Your Luck Record)", "(Record de Tu Suerte)")
    TtfSoloHeader     = @($lblSoloCardPT, "Latest Mined Block", $lblSoloCardES)
    TtfSoloSub        = @($lblSoloSubPT, "(By a Solo Miner just like You!)", "(Por un Minero Solo igual a Ti!)")
    TtfSoloBlockLbl   = @("Bloco:", "Block:", "Bloque:")
    TtfSoloPrizeLbl   = @($lblSoloPrizePT, "Reward:", "Premio:")
    TtfSoloWait       = @("Consultando rede Bitcoin...", "Querying Bitcoin network...", "Consultando red Bitcoin...")
    TtfDate           = @("Data:", "Date:", "Fecha:")
    TtfLuck           = @("Sua Sorte:", "Your Luck:", "Tu Suerte:")
    TtfPower          = @("Poder:", "Power:", "Poder:")
    AlertWinTitle     = @("SUCESSO ABSOLUTO", "ABSOLUTE SUCCESS", "EXITO ABSOLUTO")
    AlertHeader       = @("VOCE ENCONTROU UM BLOCO!!!", "YOU FOUND A BLOCK!!!", "ENCONTRASTE UN BLOQUE!!!")
    AlertBlockHeight  = @("Bloco (altura):", "Block (height):", "Bloque (altura):")
    AlertCheckWallet  = @("Confira a carteira", "Check wallet", "Verifica la billetera")
    AlertRewardInfo   = @("Seu premio em Bitcoin estara disponivel apos 100 Blocos (~24 horas).", "Your Bitcoin reward will be available after 100 Blocks (~24 hours).", "Tu premio en Bitcoin estara disponible tras 100 Bloques (~24 horas).")
    AlertLogInfo      = @("Confira o registro no Log", "Check the record in Log", "Verifica el registro en el Log")
    AlertInFolder     = @("na pasta do MinerIsma.", "in the MinerIsma folder.", "en la carpeta de MinerIsma.")
}

function Get-Text {
    param([string]$Key)
    $arr = $global:LangTable[$Key]
    if ($null -eq $arr) { return $Key }
    if ($arr -is [array]) {
        $idx = switch ($global:Language) { "EN" { 1 } "ES" { 2 } default { 0 } }
        $val = $arr[$idx]
        if ([string]::IsNullOrWhiteSpace($val)) { $val = $arr[0] }
        return [string]$val
    }
    return [string]$arr
}

# ================================================================
#  4. INICIALIZACAO DO SISTEMA E CAMINHOS
# ================================================================
Add-Type -AssemblyName System.Windows.Forms, System.Drawing, PresentationCore
[System.Windows.Forms.Application]::EnableVisualStyles()

$global:AppVersion          = "MinerIsma_v2.1.2 - Alpha"
$global:VersionNumber       = "2.1.2"
$global:ShortVersion        = "MinerIsma v2.1.2"
$global:BtcSym              = [string][char]0x20BF
$global:BoltSym             = [string][char]0x26A1
$global:StarSym             = [string][char]0x2605
$global:BlockSym            = [string][char]0x25A0
$global:UpdateSym           = [string][char]0x27F3
$global:GlobeSym            = [char]::ConvertFromUtf32(0x1F310)
$global:UpdateAvailable     = $false
$global:LatestRemoteVersion = ""
$global:VersionCheckDone    = $false
$global:Theme               = "Dark"
$global:ColorObsidian       = [System.Drawing.Color]::FromArgb(16, 21, 28)
$global:ColorPearl          = [System.Drawing.Color]::FromArgb(244, 241, 234)
$global:ColorBronzeBorder   = [System.Drawing.Color]::FromArgb(90, 60, 24)

$global:BasePath         = $PSScriptRoot
$global:RootPath         = Split-Path -Parent $global:BasePath
$global:ResPath          = Join-Path $global:RootPath "resources"
$global:BackupDir        = Join-Path $env:LOCALAPPDATA "MinerIsma"
foreach ($dir in @($global:ResPath, $global:BackupDir)) {
    if (-not (Test-Path $dir)) { try { New-Item -ItemType Directory -Path $dir -Force | Out-Null } catch {} }
}

# Desbloqueia preventivamente todos os arquivos (.mp3, .html, .ico, .exe, .dll) contra restricoes Zone.Identifier do Windows
try { Get-ChildItem -Path $global:RootPath -Recurse -File -ErrorAction SilentlyContinue | Unblock-File -ErrorAction SilentlyContinue } catch {}

$global:MinerExe         = Join-Path $global:BasePath $global:MinerExeName
$global:LauncherPath     = Join-Path $global:RootPath $global:LauncherFileName
$global:LogFile          = Join-Path $global:RootPath "BLOCK_FOUND_LOG.txt"
$global:TtfLogFile       = Join-Path $global:ResPath "MinerIsma_TTF_LOG.txt"
$global:LegacyTtfLogFile = Join-Path $global:ResPath "TTF_BLOCO_LOG.txt"
$global:ErrorLog         = Join-Path $global:ResPath "MinerManager_ERROS.log"
$global:ConfigFile       = Join-Path $global:ResPath "MinerIsma_Config.json"
$global:TutorialFile     = Join-Path $global:ResPath $global:TutorialFileName
$global:CustomIconPath   = Join-Path $global:ResPath $global:CustomIconFileName
$global:DonateQrPath     = Join-Path $global:ResPath $global:DonateQrFileName
$global:BackupConfigFile = Join-Path $global:BackupDir "MinerIsma_Config.json"
$global:BackupTtfLogFile = Join-Path $global:BackupDir "MinerIsma_TTF_LOG.txt"

try {
    if ((Test-Path -LiteralPath $global:LegacyTtfLogFile) -and (-not (Test-Path -LiteralPath $global:TtfLogFile))) {
        Move-Item -LiteralPath $global:LegacyTtfLogFile -Destination $global:TtfLogFile -Force -ErrorAction SilentlyContinue
    }
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

$global:StartupFolder       = [Environment]::GetFolderPath("Startup")
$global:ShortcutPath        = Join-Path $global:StartupFolder "MinerIsma.lnk"
$global:DesktopFolder       = [Environment]::GetFolderPath("Desktop")
$global:DesktopShortcutPath = Join-Path $global:DesktopFolder "MinerIsma.lnk"
$global:RunRegKey           = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
$global:RunRegName          = "MinerIsma"

$global:DefaultThreads      = if ($global:LogicalCores -ge 16) { 4 } else { 3 }
$global:ConfiguredDelay     = $global:DefaultStartupDelay
$global:StartupInitialized  = $false
$global:StartupEnabled      = $true
$global:SavedPulseMode      = ""
$global:CurrentBlockHeight  = 0
$global:LastSoloBlockHeight = 0
$global:LastSoloBlockTime   = ""
$global:LastSoloBlockPool   = ""
$global:LastSoloBlockReward = ""

if (Test-Path $global:ConfigFile) {
    try {
        $cfg = Get-Content $global:ConfigFile -Raw | ConvertFrom-Json
        if (($null -ne $cfg.LastThreads) -and ($global:ThreadProfiles.Contains([int]$cfg.LastThreads))) { $global:DefaultThreads = [int]$cfg.LastThreads }
        if (-not [string]::IsNullOrWhiteSpace($cfg.Wallet)) {
            $savedAddr = ($cfg.Wallet -replace '\..*?$', '').Trim()
            if ((-not [string]::IsNullOrWhiteSpace($savedAddr)) -and ($savedAddr -ne "minha_carteira")) { $global:Wallet = [string]$cfg.Wallet }
        }
        if (-not [string]::IsNullOrWhiteSpace($cfg.PoolUrl)) { $global:PoolUrl = [string]$cfg.PoolUrl }
        if ($null -ne $cfg.ExtraArgs) { $global:ExtraArgs = [string]$cfg.ExtraArgs }
        if ($null -ne $cfg.StartupDelay -and ([int]$cfg.StartupDelay -in @(5, 15, 30, 60))) { $global:ConfiguredDelay = [int]$cfg.StartupDelay }
        if ($cfg.SoundFileName -in @($global:SoundFileKMS, $global:SoundFileSenna, $global:SoundFileMforN, $global:SoundFileCoins)) { $global:SoundFileName = [string]$cfg.SoundFileName }
        if ($null -ne $cfg.StartupInitialized) { $global:StartupInitialized = [bool]$cfg.StartupInitialized }
        if ($null -ne $cfg.StartupEnabled) { $global:StartupEnabled = [bool]$cfg.StartupEnabled }
        if ($cfg.PulseMode -in @("2hx5", "4hx5")) { $global:SavedPulseMode = [string]$cfg.PulseMode }
        if ($cfg.Language -in @("PT", "EN", "ES")) { $global:Language = [string]$cfg.Language }
        if ($cfg.Theme -in @("Dark", "Light")) { $global:Theme = [string]$cfg.Theme }
        if (($null -ne $cfg.LastBlockHeight) -and ([int]$cfg.LastBlockHeight -gt 840000)) { $global:CurrentBlockHeight = [int]$cfg.LastBlockHeight }
        if (($null -ne $cfg.LastSoloBlockHeight) -and ([int]$cfg.LastSoloBlockHeight -gt 840000)) {
            $global:LastSoloBlockHeight = [int]$cfg.LastSoloBlockHeight
            $global:LastSoloBlockTime   = [string]$cfg.LastSoloBlockTime
            $global:LastSoloBlockPool   = [string]$cfg.LastSoloBlockPool
            $global:LastSoloBlockReward = [string]$cfg.LastSoloBlockReward
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
$global:LastUsdBrlFormatted = ""
$global:LastUsdEurFormatted = ""

# Referencias das janelas independentes (nao-modais)
$global:tutForm    = $null
$global:walletForm = $null
$global:statForm   = $null
$global:donForm    = $null
$global:advForm    = $null
$global:alertForm  = $null

if ($global:SavedPulseMode -in @("2hx5", "4hx5")) {
    $global:PulseMode       = $global:SavedPulseMode
    $global:PulseActiveMins = if ($global:SavedPulseMode -eq "2hx5") { 120 } else { 240 }
    $global:PulsePauseMins  = 5
    $global:PulseNextSwitch = (Get-Date).AddMinutes($global:PulseActiveMins)
}

$global:TtfLogAllowedAt    = (Get-Date).AddSeconds($global:TtfWarmupSeconds)
$global:Visible            = $false
$global:BlockFoundLine     = $null
$global:CurrentThreads     = $global:DefaultThreads
$global:RestartAt          = $null
$global:CrashNotified      = $false
$global:StopRequested      = $false
$global:SoundPlayer        = $null
$global:SfxPlayer          = $null
$global:LastTtfLogged      = ""
$global:DetectedMinerExe   = $global:MinerExeName
$global:WalletWarningShown = $false
$global:LogQueue           = New-Object System.Collections.Concurrent.ConcurrentQueue[string]
$global:RecentLines        = New-Object System.Collections.Generic.Queue[string]

function Play-EffectSound {
    param([string]$SfxFileName)
    if ([string]::IsNullOrWhiteSpace($SfxFileName)) { return }
    try {
        $sfxPath = Join-Path $global:ResPath $SfxFileName
        if (Test-Path -LiteralPath $sfxPath) {
            if ($null -ne $global:SfxPlayer) { try { $global:SfxPlayer.Stop(); $global:SfxPlayer.Close() } catch {} }
            $global:SfxPlayer = New-Object System.Windows.Media.MediaPlayer
            $global:SfxPlayer.Open([Uri]$sfxPath)
            $global:SfxPlayer.Play()
        }
    } catch {}
}

# ============================================================
# API DO WINDOWS (THREADS + DWM + ICONE TASKBAR + MENU E SCROLLBAR)
# ============================================================
Add-Type -ReferencedAssemblies System.Windows.Forms, System.Drawing -TypeDefinition @"
using System;
using System.Drawing;
using System.Windows.Forms;
using System.Runtime.InteropServices;

[StructLayout(LayoutKind.Sequential)]
public struct DwmRect { public int Left; public int Top; public int Right; public int Bottom; }

public class ProcCtl {
    [DllImport("kernel32.dll")] public static extern IntPtr OpenThread(int access, bool inherit, uint tid);
    [DllImport("kernel32.dll")] public static extern uint SuspendThread(IntPtr hThread);
    [DllImport("kernel32.dll")] public static extern int ResumeThread(IntPtr hThread);
    [DllImport("kernel32.dll")] public static extern bool CloseHandle(IntPtr h);
    [DllImport("kernel32.dll")] public static extern IntPtr GetConsoleWindow();
    [DllImport("dwmapi.dll")] public static extern int DwmSetWindowAttribute(IntPtr hwnd, int attr, ref int attrValue, int attrSize);
    [DllImport("dwmapi.dll")] public static extern int DwmGetWindowAttribute(IntPtr hwnd, int attr, out DwmRect rect, int rectSize);
    [DllImport("user32.dll")] public static extern IntPtr SendMessage(IntPtr hWnd, int msg, IntPtr wParam, IntPtr lParam);
    [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
    public static extern IntPtr LoadImage(IntPtr hinst, string lpszName, uint uType, int cxDesired, int cyDesired, uint fuLoad);
    [DllImport("shell32.dll", SetLastError = true)]
    public static extern int SetCurrentProcessExplicitAppUserModelID([MarshalAs(UnmanagedType.LPWStr)] string AppID);
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
        return Math.Max(1, TargetBox.ClientSize.Height / Math.Max(12, TargetBox.Font.Height));
    }
    private int GetTotalLines() {
        if (TargetBox == null || !TargetBox.IsHandleCreated) return 1;
        return Math.Max(1, (int)ProcCtl.SendMessage(TargetBox.Handle, 0x00BA, IntPtr.Zero, IntPtr.Zero));
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
        if (total <= vis) return new Rectangle(2, trackTop, this.Width - 4, trackH);
        int thumbH = Math.Max(26, (int)((double)vis / total * trackH));
        int maxFirst = Math.Max(1, total - vis);
        int first = Math.Min(maxFirst, GetFirstVisibleLine());
        int availH = Math.Max(1, trackH - thumbH);
        return new Rectangle(2, trackTop + (int)((double)first / maxFirst * availH), this.Width - 4, thumbH);
    }
    protected override void OnPaint(PaintEventArgs e) {
        Graphics g = e.Graphics;
        g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
        Color trackCol      = IsLightMode ? Color.FromArgb(232, 226, 214) : Color.FromArgb(16, 21, 28);
        Color thumbCol      = IsLightMode ? Color.FromArgb(196, 176, 148) : Color.FromArgb(42, 32, 20);
        Color thumbHoverCol = IsLightMode ? Color.FromArgb(168, 142, 108) : Color.FromArgb(68, 48, 26);

        using (SolidBrush bTrack = new SolidBrush(trackCol)) { g.FillRectangle(bTrack, this.ClientRectangle); }
        using (Pen pBorder = new Pen(borderCol, 1)) {
            g.DrawLine(pBorder, 0, 0, 0, this.Height);
            g.DrawRectangle(pBorder, 0, 0, this.Width - 1, arrowHeight - 1);
            g.DrawRectangle(pBorder, 0, this.Height - arrowHeight, this.Width - 1, arrowHeight - 1);
        }
        using (SolidBrush bArrow = new SolidBrush(arrowCol)) {
            g.FillPolygon(bArrow, new Point[] { new Point(this.Width / 2, 4), new Point(4, arrowHeight - 4), new Point(this.Width - 4, arrowHeight - 4) });
            g.FillPolygon(bArrow, new Point[] { new Point(this.Width / 2, this.Height - 4), new Point(4, this.Height - arrowHeight + 4), new Point(this.Width - 4, this.Height - arrowHeight + 4) });
        }
        Rectangle tr = GetThumbRect();
        using (SolidBrush bThumb = new SolidBrush((isDragging || isHoverThumb) ? thumbHoverCol : thumbCol)) { g.FillRectangle(bThumb, tr); }
        using (Pen pThumb = new Pen(borderCol, 1)) { g.DrawRectangle(pThumb, tr.X, tr.Y, tr.Width - 1, tr.Height - 1); }
    }
    private void ScrollTargetLines(int deltaLines) {
        if (TargetBox == null || !TargetBox.IsHandleCreated || deltaLines == 0) return;
        ProcCtl.SendMessage(TargetBox.Handle, 0x00B6, IntPtr.Zero, (IntPtr)deltaLines);
        this.Invalidate();
    }
    protected override void OnMouseDown(MouseEventArgs e) {
        base.OnMouseDown(e);
        if (e.Button != MouseButtons.Left || TargetBox == null) return;
        if (e.Y < arrowHeight) { ScrollTargetLines(-3); return; }
        if (e.Y > this.Height - arrowHeight) { ScrollTargetLines(3); return; }
        Rectangle tr = GetThumbRect();
        if (tr.Contains(e.Location)) { isDragging = true; dragOffsetY = e.Y - tr.Y; this.Invalidate(); }
        else if (e.Y < tr.Y) { ScrollTargetLines(-GetVisibleLines()); }
        else if (e.Y > tr.Bottom) { ScrollTargetLines(GetVisibleLines()); }
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
            int maxFirst = Math.Max(1, GetTotalLines() - GetVisibleLines());
            ScrollTargetLines((int)Math.Round(ratio * maxFirst) - GetFirstVisibleLine());
        } else {
            bool hov = GetThumbRect().Contains(e.Location);
            if (hov != isHoverThumb) { isHoverThumb = hov; this.Invalidate(); }
        }
    }
    protected override void OnMouseUp(MouseEventArgs e) { base.OnMouseUp(e); if (isDragging) { isDragging = false; this.Invalidate(); } }
    protected override void OnMouseLeave(EventArgs e) { base.OnMouseLeave(e); if (isHoverThumb) { isHoverThumb = false; this.Invalidate(); } }
}

public class ObsidianMenuColors : ProfessionalColorTable {
    public static bool IsLightMode = false;
    public static string CurrentLangBadge = "BR";
    public static bool IsUpdateAvailable = false;

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
    public ObsidianMenuRenderer() : base(new ObsidianMenuColors()) { this.RoundedEdges = false; }

    private void DrawUpdateBadgeInLeftMargin(Graphics g, int itemHeight) {
        Rectangle rUpd = new Rectangle(1, (itemHeight - 24) / 2 - 1, 24, 24);
        Color updCol = ObsidianMenuColors.IsLightMode ? Color.FromArgb(0, 135, 175) : Color.Cyan;
        using (Font fUpd = new Font("Segoe UI Symbol", 13.5f, FontStyle.Bold)) {
            TextRenderer.DrawText(g, "\u27F3", fUpd, rUpd, updCol, TextFormatFlags.HorizontalCenter | TextFormatFlags.VerticalCenter | TextFormatFlags.NoPadding);
        }
    }

    protected override void OnRenderMenuItemBackground(ToolStripItemRenderEventArgs e) {
        if (e.Item != null && e.Item.Name == "HeaderItem") return;
        base.OnRenderMenuItemBackground(e);
    }
    protected override void OnRenderArrow(ToolStripArrowRenderEventArgs e) {
        e.ArrowColor = Color.FromArgb(247, 147, 26);
        base.OnRenderArrow(e);
    }
    protected override void OnRenderItemText(ToolStripItemTextRenderEventArgs e) {
        if (e.Item != null && e.Item.Name == "HeaderItem") {
            int leftAlignedX = Math.Max(28, e.TextRectangle.Left);
            e.TextRectangle = new Rectangle(leftAlignedX, 0, Math.Max(80, e.Item.Width - leftAlignedX - 74), e.Item.Height);
            e.TextFormat = TextFormatFlags.Left | TextFormatFlags.VerticalCenter | TextFormatFlags.NoPadding;
            base.OnRenderItemText(e);

            Graphics g = e.Graphics;
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
            int boxH = 20, boxY = (e.Item.Height - boxH) / 2, langW = 26, themeW = 24;
            int langX = e.Item.Width - langW - 18, themeX = langX - themeW - 4;
            Rectangle rTheme = new Rectangle(themeX, boxY, themeW, boxH);
            Rectangle rLang  = new Rectangle(langX, boxY, langW, boxH);

            Color boxBg  = ObsidianMenuColors.IsLightMode ? Color.FromArgb(232, 226, 214) : Color.FromArgb(26, 33, 44);
            Color symCol = ObsidianMenuColors.IsLightMode ? Color.FromArgb(205, 102, 0) : Color.FromArgb(247, 147, 26);

            using (SolidBrush b = new SolidBrush(boxBg)) { g.FillRectangle(b, rTheme); g.FillRectangle(b, rLang); }
            using (Pen p = new Pen(Color.FromArgb(90, 60, 24), 1)) {
                g.DrawRectangle(p, rTheme.X, rTheme.Y, rTheme.Width - 1, rTheme.Height - 1);
                g.DrawRectangle(p, rLang.X, rLang.Y, rLang.Width - 1, rLang.Height - 1);
            }
            TextRenderer.DrawText(g, ObsidianMenuColors.IsLightMode ? "\u2600" : "\u263E", e.TextFont, rTheme, symCol, TextFormatFlags.HorizontalCenter | TextFormatFlags.VerticalCenter | TextFormatFlags.NoPadding);
            using (Font fLang = new Font("Segoe UI", 8.25f, FontStyle.Bold)) {
                TextRenderer.DrawText(g, ObsidianMenuColors.CurrentLangBadge, fLang, rLang, symCol, TextFormatFlags.HorizontalCenter | TextFormatFlags.VerticalCenter | TextFormatFlags.NoPadding);
            }
            if (ObsidianMenuColors.IsUpdateAvailable) DrawUpdateBadgeInLeftMargin(g, e.Item.Height);
            return;
        }
        if (e.Item != null && e.Item.Name == "UpdateSubItem") {
            base.OnRenderItemText(e);
            if (ObsidianMenuColors.IsUpdateAvailable) {
                e.Graphics.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
                DrawUpdateBadgeInLeftMargin(e.Graphics, e.Item.Height);
            }
            return;
        }
        if (e.Item != null && e.Item.Name == "ThreadItem") {
            string txt = e.Text;
            int dotIdx = txt.IndexOf('.');
            if (dotIdx > 0) {
                string prefix = txt.Substring(0, dotIdx), pattern = txt.Substring(dotIdx);
                int refPrefW = TextRenderer.MeasureText(e.Graphics, "~48% \u219210 ", e.TextFont, new Size(300, e.Item.Height), TextFormatFlags.NoPadding).Width;
                int stepX    = Math.Max(4, TextRenderer.MeasureText(e.Graphics, "!", e.TextFont, new Size(50, e.Item.Height), TextFormatFlags.NoPadding).Width + 1);

                TextRenderer.DrawText(e.Graphics, prefix, e.TextFont, new Rectangle(e.TextRectangle.Left, 0, refPrefW + 10, e.Item.Height), e.TextColor, TextFormatFlags.Left | TextFormatFlags.VerticalCenter | TextFormatFlags.NoPadding);
                Color bangCol = ObsidianMenuColors.IsLightMode ? Color.FromArgb(205, 102, 0) : Color.FromArgb(247, 147, 26);
                int startX = e.TextRectangle.Left + refPrefW;
                for (int i = 0; i < pattern.Length; i++) {
                    string ch = pattern.Substring(i, 1);
                    TextRenderer.DrawText(e.Graphics, ch, e.TextFont, new Rectangle(startX + (i * stepX), 0, stepX + 4, e.Item.Height), (ch == "!") ? bangCol : e.TextColor, TextFormatFlags.HorizontalCenter | TextFormatFlags.VerticalCenter | TextFormatFlags.NoPadding);
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
        using (SolidBrush b = new SolidBrush(ObsidianMenuColors.IsLightMode ? Color.FromArgb(255, 236, 209) : Color.FromArgb(40, 28, 14))) { g.FillRectangle(b, r); }
        using (Pen pBorder = new Pen(Color.FromArgb(247, 147, 26), 1)) { g.DrawRectangle(pBorder, r.X, r.Y, r.Width - 1, r.Height - 1); }
        using (Pen pCheck = new Pen(Color.FromArgb(247, 147, 26), 2)) {
            g.DrawLines(pCheck, new Point[] { new Point(r.Left + 3, r.Top + r.Height / 2), new Point(r.Left + r.Width / 2 - 1, r.Bottom - 4), new Point(r.Right - 3, r.Top + 4) });
        }
    }
}
"@

try { [ProcCtl]::SetCurrentProcessExplicitAppUserModelID("MinerIsma.SoloMiner.v2.1.2") | Out-Null } catch {}

# ============================================================
# FUNCOES HELPER DE INTERFACE, TEMA E CONTROLES VISUAIS
# ============================================================
function Get-WindowBgColor      { if ($global:Theme -eq "Light") { return $global:ColorPearl } return $global:ColorObsidian }
function Get-CardBgColor        { if ($global:Theme -eq "Light") { return [System.Drawing.Color]::FromArgb(236, 231, 220) } return [System.Drawing.Color]::FromArgb(12, 17, 24) }
function Get-VisorBgColor       { if ($global:Theme -eq "Light") { return [System.Drawing.Color]::FromArgb(228, 222, 210) } return [System.Drawing.Color]::FromArgb(9, 13, 18) }
function Get-PrimaryTextColor   { if ($global:Theme -eq "Light") { return [System.Drawing.Color]::FromArgb(26, 20, 14) } return [System.Drawing.Color]::White }
function Get-SecondaryTextColor { if ($global:Theme -eq "Light") { return [System.Drawing.Color]::FromArgb(85, 70, 55) } return [System.Drawing.Color]::LightGray }
function Get-AccentOrangeColor  { if ($global:Theme -eq "Light") { return [System.Drawing.Color]::FromArgb(205, 102, 0) } return [System.Drawing.Color]::FromArgb(255, 247, 147, 26) }
function Get-GoldTextColor      { if ($global:Theme -eq "Light") { return [System.Drawing.Color]::FromArgb(180, 90, 0) } return [System.Drawing.Color]::Gold }
function Get-CyanTextColor      { if ($global:Theme -eq "Light") { return [System.Drawing.Color]::FromArgb(0, 130, 165) } return [System.Drawing.Color]::Cyan }
function Get-GreenTextColor     { if ($global:Theme -eq "Light") { return [System.Drawing.Color]::FromArgb(18, 125, 48) } return [System.Drawing.Color]::LimeGreen }
function Get-DangerTextColor    { if ($global:Theme -eq "Light") { return [System.Drawing.Color]::FromArgb(195, 30, 15) } return [System.Drawing.Color]::FromArgb(255, 85, 55) }

function New-UiLabel {
    param([string]$Text, [int]$X, [int]$Y, [int]$W = 0, [int]$H = 0, $Font, $ForeCol, $BackCol = $null)
    $lbl = New-Object System.Windows.Forms.Label
    $lbl.Text = $Text
    $lbl.Location = New-Object System.Drawing.Point($X, $Y)
    if ($W -gt 0 -and $H -gt 0) {
        $lbl.Size = New-Object System.Drawing.Size($W, $H)
        $lbl.AutoSize = $false
        $lbl.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    } else {
        $lbl.AutoSize = $true
    }
    if ($null -ne $BackCol) { $lbl.BackColor = $BackCol }
    $lbl.ForeColor = $ForeCol
    $lbl.Font = $Font
    return $lbl
}

function Set-TutorialWebScrollbarTheme {
    if ($null -eq $script:tut_web -or $script:tut_web.IsDisposed) { return }
    try {
        $doc = $script:tut_web.Document
        if ($null -ne $doc) {
            $cssRules = if ($global:Theme -eq "Light") {
                "scrollbar-face-color: #C4B094 !important; scrollbar-track-color: #E8E2D6 !important; scrollbar-arrow-color: #F7931A !important; scrollbar-highlight-color: #5A3C18 !important; scrollbar-shadow-color: #5A3C18 !important; scrollbar-3dlight-color: #E8E2D6 !important; scrollbar-darkshadow-color: #5A3C18 !important;"
            } else {
                "scrollbar-face-color: #2A2014 !important; scrollbar-track-color: #10151C !important; scrollbar-arrow-color: #F7931A !important; scrollbar-highlight-color: #5A3C18 !important; scrollbar-shadow-color: #5A3C18 !important; scrollbar-3dlight-color: #10151C !important; scrollbar-darkshadow-color: #0A0E14 !important;"
            }
            if ($null -ne $doc.Body) { $doc.Body.Style = $cssRules }
            $htmlEls = $doc.GetElementsByTagName("html")
            if ($null -ne $htmlEls -and $htmlEls.Count -gt 0) { $htmlEls[0].Style = $cssRules }
            $styleEl = $doc.GetElementById("MinerIsmaScrollTheme")
            if ($null -eq $styleEl) {
                $styleEl = $doc.CreateElement("style")
                $styleEl.Id = "MinerIsmaScrollTheme"
                $heads = $doc.GetElementsByTagName("head")
                if ($null -ne $heads -and $heads.Count -gt 0) { $heads[0].AppendChild($styleEl) | Out-Null }
                elseif ($null -ne $doc.Body) { $doc.Body.AppendChild($styleEl) | Out-Null }
            }
            try { $styleEl.DomElement.styleSheet.cssText = "html, body { $cssRules }" } catch {}
        }
    } catch {}
}

function Set-WindowDarkTheme {
    param([System.Windows.Forms.Form]$Form)
    if ($null -eq $Form -or $Form.IsDisposed) { return }
    try {
        $isLight = ($global:Theme -eq "Light")
        $Form.BackColor = Get-WindowBgColor
        $Form.ShowIcon = $true
        if ($null -ne $global:AppIcon) { $Form.Icon = $global:AppIcon }
        $hwnd = $Form.Handle
        $hBig = if ($global:HIconBig -ne [IntPtr]::Zero) { $global:HIconBig } elseif ($null -ne $global:AppIcon) { $global:AppIcon.Handle } else { [IntPtr]::Zero }
        $hSml = if ($global:HIconSmall -ne [IntPtr]::Zero) { $global:HIconSmall } elseif ($null -ne $global:AppIcon) { $global:AppIcon.Handle } else { [IntPtr]::Zero }
        if ($hSml -ne [IntPtr]::Zero) { [ProcCtl]::SendMessage($hwnd, 0x0080, [IntPtr]0, $hSml) | Out-Null }
        if ($hBig -ne [IntPtr]::Zero) { [ProcCtl]::SendMessage($hwnd, 0x0080, [IntPtr]1, $hBig) | Out-Null }

        $dark = if ($isLight) { 0 } else { 1 }
        [ProcCtl]::DwmSetWindowAttribute($hwnd, 20, [ref]$dark, 4) | Out-Null
        [ProcCtl]::DwmSetWindowAttribute($hwnd, 19, [ref]$dark, 4) | Out-Null

        $borderColor  = if ($isLight) { 0x00183C5A } else { 0x0014202A }
        $captionColor = if ($isLight) { 0x00D6E2E8 } else { 0x00140E0A }
        $textColor    = if ($isLight) { 0x00005CC4 } else { 0x001A93F7 }
        [ProcCtl]::DwmSetWindowAttribute($hwnd, 34, [ref]$borderColor, 4) | Out-Null
        [ProcCtl]::DwmSetWindowAttribute($hwnd, 35, [ref]$captionColor, 4) | Out-Null
        [ProcCtl]::DwmSetWindowAttribute($hwnd, 36, [ref]$textColor, 4) | Out-Null
        if ($Form.Tag -is [scriptblock]) { & $Form.Tag }
        $Form.Invalidate($true)
        $Form.Refresh()
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
            $x = $dwmRect.Left; $y = $dwmRect.Top; $w = $dwmRect.Right - $dwmRect.Left; $h = $dwmRect.Bottom - $dwmRect.Top
        } else {
            $x = $Form.Bounds.X; $y = $Form.Bounds.Y; $w = $Form.Bounds.Width; $h = $Form.Bounds.Height
        }
        $bmp = New-Object System.Drawing.Bitmap($w, $h)
        $g = [System.Drawing.Graphics]::FromImage($bmp)
        $g.CopyFromScreen($x, $y, 0, 0, (New-Object System.Drawing.Size($w, $h)))
        $g.Dispose()
        return $bmp
    } catch { return $null }
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
    [ObsidianMenuColors]::IsUpdateAvailable = $global:UpdateAvailable

    $bgCol       = if ($isLight) { $global:ColorPearl } else { $global:ColorObsidian }
    $txtCol      = if ($isLight) { [System.Drawing.Color]::FromArgb(26, 20, 14) } else { [System.Drawing.Color]::FromArgb(230, 237, 243) }
    $btcCol      = if ($isLight) { [System.Drawing.Color]::FromArgb(205, 102, 0) } else { [System.Drawing.Color]::FromArgb(255, 247, 147, 26) }
    $lightOrgCol = if ($isLight) { [System.Drawing.Color]::FromArgb(215, 115, 20) } else { [System.Drawing.Color]::FromArgb(255, 185, 95) }
    $goldCol     = if ($isLight) { [System.Drawing.Color]::FromArgb(180, 95, 0) } else { [System.Drawing.Color]::FromArgb(255, 209, 102) }
    $updCyanCol  = if ($isLight) { [System.Drawing.Color]::FromArgb(0, 135, 175) } else { [System.Drawing.Color]::Cyan }

    $MenuStrip.Renderer  = New-Object ObsidianMenuRenderer
    $MenuStrip.BackColor = $bgCol
    $MenuStrip.ForeColor = $txtCol

    foreach ($item in $MenuStrip.Items) {
        $item.BackColor = $bgCol
        if ($item -eq $headerItem) { $item.ForeColor = $btcCol }
        elseif ($item -eq $global:btcPriceItem) { $item.ForeColor = $goldCol }
        elseif ($item -eq $global:lblPowerHeader) { $item.ForeColor = $lightOrgCol }
        else { $item.ForeColor = $txtCol }

        if ($item -is [System.Windows.Forms.ToolStripMenuItem] -and $item.HasDropDownItems) {
            $item.DropDown.BackColor = $bgCol
            $item.DropDown.ForeColor = $txtCol
            foreach ($sub in $item.DropDownItems) {
                $sub.BackColor = $bgCol
                if ($sub.Name -eq "SubHeaderLabel") { $sub.ForeColor = $lightOrgCol }
                elseif ($sub -eq $global:usdBrlPriceItem) { $sub.ForeColor = $goldCol }
                elseif (($sub -eq $global:lnkUpdates) -and $global:UpdateAvailable) { $sub.ForeColor = $updCyanCol }
                else { $sub.ForeColor = $txtCol }
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

    foreach ($frm in @($global:logForm, $global:tutForm, $global:walletForm, $global:statForm, $global:donForm, $global:advForm, $global:alertForm)) {
        if ($null -ne $frm -and (-not $frm.IsDisposed)) {
            Set-WindowDarkTheme $frm
        }
    }
    if ($null -ne $global:logScrollBar) {
        $global:logScrollBar.IsLightMode = ($global:Theme -eq "Light")
        $global:logScrollBar.Invalidate()
    }
    $global:LogQueue.Enqueue("[SISTEMA] Tema visual alterado para: $NewTheme")
}

# ============================================================
# FALLBACK INTELIGENTE DE LINKS E CHECAGEM DE BLOCO SOLO
# ============================================================
function Test-InternetConnected {
    try { return [System.Net.NetworkInformation.NetworkInterface]::GetIsNetworkAvailable() } catch { return $true }
}

function Test-UrlReachable {
    param([string]$Url)
    if ([string]::IsNullOrWhiteSpace($Url) -or (-not (Test-InternetConnected))) { return $false }
    $cleanUrl = ($Url -replace '#.*$', '').Trim()
    $curlExe = Join-Path $env:SystemRoot "System32\curl.exe"
    if (Test-Path -LiteralPath $curlExe) {
        try {
            $httpCode = & $curlExe -s -L -o NUL -w "%{http_code}" --connect-timeout 2 --max-time 3 -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/124.0.0.0" $cleanUrl 2>$null
            if ($httpCode -match "^(2\d\d|3\d\d)$") { return $true }
        } catch {}
    }
    try {
        $req = [System.Net.HttpWebRequest]::Create($cleanUrl)
        $req.Method = "GET"; $req.Timeout = 2000
        $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/124.0.0.0"
        $res = $req.GetResponse(); $res.Close()
        return $true
    } catch {}
    return $false
}

function Get-BestUpdateUrl {
    if (Test-UrlReachable $global:UrlDriveUpdates) { return [string]$global:UrlDriveUpdates }
    if (-not [string]::IsNullOrWhiteSpace($global:UrlMegaUpdates)) { return [string]$global:UrlMegaUpdates }
    return [string]$global:UrlDriveUpdates
}

function Open-UpdateDownloadLink {
    $bestUrl = Get-BestUpdateUrl
    if (-not [string]::IsNullOrWhiteSpace($bestUrl)) { try { Start-Process $bestUrl } catch {} }
}

function Open-ActivePoolDashboard {
    $addr = ($global:Wallet -replace '\..*?$', '').Trim()
    if ($global:PoolUrl -match "(?i)ckpool\.org") {
        Start-Process ("https://solostats.ckpool.org/users/" + $addr)
    } elseif ($global:PoolUrl -match "(?i)kano\.is") {
        Start-Process "https://kano.is/"
    } elseif ($global:PoolUrl -match "(?i)public-pool\.io") {
        Start-Process ($global:UrlPoolDashboard + $addr)
    } elseif ($global:PoolUrl -match "://([^:/]+)") {
        Start-Process ("https://" + $Matches[1])
    } else {
        Start-Process ($global:UrlPoolDashboard + $addr)
    }
}

$global:shareBalloonTimer = New-Object System.Windows.Forms.Timer
$global:shareBalloonTimer.Interval = 150
$global:shareBalloonTimer.Add_Tick({
    $global:shareBalloonTimer.Stop()
    try { $global:notifyIcon.ShowBalloonTip(3000, "$($global:ShortVersion)", (Get-Text "ShareCopiedShort"), [System.Windows.Forms.ToolTipIcon]::Info) } catch {}
})

function Invoke-ShareMinerIsma {
    try {
        Play-EffectSound $global:SfxShareHarpsichord
        $shareUrl = Get-BestUpdateUrl
        [System.Windows.Forms.Clipboard]::SetText([string]$shareUrl)
        if ($null -ne $global:itemCopyShareLink) { $global:itemCopyShareLink.Text = Get-Text "ShareCopiedShort" }
        $global:LogQueue.Enqueue("[SISTEMA] $(Get-Text 'ShareCopiedMsg') ($shareUrl)")
        $global:shareBalloonTimer.Stop(); $global:shareBalloonTimer.Start()
    } catch {}
}

function Open-FallbackUrlList {
    param([string[]]$Candidates)
    foreach ($u in $Candidates) {
        if (-not [string]::IsNullOrWhiteSpace($u) -and (Test-UrlReachable $u)) {
            try { Start-Process $u } catch {}
            return
        }
    }
    if ($Candidates.Count -gt 0 -and (-not [string]::IsNullOrWhiteSpace($Candidates[0]))) {
        try { Start-Process $Candidates[0] } catch {}
    }
}

function Open-HalvingLink        { Open-FallbackUrlList @($global:UrlHalving1, $global:UrlHalving2, $global:UrlHalving3) }
function Open-LightningIntroLink { Open-FallbackUrlList @($global:UrlLightningInfo1, $global:UrlLightningInfo2) }

function Fetch-UrlTextContent {
    param([string]$Url)
    if ([string]::IsNullOrWhiteSpace($Url) -or (-not (Test-InternetConnected))) { return "" }
    $curlExe = Join-Path $env:SystemRoot "System32\curl.exe"
    if (Test-Path -LiteralPath $curlExe) {
        try {
            $out = & $curlExe -s -L --connect-timeout 2 --max-time 3 -H "Cache-Control: no-cache" -H "Pragma: no-cache" -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36" $Url 2>$null
            if ($null -ne $out) {
                $txt = ($out -join "`n").Trim()
                if (-not [string]::IsNullOrWhiteSpace($txt)) { return $txt }
            }
        } catch {}
    }
    try {
        try { [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12 -bor 3072 -bor 12288 } catch {}
        $req = [System.Net.HttpWebRequest]::Create($Url)
        $req.Method = "GET"; $req.Timeout = 2500
        $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"
        $req.Headers.Add("Cache-Control", "no-cache")
        $res = $req.GetResponse(); $stream = $res.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($stream)
        $txt = $reader.ReadToEnd()
        $reader.Close(); $stream.Close(); $res.Close()
        if (-not [string]::IsNullOrWhiteSpace($txt)) { return $txt.Trim() }
    } catch {}
    return ""
}

function Extract-VersionFromText {
    param([string]$Content)
    if ([string]::IsNullOrWhiteSpace($Content)) { return $null }
    $searchTarget = $Content
    if ($Content -match "(?i)<html|<!doctype") {
        if ($Content -match '(?is)<div[^>]*class="[^"]*entry-text[^"]*"[^>]*>(.*?)</div>') { $searchTarget = $Matches[1] -replace '<[^>]+>', ' ' }
        elseif ($Content -match '(?is)<article[^>]*>(.*?)</article>') { $searchTarget = $Matches[1] -replace '<[^>]+>', ' ' }
        elseif ($Content -match '(?is)<meta[^>]*name="description"[^>]*content="([^"]+)"') { $searchTarget = $Matches[1] }
        else { return $null }
    }
    if ($searchTarget -match "(?i)\bv?(\d+\.\d+(?:\.\d+)*)\b") { return $Matches[1] }
    return $null
}

function Check-MinerUpdate {
    if ([string]::IsNullOrWhiteSpace($global:VersionCheckUrl) -or (-not (Test-InternetConnected))) { return }
    try {
        $baseUrl = $global:VersionCheckUrl.Trim().TrimEnd('/')
        $urlsToTry = @()
        if ($baseUrl -match "^https?://rentry\.(co|org)/[^/]+$") {
            $altHost = if ($baseUrl -match "rentry\.co") { $baseUrl -replace "rentry\.co", "rentry.org" } else { $baseUrl -replace "rentry\.org", "rentry.co" }
            $urlsToTry += @("$baseUrl/raw", "$altHost/raw", $baseUrl, $altHost)
        } else { $urlsToTry += $baseUrl }

        $remoteVerStr = $null
        foreach ($u in $urlsToTry) {
            $parsedVer = Extract-VersionFromText (Fetch-UrlTextContent $u)
            if (-not [string]::IsNullOrWhiteSpace($parsedVer)) { $remoteVerStr = $parsedVer; break }
        }

        if (-not [string]::IsNullOrWhiteSpace($remoteVerStr)) {
            if ([version]$remoteVerStr -gt [version]$global:VersionNumber) {
                $wasAvail = $global:UpdateAvailable
                $global:UpdateAvailable = $true; $global:LatestRemoteVersion = $remoteVerStr
                [ObsidianMenuColors]::IsUpdateAvailable = $true
                if ($null -ne $global:lnkUpdates) { $global:lnkUpdates.Text = "$(Get-Text 'LinkUpdates') (v$remoteVerStr)" }
                Set-MenuObsidianTheme $menu
                if (-not $wasAvail) { $global:LogQueue.Enqueue("[SISTEMA] Nova versao disponivel para download: v$remoteVerStr (atual: v$($global:VersionNumber))") }
            } else {
                $global:UpdateAvailable = $false; [ObsidianMenuColors]::IsUpdateAvailable = $false
                if ($null -ne $global:lnkUpdates) { $global:lnkUpdates.Text = Get-Text "LinkUpdates" }
                Set-MenuObsidianTheme $menu
                if (-not $global:VersionCheckDone) { $global:LogQueue.Enqueue("[SISTEMA] Checagem de atualizacao: v$($global:VersionNumber) atualizada (remota: v$remoteVerStr)") }
            }
            $global:VersionCheckDone = $true
        }
    } catch {}
}

function Check-LastSoloBlock {
    if (-not (Test-InternetConnected)) { return }
    $soloPools = [ordered]@{
        "Public Pool" = "https://mempool.space/api/v1/mining/pool/public-pool/blocks"
        "Solo CK"     = "https://mempool.space/api/v1/mining/pool/solock/blocks"
        "Kano Solo"   = "https://mempool.space/api/v1/mining/pool/kano/blocks"
    }
    $bestHeight = $global:LastSoloBlockHeight; $bestTime = $global:LastSoloBlockTime
    $bestPool = $global:LastSoloBlockPool; $bestReward = $global:LastSoloBlockReward; $updatedNow = $false

    foreach ($entry in $soloPools.GetEnumerator()) {
        try {
            $rawJson = Fetch-UrlTextContent ([string]$entry.Value)
            if (-not [string]::IsNullOrWhiteSpace($rawJson) -and $rawJson.StartsWith("[")) {
                $blocks = $rawJson | ConvertFrom-Json
                if (($null -ne $blocks) -and ($blocks.Count -gt 0)) {
                    $b = $blocks[0]; $bHeight = [int]$b.height
                    if ($bHeight -gt $bestHeight) {
                        $bestHeight = $bHeight; $bestPool = [string]$entry.Key
                        $bestTime = ([DateTimeOffset]::FromUnixTimeSeconds([long]$b.timestamp)).LocalDateTime.ToString("yyyy-MM-dd HH:mm")
                        $bestReward = if (($null -ne $b.extras) -and ($null -ne $b.extras.reward)) {
                            (([double]$b.extras.reward) / 100000000.0).ToString("N3", [System.Globalization.CultureInfo]::InvariantCulture) + " BTC"
                        } else { "3.125+ BTC" }
                        $updatedNow = $true
                    }
                }
            }
        } catch {}
    }

    if ($updatedNow -and ($bestHeight -gt 0)) {
        $isNewDiscovery = ($global:LastSoloBlockHeight -gt 0) -and ($bestHeight -gt $global:LastSoloBlockHeight)
        $global:LastSoloBlockHeight = $bestHeight; $global:LastSoloBlockTime = $bestTime
        $global:LastSoloBlockPool = $bestPool; $global:LastSoloBlockReward = $bestReward
        Save-MinerConfig
        $global:LogQueue.Enqueue("[SISTEMA] Ultimo Bloco Miner Solo na rede: #$bestHeight ($bestPool) em $bestTime | Premio: $bestReward")
        if ($null -ne $global:statForm -and (-not $global:statForm.IsDisposed) -and ($null -ne $script:stat_populateVisors)) {
            try { & $script:stat_populateVisors } catch {}
        }
        if ($isNewDiscovery) {
            try { $global:notifyIcon.ShowBalloonTip(6000, "$($global:ShortVersion) - Bloco Solo na Rede!", "Um Minerador Solo ($bestPool) encontrou o Bloco #$bestHeight ($bestReward)!", [System.Windows.Forms.ToolTipIcon]::Info) } catch {}
        }
    }
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
        if (Test-Path -LiteralPath $prefFile) { Remove-Item -LiteralPath $prefFile -Force -ErrorAction SilentlyContinue }

        $q = [char]34
        $appArgs = "--user-data-dir=$q$gameProfileDir$q --app=$q$Url$q --window-size=$winW,$winH --window-position=$posX,$posY --no-first-run --no-default-browser-check"
        $browsers = @(
            (Join-Path ${env:ProgramFiles(x86)} "Microsoft\Edge\Application\msedge.exe"),
            (Join-Path $env:ProgramFiles "Microsoft\Edge\Application\msedge.exe"),
            (Join-Path $env:ProgramFiles "Google\Chrome\Application\chrome.exe"),
            (Join-Path ${env:ProgramFiles(x86)} "Google\Chrome\Application\chrome.exe")
        )
        foreach ($bp in $browsers) {
            if (($null -ne $bp) -and (Test-Path -LiteralPath $bp)) { Start-Process -FilePath $bp -ArgumentList $appArgs; return }
        }
        Start-Process $Url
    } catch { try { Start-Process $Url } catch {} }
}

function Initialize-CpuDetection {
    try {
        $cpuName = (Get-CimInstance Win32_Processor | Select-Object -First 1).Name
        $global:LogQueue.Enqueue("[SISTEMA] Processador detectado: $cpuName ($($global:LogicalCores) Threads)")
        $bestExe = $global:MinerExeName

        if ($cpuName -match "AMD") {
            if ($cpuName -match "Ryzen.+ ([789]\d{3}|AI\s*[3579]\d{2})") { $bestExe = "cpuminer-avx512-sha-vaes.exe" }
            elseif ($cpuName -match "Ryzen.+ [56]\d{3}")                 { $bestExe = "cpuminer-avx2-sha-vaes.exe" }
            elseif ($cpuName -match "Ryzen|EPYC|Threadripper")           { $bestExe = "cpuminer-avx2-sha.exe" }
        } elseif ($cpuName -match "Intel") {
            if ($cpuName -match "Core.*Ultra|i\d-(1[2-9]|[2-9]\d)\d{3}") { $bestExe = "cpuminer-avx2-sha-vaes.exe" }
            elseif ($cpuName -match "i\d-11\d{3}")                       { $bestExe = "cpuminer-avx512-sha-vaes.exe" }
            elseif ($cpuName -match "i\d-(10|[4-9])\d{3}")               { $bestExe = "cpuminer-avx2.exe" }
            elseif ($cpuName -match "i\d-[23]\d{3}")                     { $bestExe = "cpuminer-avx.exe" }
        }

        $testPath = Join-Path $global:BasePath $bestExe
        if (Test-Path $testPath) {
            $global:DetectedMinerExe = $bestExe; $global:MinerExe = $testPath
            $global:LogQueue.Enqueue("[SISTEMA] Motor Otimizado Selecionado: $bestExe")
        } else {
            $global:LogQueue.Enqueue("[SISTEMA] Motor ($bestExe) nao encontrado. Usando curinga: $($global:MinerExeName)")
            $global:DetectedMinerExe = $global:MinerExeName; $global:MinerExe = Join-Path $global:BasePath $global:DetectedMinerExe
        }
    } catch {
        $global:LogQueue.Enqueue("[SISTEMA] Falha na auto-deteccao de CPU. Usando curinga padrao.")
        $global:DetectedMinerExe = $global:MinerExeName; $global:MinerExe = Join-Path $global:BasePath $global:DetectedMinerExe
    }
}

# ============================================================
# JANELAS INDEPENDENTES COM ESCOPO PERSISTENTE ($script:...)
# ============================================================
function Test-WalletConfigured {
    if ([string]::IsNullOrWhiteSpace($global:Wallet)) { return $false }
    $addr = ($global:Wallet -replace '\..*?$', '').Trim()
    return ((-not [string]::IsNullOrWhiteSpace($addr)) -and ($addr -ne "minha_carteira"))
}

function Save-MinerConfig {
    try {
        $jsonOut = @{
            LastThreads         = $global:CurrentThreads
            Wallet              = $global:Wallet
            PoolUrl             = $global:PoolUrl
            ExtraArgs           = $global:ExtraArgs
            StartupDelay        = $global:ConfiguredDelay
            SoundFileName       = $global:SoundFileName
            StartupInitialized  = $global:StartupInitialized
            StartupEnabled      = $global:StartupEnabled
            PulseMode           = $global:PulseMode
            Language            = $global:Language
            Theme               = $global:Theme
            LastBlockHeight     = $global:CurrentBlockHeight
            LastSoloBlockHeight = $global:LastSoloBlockHeight
            LastSoloBlockTime   = $global:LastSoloBlockTime
            LastSoloBlockPool   = $global:LastSoloBlockPool
            LastSoloBlockReward = $global:LastSoloBlockReward
        } | ConvertTo-Json
        $jsonOut | Out-File -FilePath $global:ConfigFile -Encoding utf8
        $jsonOut | Out-File -FilePath $global:BackupConfigFile -Encoding utf8
    } catch {}
}

function Show-SupportDialog {
    if ($null -ne $global:donForm -and (-not $global:donForm.IsDisposed)) {
        if ($global:donForm.WindowState -eq "Minimized") { $global:donForm.WindowState = "Normal" }
        $global:donForm.Activate(); return
    }
    $global:donForm = New-Object System.Windows.Forms.Form
    $global:donForm.Text = "$($global:ShortVersion) - $(Get-Text 'DonateWinTitle')"
    $global:donForm.Size = New-Object System.Drawing.Size(820, 435)
    $global:donForm.StartPosition = "CenterScreen"; $global:donForm.BackColor = Get-WindowBgColor
    $global:donForm.FormBorderStyle = "FixedSingle"; $global:donForm.MaximizeBox = $false
    $global:donForm.ShowIcon = $true; $global:donForm.ShowInTaskbar = $true; $global:donForm.Icon = $global:AppIcon

    $colorBitcoin = Get-AccentOrangeColor
    $fHdr  = New-Object System.Drawing.Font("Segoe UI", 13.5, [System.Drawing.FontStyle]::Bold)
    $fWarn = New-Object System.Drawing.Font("Segoe UI", 10.5, [System.Drawing.FontStyle]::Bold)
    $script:don_lblHeader  = New-UiLabel (Get-Text "DonateWinTitle") 24 12 756 26 $fHdr $colorBitcoin
    $script:don_lblWarnCam = New-UiLabel (Get-Text "DonateCamWarn") 24 364 756 22 $fWarn $colorBitcoin

    $qrCandidates = @(
        $global:DonateQrPath,
        (Join-Path $global:ResPath "QRcode-LNURL-BTC_On-EVM-2300x720dpi.png"),
        (Join-Path $global:ResPath "QRcode-LNURL-BTC_On-EVM-1800x580_450dpi.png"),
        (Join-Path $global:ResPath "QRcode-LNURL-BTC_On-EVM-1800x580_450dpi.jpg"),
        (Join-Path $global:ResPath "QRcode_LNURL-BTC_On-EVM_4000x1300dpi.png")
    )
    $script:don_picQr = New-Object System.Windows.Forms.PictureBox
    $script:don_picQr.Location = New-Object System.Drawing.Point(25, 45); $script:don_picQr.Size = New-Object System.Drawing.Size(754, 243)
    $script:don_picQr.BackColor = [System.Drawing.Color]::White; $script:don_picQr.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::Zoom
    $script:don_qrImgObj = $null
    foreach ($cand in $qrCandidates) {
        if (Test-Path -LiteralPath $cand) {
            try { $script:don_qrImgObj = [System.Drawing.Image]::FromFile($cand); $script:don_picQr.Image = $script:don_qrImgObj } catch {}
            break
        }
    }

    $global:donForm.Add_Paint({
        param($s, $e)
        $pBronze = New-Object System.Drawing.Pen($global:ColorBronzeBorder, 1)
        $e.Graphics.DrawRectangle($pBronze, 24, 44, 755, 244)
        $pBronze.Dispose()
    })

    function New-DonateNetworkButton {
        param([int]$PosX, [string]$Line1, [string]$Line2, [string]$CopyValue, [bool]$IsBtcBtn = $false)
        $btn = New-Object System.Windows.Forms.Button
        $btn.Location = New-Object System.Drawing.Point($PosX, 300); $btn.Size = New-Object System.Drawing.Size(224, 54)
        Set-ObsidianButtonStyle $btn $false; $btn.Text = ""
        $btn.Tag = @{ Line1 = $Line1; OrigLine1 = $Line1; Line2 = $Line2; CopyValue = $CopyValue; IsBtc = $IsBtcBtn; IsCopied = $false }
        $btn.Add_Paint({
            param($sender, $e)
            $g = $e.Graphics; $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
            $meta = $sender.Tag
            $mainCol = if ($meta.IsCopied) { Get-GreenTextColor } else { Get-PrimaryTextColor }
            $subCol  = Get-GoldTextColor
            $orgCol  = Get-AccentOrangeColor

            $fLine1 = New-Object System.Drawing.Font("Segoe UI", 10.5, [System.Drawing.FontStyle]::Bold)
            $fBtc   = New-Object System.Drawing.Font("Segoe UI", 13.5, [System.Drawing.FontStyle]::Bold)
            $fLine2 = New-Object System.Drawing.Font("Consolas", 9.25, [System.Drawing.FontStyle]::Bold)
            $flags  = [System.Windows.Forms.TextFormatFlags]::HorizontalCenter -bor [System.Windows.Forms.TextFormatFlags]::VerticalCenter -bor [System.Windows.Forms.TextFormatFlags]::NoPadding

            if ($meta.IsBtc -and (-not $meta.IsCopied)) {
                $symTxt = "$($global:BtcSym) "; $restTxt = "Bitcoin On-Chain"
                $symSize  = [System.Windows.Forms.TextRenderer]::MeasureText($g, $symTxt, $fBtc, (New-Object System.Drawing.Size(200, 26)), [System.Windows.Forms.TextFormatFlags]::NoPadding)
                $restSize = [System.Windows.Forms.TextRenderer]::MeasureText($g, $restTxt, $fLine1, (New-Object System.Drawing.Size(200, 26)), [System.Windows.Forms.TextFormatFlags]::NoPadding)
                $startX   = [int](($sender.Width - ($symSize.Width + $restSize.Width)) / 2)
                $leftFlags = [System.Windows.Forms.TextFormatFlags]::Left -bor [System.Windows.Forms.TextFormatFlags]::VerticalCenter -bor [System.Windows.Forms.TextFormatFlags]::NoPadding
                [System.Windows.Forms.TextRenderer]::DrawText($g, $symTxt, $fBtc, (New-Object System.Drawing.Rectangle($startX, 1, ($symSize.Width + 4), 28)), $orgCol, $leftFlags)
                [System.Windows.Forms.TextRenderer]::DrawText($g, $restTxt, $fLine1, (New-Object System.Drawing.Rectangle(($startX + $symSize.Width), 3, ($restSize.Width + 6), 26)), $mainCol, $leftFlags)
            } else {
                [System.Windows.Forms.TextRenderer]::DrawText($g, [string]$meta.Line1, $fLine1, (New-Object System.Drawing.Rectangle(2, 3, ($sender.Width - 4), 26)), $mainCol, $flags)
            }
            [System.Windows.Forms.TextRenderer]::DrawText($g, [string]$meta.Line2, $fLine2, (New-Object System.Drawing.Rectangle(2, 28, ($sender.Width - 4), 22)), $subCol, $flags)
            $fLine1.Dispose(); $fBtc.Dispose(); $fLine2.Dispose()
        })
        return $btn
    }

    $script:don_btnLn  = New-DonateNetworkButton 25  "$($global:BoltSym) Lightning BTC" "isma@coinos.io" $global:DonateAddrLightning $false
    $script:don_btnBtc = New-DonateNetworkButton 290 "$($global:BtcSym) Bitcoin On-Chain" (Get-Text "DonateBtcSub") $global:DonateAddrBtcOnChain $true
    $script:don_btnEvm = New-DonateNetworkButton 555 "$($global:GlobeSym) Ethereum EVM" ("USD " + [string][char]0x2192 + " ARB/BASE/BNB/POL") $global:DonateAddrEvm $false

    foreach ($b in @($script:don_btnLn, $script:don_btnBtc, $script:don_btnEvm)) {
        $b.Add_Click({
            try {
                foreach ($other in @($script:don_btnLn, $script:don_btnBtc, $script:don_btnEvm)) {
                    if ($null -ne $other -and $null -ne $other.Tag) {
                        $other.Tag.IsCopied = $false; $other.Tag.Line1 = $other.Tag.OrigLine1; $other.Invalidate()
                    }
                }
                [System.Windows.Forms.Clipboard]::SetText([string]$this.Tag.CopyValue)
                $this.Tag.IsCopied = $true; $this.Tag.Line1 = Get-Text "AddrCopiedShort"; $this.Invalidate()
                Play-EffectSound $global:SfxDonateRing
                $global:LogQueue.Enqueue("[SISTEMA] Endereco de apoio copiado: $($this.Tag.CopyValue)")
            } catch {}
        })
    }

    $global:donForm.Tag = {
        $script:don_lblHeader.ForeColor  = Get-AccentOrangeColor
        $script:don_lblWarnCam.ForeColor = Get-AccentOrangeColor
        foreach ($b in @($script:don_btnLn, $script:don_btnBtc, $script:don_btnEvm)) { Set-ObsidianButtonStyle $b $false; $b.Invalidate() }
    }

    $global:donForm.Add_FormClosed({
        if ($null -ne $script:don_qrImgObj) { try { $script:don_qrImgObj.Dispose() } catch {}; $script:don_qrImgObj = $null }
        $global:donForm = $null
    })

    $global:donForm.Controls.AddRange(@($script:don_lblHeader, $script:don_picQr, $script:don_btnLn, $script:don_btnBtc, $script:don_btnEvm, $script:don_lblWarnCam))
    $global:donForm.Add_Shown({ Set-WindowDarkTheme $global:donForm })
    $global:donForm.Show()
}

function Show-Tutorial {
    if (-not (Test-Path $global:TutorialFile)) {
        [System.Windows.Forms.MessageBox]::Show("O arquivo '$($global:TutorialFileName)' ainda nao foi colocado na pasta 'resources'.", "$($global:ShortVersion) - Tutorial", 0, 64) | Out-Null
        return
    }
    if ($null -ne $global:tutForm -and (-not $global:tutForm.IsDisposed)) {
        if ($global:tutForm.WindowState -eq "Minimized") { $global:tutForm.WindowState = "Normal" }
        $global:tutForm.Activate(); return
    }
    $workArea = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea
    $winW = [Math]::Min(1024, [Math]::Max(820, $workArea.Width - 40))
    $winH = [Math]::Min(768, [Math]::Max(600, $workArea.Height - 40))
    $winBg = Get-WindowBgColor

    $global:tutForm = New-Object System.Windows.Forms.Form
    $global:tutForm.Text = "$($global:ShortVersion) - $(Get-Text 'TutorialWinTitle')"
    $global:tutForm.Size = New-Object System.Drawing.Size($winW, $winH); $global:tutForm.MinimumSize = New-Object System.Drawing.Size(820, 600)
    $global:tutForm.StartPosition = "CenterScreen"; $global:tutForm.BackColor = $winBg
    $global:tutForm.ShowIcon = $true; $global:tutForm.ShowInTaskbar = $true; $global:tutForm.Icon = $global:AppIcon

    $script:tut_bottomPanel = New-Object System.Windows.Forms.Panel
    $script:tut_bottomPanel.Dock = "Bottom"; $script:tut_bottomPanel.Height = 56; $script:tut_bottomPanel.BackColor = $winBg

    $script:tut_web = New-Object System.Windows.Forms.WebBrowser
    $script:tut_web.Dock = "Fill"; $script:tut_web.IsWebBrowserContextMenuEnabled = $true; $script:tut_web.WebBrowserShortcutsEnabled = $true; $script:tut_web.ScriptErrorsSuppressed = $true
    $script:tut_web.Navigate($global:TutorialFile)

    $script:tut_web.Add_DocumentCompleted({
        param($sender, $e)
        Set-TutorialWebScrollbarTheme
        try { if ($null -ne $sender.Document) { $sender.Document.InvokeScript("setTutorialLang", @([string]$global:Language)) | Out-Null } } catch {}
    })
    $script:tut_web.Add_Navigating({ param($sender, $e) if ($e.Url.Scheme -match "^https?$") { $e.Cancel = $true; Start-Process $e.Url.AbsoluteUri } })

    $global:tutForm.Controls.AddRange(@($script:tut_web, $script:tut_bottomPanel))

    $script:tut_btnShare = New-Object System.Windows.Forms.Button
    $script:tut_btnShare.Text = Get-Text "MenuShare"; $script:tut_btnShare.Size = New-Object System.Drawing.Size(210, 40); $script:tut_btnShare.Location = New-Object System.Drawing.Point(24, 8)
    $script:tut_btnShare.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left
    $script:tut_btnShare.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    $script:tut_btnShare.Tag = $false
    Set-ObsidianButtonStyle $script:tut_btnShare $true
    $script:tut_btnShare.Add_Click({
        Invoke-ShareMinerIsma
        $this.Tag = $true
        $this.Text = Get-Text "ShareCopiedShort"
        $this.ForeColor = Get-GreenTextColor
    })

    $script:tut_btnClose = New-Object System.Windows.Forms.Button
    $script:tut_btnClose.Text = Get-Text "BtnClose"; $script:tut_btnClose.Size = New-Object System.Drawing.Size(140, 40)
    $script:tut_btnClose.Location = New-Object System.Drawing.Point([Math]::Max(20, ($script:tut_bottomPanel.ClientSize.Width - 164)), 8)
    $script:tut_btnClose.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right
    $script:tut_btnClose.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    Set-ObsidianButtonStyle $script:tut_btnClose $false; $script:tut_btnClose.Add_Click({ $global:tutForm.Close() })

    $global:tutForm.Tag = {
        $script:tut_bottomPanel.BackColor = Get-WindowBgColor
        Set-ObsidianButtonStyle $script:tut_btnShare $true
        if ([bool]$script:tut_btnShare.Tag) { $script:tut_btnShare.ForeColor = Get-GreenTextColor }
        Set-ObsidianButtonStyle $script:tut_btnClose $false
        Set-TutorialWebScrollbarTheme
    }

    $global:tutForm.Add_FormClosed({ $global:tutForm = $null })
    $script:tut_bottomPanel.Controls.AddRange(@($script:tut_btnShare, $script:tut_btnClose))
    $global:tutForm.ActiveControl = $script:tut_btnClose
    $global:tutForm.Add_Shown({
        Set-WindowDarkTheme $global:tutForm
        $script:tut_btnClose.Left = [Math]::Max(20, ($script:tut_bottomPanel.ClientSize.Width - $script:tut_btnClose.Width - 24))
        $script:tut_btnClose.Focus() | Out-Null
    })
    $global:tutForm.Show()
}

function Show-WalletConfig {
    if ($null -ne $global:walletForm -and (-not $global:walletForm.IsDisposed)) {
        if ($global:walletForm.WindowState -eq "Minimized") { $global:walletForm.WindowState = "Normal" }
        $global:walletForm.Activate(); return
    }
    $global:walletForm = New-Object System.Windows.Forms.Form
    $global:walletForm.Text = "$($global:ShortVersion) - $(Get-Text 'WalletWinTitle')"
    $global:walletForm.Size = New-Object System.Drawing.Size(580, 380); $global:walletForm.StartPosition = "CenterScreen"
    $global:walletForm.BackColor = Get-WindowBgColor; $global:walletForm.FormBorderStyle = "FixedSingle"; $global:walletForm.MaximizeBox = $false
    $global:walletForm.ShowIcon = $true; $global:walletForm.ShowInTaskbar = $true; $global:walletForm.Icon = $global:AppIcon

    $fHdr  = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
    $fLbl  = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Regular)
    $fWrn1 = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    $fWrn2 = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Regular)

    $script:wal_lblHeader = New-UiLabel (Get-Text "WalletHeader") 20 20 0 0 $fHdr (Get-AccentOrangeColor)
    $script:wal_lblWallet = New-UiLabel (Get-Text "WalletLblAddr") 20 62 0 0 $fLbl (Get-PrimaryTextColor)
    $script:wal_lblWorker = New-UiLabel (Get-Text "WalletLblWorker") 20 130 0 0 $fLbl (Get-PrimaryTextColor)
    $script:wal_lblWarn1  = New-UiLabel (Get-Text "WalletWarn1") 20 205 0 0 $fWrn1 (Get-AccentOrangeColor)
    $script:wal_lblWarn2  = New-UiLabel (Get-Text "WalletWarn2") 20 230 0 0 $fWrn2 (Get-SecondaryTextColor)

    $currentAddr = ($global:Wallet -replace '\..*?$', '').Trim()
    if ($currentAddr -eq "minha_carteira") { $currentAddr = "" }
    $currentWorker = if ($global:Wallet -match '\.(.+)$') { ($Matches[1]).Trim() } else { "WORKER" }

    $script:wal_txtWallet = New-Object System.Windows.Forms.TextBox
    $script:wal_txtWallet.Text = $currentAddr; $script:wal_txtWallet.BorderStyle = "None"
    $script:wal_txtWallet.Location = New-Object System.Drawing.Point(25, 95); $script:wal_txtWallet.Size = New-Object System.Drawing.Size(400, 19)
    $script:wal_txtWallet.BackColor = Get-VisorBgColor; $script:wal_txtWallet.ForeColor = Get-GoldTextColor
    $script:wal_txtWallet.Font = New-Object System.Drawing.Font("Consolas", 11)

    $script:wal_txtWorker = New-Object System.Windows.Forms.TextBox
    $script:wal_txtWorker.Text = $currentWorker; $script:wal_txtWorker.BorderStyle = "None"
    $script:wal_txtWorker.Location = New-Object System.Drawing.Point(25, 163); $script:wal_txtWorker.Size = New-Object System.Drawing.Size(110, 19)
    $script:wal_txtWorker.BackColor = Get-VisorBgColor; $script:wal_txtWorker.ForeColor = Get-CyanTextColor
    $script:wal_txtWorker.Font = New-Object System.Drawing.Font("Consolas", 11)

    $global:walletForm.Add_Paint({
        param($s, $e)
        $bFill = New-Object System.Drawing.SolidBrush((Get-VisorBgColor))
        $pBronze = New-Object System.Drawing.Pen($global:ColorBronzeBorder, 1)
        $e.Graphics.FillRectangle($bFill, 20, 90, 410, 28); $e.Graphics.DrawRectangle($pBronze, 20, 90, 409, 27)
        $e.Graphics.FillRectangle($bFill, 20, 158, 120, 28); $e.Graphics.DrawRectangle($pBronze, 20, 158, 119, 27)
        $bFill.Dispose(); $pBronze.Dispose()
    })

    $script:wal_btnSave = New-Object System.Windows.Forms.Button
    $script:wal_btnSave.Text = Get-Text "BtnSave"; $script:wal_btnSave.Location = New-Object System.Drawing.Point(20, 275); $script:wal_btnSave.Size = New-Object System.Drawing.Size(140, 40)
    $script:wal_btnSave.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    Set-ObsidianButtonStyle $script:wal_btnSave $false
    $script:wal_btnSave.Add_Click({
        $newAddr = ($script:wal_txtWallet.Text -replace '\s+', '').Trim('.')
        $newWrk  = ($script:wal_txtWorker.Text -replace '\s+', '').Trim('.')
        if ([string]::IsNullOrWhiteSpace($newAddr) -or ($newAddr -eq "minha_carteira")) {
            [System.Windows.Forms.MessageBox]::Show((Get-Text "WalletEmptyMsg"), "$($global:ShortVersion)", 0, 48) | Out-Null; return
        }
        if ($newAddr -notmatch '^(1|3|bc1)[a-zA-HJ-NP-Z0-9]{25,62}$') {
            $nl = [Environment]::NewLine
            [System.Windows.Forms.MessageBox]::Show(((Get-Text "WalletInvalid1") + $nl + $nl + (Get-Text "WalletInvalid2")), "$($global:ShortVersion)", 0, 16) | Out-Null; return
        }
        if ([string]::IsNullOrWhiteSpace($newWrk)) { $newWrk = "WORKER" }
        $global:Wallet = "$newAddr.$newWrk"; Save-MinerConfig
        $global:LogQueue.Enqueue("[SISTEMA] Carteira atualizada: $($global:Wallet)")
        if ($global:IsPaused) { $global:itemPause.Text = Get-Text "MenuPause"; $global:IsPaused = $false; $global:PauseResumeAt = $null }
        if ($global:PulseMode -ne "") { $global:PulseNextSwitch = (Get-Date).AddMinutes($global:PulseActiveMins) }
        $global:notifyIcon.Text = "$($global:ShortVersion)" + [Environment]::NewLine + "$($global:CurrentThreads) Threads | $(Get-Text 'TrayCalculating')"
        Start-MinerTask $global:CurrentThreads
        $global:walletForm.Close()
    })

    $script:wal_btnCreate = New-Object System.Windows.Forms.Button
    $script:wal_btnCreate.Text = Get-Text "BtnCreateWallet"; $script:wal_btnCreate.Location = New-Object System.Drawing.Point(210, 275); $script:wal_btnCreate.Size = New-Object System.Drawing.Size(140, 40)
    $script:wal_btnCreate.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    Set-ObsidianButtonStyle $script:wal_btnCreate $true; $script:wal_btnCreate.Add_Click({ Start-Process $global:UrlBlueWallet })

    $script:wal_btnClose = New-Object System.Windows.Forms.Button
    $script:wal_btnClose.Text = Get-Text "BtnClose"; $script:wal_btnClose.Location = New-Object System.Drawing.Point(400, 275); $script:wal_btnClose.Size = New-Object System.Drawing.Size(140, 40)
    $script:wal_btnClose.Font = New-Object System.Drawing.Font("Segoe UI", 10)
    Set-ObsidianButtonStyle $script:wal_btnClose $false; $script:wal_btnClose.Add_Click({ $global:walletForm.Close() })

    $global:walletForm.Tag = {
        $script:wal_lblHeader.ForeColor = Get-AccentOrangeColor; $script:wal_lblWarn1.ForeColor = Get-AccentOrangeColor
        $script:wal_lblWallet.ForeColor = Get-PrimaryTextColor;  $script:wal_lblWorker.ForeColor = Get-PrimaryTextColor
        $script:wal_lblWarn2.ForeColor  = Get-SecondaryTextColor
        $script:wal_txtWallet.BackColor = Get-VisorBgColor; $script:wal_txtWallet.ForeColor = Get-GoldTextColor
        $script:wal_txtWorker.BackColor = Get-VisorBgColor; $script:wal_txtWorker.ForeColor = Get-CyanTextColor
        Set-ObsidianButtonStyle $script:wal_btnSave $false; Set-ObsidianButtonStyle $script:wal_btnCreate $true; Set-ObsidianButtonStyle $script:wal_btnClose $false
    }

    $global:walletForm.Add_FormClosed({ $global:walletForm = $null })
    $global:walletForm.Controls.AddRange(@($script:wal_lblHeader, $script:wal_lblWallet, $script:wal_txtWallet, $script:wal_lblWorker, $script:wal_txtWorker, $script:wal_lblWarn1, $script:wal_lblWarn2, $script:wal_btnSave, $script:wal_btnCreate, $script:wal_btnClose))
    $global:walletForm.ActiveControl = $script:wal_btnSave
    $global:walletForm.Add_Shown({
        Set-WindowDarkTheme $global:walletForm
        $script:wal_txtWallet.SelectionLength = 0
        $script:wal_txtWorker.SelectionLength = 0
        $script:wal_btnSave.Focus() | Out-Null
    })
    $global:walletForm.Show()
}

function Show-AdvancedConfig {
    if ($null -ne $global:advForm -and (-not $global:advForm.IsDisposed)) {
        if ($global:advForm.WindowState -eq "Minimized") { $global:advForm.WindowState = "Normal" }
        $global:advForm.Activate(); return
    }
    $global:advForm = New-Object System.Windows.Forms.Form
    $global:advForm.Text = "$($global:ShortVersion) - $(Get-Text 'AdvWinTitle')"
    $global:advForm.Size = New-Object System.Drawing.Size(620, 440); $global:advForm.StartPosition = "CenterScreen"
    $global:advForm.BackColor = Get-WindowBgColor; $global:advForm.FormBorderStyle = "FixedSingle"; $global:advForm.MaximizeBox = $false
    $global:advForm.ShowIcon = $true; $global:advForm.ShowInTaskbar = $true; $global:advForm.Icon = $global:AppIcon

    $fDanger = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
    $fWrn1   = New-Object System.Drawing.Font("Segoe UI", 10.5, [System.Drawing.FontStyle]::Bold)
    $fWrn2   = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Regular)
    $fLbl    = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)

    $script:adv_lblDanger = New-UiLabel (Get-Text "AdvDangerHdr") 20 12 564 26 $fDanger (Get-DangerTextColor)
    $script:adv_lblWarn1  = New-UiLabel (Get-Text "AdvWarn1") 20 42 564 22 $fWrn1 (Get-AccentOrangeColor)
    $script:adv_lblWarn2  = New-UiLabel (Get-Text "AdvWarn2") 20 65 564 20 $fWrn2 (Get-PrimaryTextColor)
    $script:adv_lblWarn3  = New-UiLabel (Get-Text "AdvWarn3") 20 86 564 20 $fWrn2 (Get-PrimaryTextColor)

    $script:adv_lblPool   = New-UiLabel (Get-Text "AdvLblPool") 20 116 0 0 $fLbl (Get-PrimaryTextColor)
    $script:adv_txtPool   = New-Object System.Windows.Forms.TextBox
    $script:adv_txtPool.Text = $global:PoolUrl; $script:adv_txtPool.BorderStyle = "None"
    $script:adv_txtPool.Location = New-Object System.Drawing.Point(25, 144); $script:adv_txtPool.Size = New-Object System.Drawing.Size(554, 19)
    $script:adv_txtPool.BackColor = Get-VisorBgColor; $script:adv_txtPool.ForeColor = Get-GoldTextColor
    $script:adv_txtPool.Font = New-Object System.Drawing.Font("Consolas", 10.5)

    $script:adv_lblExtra  = New-UiLabel (Get-Text "AdvLblExtra") 20 176 0 0 $fLbl (Get-PrimaryTextColor)
    $script:adv_txtExtra  = New-Object System.Windows.Forms.TextBox
    $script:adv_txtExtra.Text = $global:ExtraArgs; $script:adv_txtExtra.BorderStyle = "None"
    $script:adv_txtExtra.Location = New-Object System.Drawing.Point(25, 204); $script:adv_txtExtra.Size = New-Object System.Drawing.Size(554, 19)
    $script:adv_txtExtra.BackColor = Get-VisorBgColor; $script:adv_txtExtra.ForeColor = Get-CyanTextColor
    $script:adv_txtExtra.Font = New-Object System.Drawing.Font("Consolas", 10.5)

    $script:adv_lblPreview = New-UiLabel (Get-Text "AdvLblPreview") 20 236 0 0 $fLbl (Get-SecondaryTextColor)
    $script:adv_txtPreview = New-Object System.Windows.Forms.TextBox
    $script:adv_txtPreview.Multiline = $true; $script:adv_txtPreview.ReadOnly = $true; $script:adv_txtPreview.TabStop = $false; $script:adv_txtPreview.BorderStyle = "None"
    $script:adv_txtPreview.Location = New-Object System.Drawing.Point(25, 264); $script:adv_txtPreview.Size = New-Object System.Drawing.Size(554, 52)
    $script:adv_txtPreview.BackColor = Get-VisorBgColor; $script:adv_txtPreview.ForeColor = Get-SecondaryTextColor
    $script:adv_txtPreview.Font = New-Object System.Drawing.Font("Consolas", 9.5)

    $script:adv_updatePreview = {
        $aff  = Get-Affinity $global:CurrentThreads
        $pStr = ($script:adv_txtPool.Text).Trim()
        $eStr = ($script:adv_txtExtra.Text).Trim()
        $cmd  = "$($global:DetectedMinerExe) -a sha256d -o $pStr -u $($global:Wallet) -p x -t $($global:CurrentThreads) --cpu-affinity $aff $eStr"
        $script:adv_txtPreview.Text = ($cmd -replace '\s+', ' ').Trim()
    }
    & $script:adv_updatePreview
    $script:adv_txtPool.Add_TextChanged($script:adv_updatePreview)
    $script:adv_txtExtra.Add_TextChanged($script:adv_updatePreview)

    $global:advForm.Add_Paint({
        param($s, $e)
        $bFill = New-Object System.Drawing.SolidBrush((Get-VisorBgColor))
        $pBronze = New-Object System.Drawing.Pen($global:ColorBronzeBorder, 1)
        $e.Graphics.FillRectangle($bFill, 20, 139, 564, 28); $e.Graphics.DrawRectangle($pBronze, 20, 139, 563, 27)
        $e.Graphics.FillRectangle($bFill, 20, 199, 564, 28); $e.Graphics.DrawRectangle($pBronze, 20, 199, 563, 27)
        $e.Graphics.FillRectangle($bFill, 20, 259, 564, 62); $e.Graphics.DrawRectangle($pBronze, 20, 259, 563, 61)
        $bFill.Dispose(); $pBronze.Dispose()
    })

    $script:adv_btnSave = New-Object System.Windows.Forms.Button
    $script:adv_btnSave.Text = Get-Text "BtnSaveApply"; $script:adv_btnSave.Location = New-Object System.Drawing.Point(20, 340); $script:adv_btnSave.Size = New-Object System.Drawing.Size(172, 40)
    $script:adv_btnSave.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    Set-ObsidianButtonStyle $script:adv_btnSave $false
    $script:adv_btnSave.Add_Click({
        $newPool  = ($script:adv_txtPool.Text).Trim()
        $newExtra = ($script:adv_txtExtra.Text).Trim()
        if ($newExtra -match '(^|\s)(-t|--threads|--cpu-affinity|-u|--user|-o|--url|-a|--algo)(\s|=|$)') {
            [System.Windows.Forms.MessageBox]::Show((Get-Text "AdvForbiddenArgs"), "$($global:ShortVersion)", 0, 48) | Out-Null; return
        }
        if (($newExtra -notmatch '(?i)--benchmark') -and ($newPool -notmatch '^(stratum\+(tcp|ssl)://).+')) {
            [System.Windows.Forms.MessageBox]::Show((Get-Text "AdvInvalidPool"), "$($global:ShortVersion)", 0, 16) | Out-Null; return
        }
        $ans = [System.Windows.Forms.MessageBox]::Show((Get-Text "AdvConfirmMsg"), "$($global:ShortVersion)", [System.Windows.Forms.MessageBoxButtons]::OKCancel, [System.Windows.Forms.MessageBoxIcon]::Warning)
        if ($ans -eq [System.Windows.Forms.DialogResult]::OK) {
            $global:PoolUrl   = $newPool
            $global:ExtraArgs = $newExtra
            Save-MinerConfig
            $global:LogQueue.Enqueue("[SISTEMA] Modo Avancado aplicado: Pool=$newPool | ExtraArgs=$newExtra")
            if ($global:IsPaused) { $global:itemPause.Text = Get-Text "MenuPause"; $global:IsPaused = $false; $global:PauseResumeAt = $null }
            Start-MinerTask $global:CurrentThreads
            $global:advForm.Close()
        }
    })

    $script:adv_btnRestore = New-Object System.Windows.Forms.Button
    $script:adv_btnRestore.Text = Get-Text "BtnRestoreDef"; $script:adv_btnRestore.Location = New-Object System.Drawing.Point(216, 340); $script:adv_btnRestore.Size = New-Object System.Drawing.Size(172, 40)
    $script:adv_btnRestore.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    Set-ObsidianButtonStyle $script:adv_btnRestore $true
    $script:adv_btnRestore.Add_Click({
        $ans = [System.Windows.Forms.MessageBox]::Show((Get-Text "AdvRestoreMsg"), "$($global:ShortVersion)", [System.Windows.Forms.MessageBoxButtons]::OKCancel, [System.Windows.Forms.MessageBoxIcon]::Question)
        if ($ans -eq [System.Windows.Forms.DialogResult]::OK) {
            $script:adv_txtPool.Text  = $global:DefaultPoolUrl
            $script:adv_txtExtra.Text = $global:DefaultExtraArgs
            $global:PoolUrl           = $global:DefaultPoolUrl
            $global:ExtraArgs         = $global:DefaultExtraArgs
            Save-MinerConfig
            $global:LogQueue.Enqueue("[SISTEMA] Modo Avancado restaurado para o padrao de fabrica.")
            if ($global:IsPaused) { $global:itemPause.Text = Get-Text "MenuPause"; $global:IsPaused = $false; $global:PauseResumeAt = $null }
            Start-MinerTask $global:CurrentThreads
            $global:advForm.Close()
        }
    })

    $script:adv_btnClose = New-Object System.Windows.Forms.Button
    $script:adv_btnClose.Text = Get-Text "BtnClose"; $script:adv_btnClose.Location = New-Object System.Drawing.Point(412, 340); $script:adv_btnClose.Size = New-Object System.Drawing.Size(172, 40)
    $script:adv_btnClose.Font = New-Object System.Drawing.Font("Segoe UI", 10)
    Set-ObsidianButtonStyle $script:adv_btnClose $false; $script:adv_btnClose.Add_Click({ $global:advForm.Close() })

    $global:advForm.Tag = {
        $script:adv_lblDanger.ForeColor  = Get-DangerTextColor
        $script:adv_lblWarn1.ForeColor   = Get-AccentOrangeColor
        $script:adv_lblWarn2.ForeColor   = Get-PrimaryTextColor
        $script:adv_lblWarn3.ForeColor   = Get-PrimaryTextColor
        $script:adv_lblPool.ForeColor    = Get-PrimaryTextColor
        $script:adv_lblExtra.ForeColor   = Get-PrimaryTextColor
        $script:adv_lblPreview.ForeColor = Get-SecondaryTextColor
        $script:adv_txtPool.BackColor    = Get-VisorBgColor; $script:adv_txtPool.ForeColor    = Get-GoldTextColor
        $script:adv_txtExtra.BackColor   = Get-VisorBgColor; $script:adv_txtExtra.ForeColor   = Get-CyanTextColor
        $script:adv_txtPreview.BackColor = Get-VisorBgColor; $script:adv_txtPreview.ForeColor = Get-SecondaryTextColor
        Set-ObsidianButtonStyle $script:adv_btnSave $false; Set-ObsidianButtonStyle $script:adv_btnRestore $true; Set-ObsidianButtonStyle $script:adv_btnClose $false
    }

    $global:advForm.Add_FormClosed({ $global:advForm = $null })
    $global:advForm.Controls.AddRange(@($script:adv_lblDanger, $script:adv_lblWarn1, $script:adv_lblWarn2, $script:adv_lblWarn3, $script:adv_lblPool, $script:adv_txtPool, $script:adv_lblExtra, $script:adv_txtExtra, $script:adv_lblPreview, $script:adv_txtPreview, $script:adv_btnSave, $script:adv_btnRestore, $script:adv_btnClose))
    $global:advForm.ActiveControl = $script:adv_btnClose
    $global:advForm.Add_Shown({
        Set-WindowDarkTheme $global:advForm
        $script:adv_txtPool.SelectionLength = 0
        $script:adv_txtExtra.SelectionLength = 0
        $script:adv_txtPreview.SelectionLength = 0
        $script:adv_btnClose.Focus() | Out-Null
    })
    $global:advForm.Show()
}

function Get-Affinity {
    param([int]$Threads)
    foreach ($entry in $global:ThreadProfiles.GetEnumerator()) { if ([int]$entry.Key -eq $Threads) { return [string]$entry.Value } }
    return $null
}

function Write-ErrorLog {
    param([string]$Message)
    try { Add-Content -Path $global:ErrorLog -Value "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] $Message" } catch {}
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
    foreach ($l in @($global:RecentLines)) {
        if ($l -match "Block\s+(\d{6,7})\b" -and ([int]$Matches[1] -gt $global:CurrentBlockHeight)) { $global:CurrentBlockHeight = [int]$Matches[1] }
    }
    $anchorUtc = [datetime]::new(2024, 4, 20, 0, 9, 27, [System.DateTimeKind]::Utc)
    $estHeight = 840000 + [int][Math]::Floor(([datetime]::UtcNow - $anchorUtc).TotalMinutes / 10.0)
    return [Math]::Max(1, (1050000 - [Math]::Max($global:CurrentBlockHeight, $estHeight)))
}

function Show-TtfStats {
    if ($null -ne $global:statForm -and (-not $global:statForm.IsDisposed)) {
        if ($global:statForm.WindowState -eq "Minimized") { $global:statForm.WindowState = "Normal" }
        $global:statForm.Activate(); return
    }

    $lines = if (Test-Path $global:TtfLogFile) { @(Get-Content $global:TtfLogFile) } else { @() }
    $bestLine = ""; $bestDays = 999999.0; $sumDays = 0.0; $count = 0

    foreach ($l in $lines) {
        if ($l -match "TTF Bloco:\s*([^ |]+)") {
            $d = Convert-TtfToDays ($Matches[1].Trim())
            if ($null -ne $d) { $sumDays += $d; $count++; if ($d -lt $bestDays) { $bestDays = $d; $bestLine = $l } }
        }
    }

    $script:stat_hasData = ($count -gt 0); $avgStr = Get-Text "TtfWaitAvg"
    $script:stat_bDate = ""; $script:stat_bThr = ""; $script:stat_bHash = ""; $script:stat_bTtf = ""; $script:stat_isParsed = $false
    $script:stat_bestLine = $bestLine
    if ($script:stat_hasData) {
        $avg = $sumDays / $count; $avgYears = [Math]::Floor($avg / 365); $remDays = $avg % 365
        $avgDaysF = [Math]::Floor($remDays); $avgHours = [Math]::Floor(($remDays - $avgDaysF) * 24)
        $avgStr = $(if ($avgYears -gt 0) { "$($avgYears)y " } else { "" }) + "$($avgDaysF)d $($avgHours)h"
        if ($bestLine -match "\x5B(.*?)\x5D Threads: (\d+) \| Hashrate: (.*?) \| TTF Bloco: (.*?) \|") {
            $script:stat_bDate = $Matches[1]; $script:stat_bThr = $Matches[2]; $script:stat_bHash = $Matches[3]; $script:stat_bTtf = $Matches[4]; $script:stat_isParsed = $true
        }
    }

    # Altura aumentada (436px) e visores inferiores com 76px internos para nao cortar a 3a linha em notebooks (14", 15", 17")
    $global:statForm = New-Object System.Windows.Forms.Form
    $global:statForm.Text = "$($global:ShortVersion) - $(Get-Text 'TtfWinTitle')"
    $global:statForm.Size = New-Object System.Drawing.Size(620, 436); $global:statForm.StartPosition = "CenterScreen"
    $global:statForm.BackColor = Get-WindowBgColor; $global:statForm.FormBorderStyle = "FixedSingle"; $global:statForm.MaximizeBox = $false
    $global:statForm.ShowIcon = $true; $global:statForm.ShowInTaskbar = $true; $global:statForm.Icon = $global:AppIcon

    $cardBgCol    = Get-CardBgColor
    $colorBitcoin = Get-AccentOrangeColor
    $colorGold    = Get-GoldTextColor
    $colorUsd     = Get-GreenTextColor
    $colorSubInfo = Get-SecondaryTextColor
    $script:stat_numCulture = if ($global:Language -eq "EN") { [System.Globalization.CultureInfo]::InvariantCulture } else { [System.Globalization.CultureInfo]::GetCultureInfo("pt-BR") }

    $fCardHdr  = New-Object System.Drawing.Font("Segoe UI", 11.5, [System.Drawing.FontStyle]::Bold)
    $fBigGold  = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
    $fAvgGold  = New-Object System.Drawing.Font("Segoe UI", 15.5, [System.Drawing.FontStyle]::Bold)
    $fBold11   = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
    $fSub95    = New-Object System.Drawing.Font("Segoe UI", 9.5, [System.Drawing.FontStyle]::Regular)
    $fLink95   = New-Object System.Drawing.Font("Segoe UI", 9.5, ([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))

    $prizeUsdText = if ($global:LastBtcUsdValue -gt 0) {
        "$(Get-Text 'TtfPrizeUsdPref')$((3.125 * $global:LastBtcUsdValue).ToString('N2', [System.Globalization.CultureInfo]::InvariantCulture))"
    } else { Get-Text "TtfPrizeUsdWait" }
    $remBlocksStr = (Get-RemainingHalvingBlocks).ToString("N0", $script:stat_numCulture)

    $script:stat_lblPrizeHdr = New-UiLabel "$($global:BtcSym) $(Get-Text 'TtfPrizeHeader')" 21 18 270 22 $fCardHdr $colorBitcoin $cardBgCol
    $script:stat_lblPrizeBtc = New-UiLabel (Get-Text "TtfPrizeBtc") 21 41 270 28 $fBigGold $colorGold $cardBgCol
    $script:stat_lblPrizeUsd = New-UiLabel $prizeUsdText 21 71 270 21 $fBold11 $colorUsd $cardBgCol
    $script:stat_lblDrawInfo = New-UiLabel (Get-Text "TtfDrawInfo") 21 95 270 19 $fSub95 $colorSubInfo $cardBgCol
    $script:stat_lblHalving  = New-UiLabel "$(Get-Text 'TtfHalving1')$remBlocksStr$(Get-Text 'TtfHalving2')" 21 115 270 20 $fLink95 $colorSubInfo $cardBgCol
    $script:stat_lblHalving.Cursor = [System.Windows.Forms.Cursors]::Hand; $script:stat_lblHalving.Add_Click({ Open-HalvingLink })

    $script:stat_lblAvgHdr   = New-UiLabel "$($global:BoltSym) $(Get-Text 'TtfAvgHeader')" 313 18 270 22 $fCardHdr $colorBitcoin $cardBgCol
    $script:stat_lblAvgSub   = New-UiLabel (Get-Text "TtfAvgSub") 313 40 270 18 $fSub95 $colorSubInfo $cardBgCol
    $script:stat_lblAvgVal   = New-UiLabel $avgStr 313 62 270 30 $fAvgGold $colorGold $cardBgCol
    $script:stat_lblCount    = New-UiLabel "$(Get-Text 'TtfCountLbl') $count" 313 107 270 24 $fBold11 $colorBitcoin $cardBgCol

    $script:stat_lblSoloTitle = New-UiLabel "$($global:BlockSym) $(Get-Text 'TtfSoloHeader')" 21 162 270 22 $fCardHdr $colorBitcoin $cardBgCol
    $script:stat_lblSoloSub   = New-UiLabel (Get-Text "TtfSoloSub") 21 185 270 19 $fSub95 $colorSubInfo $cardBgCol
    $script:stat_lblBestTitle = New-UiLabel "$($global:StarSym) $(Get-Text 'TtfBestLbl')" 313 162 270 22 $fCardHdr $colorBitcoin $cardBgCol
    $script:stat_lblBestSub   = New-UiLabel (Get-Text "TtfBestSub") 313 185 270 19 $fSub95 $colorSubInfo $cardBgCol

    $script:stat_fontRegular = New-Object System.Drawing.Font("Consolas", 10.5, [System.Drawing.FontStyle]::Regular)
    $script:stat_fontBold    = New-Object System.Drawing.Font("Consolas", 11, [System.Drawing.FontStyle]::Bold)
    $script:stat_fontNoData  = New-Object System.Drawing.Font("Consolas", 9.5, [System.Drawing.FontStyle]::Regular)

    $script:stat_txtSolo = New-Object System.Windows.Forms.RichTextBox
    $script:stat_txtSolo.Multiline = $true; $script:stat_txtSolo.BorderStyle = "None"; $script:stat_txtSolo.Location = New-Object System.Drawing.Point(31, 215)
    $script:stat_txtSolo.Size = New-Object System.Drawing.Size(250, 76); $script:stat_txtSolo.ReadOnly = $true; $script:stat_txtSolo.TabStop = $false; $script:stat_txtSolo.ScrollBars = "None"
    $script:stat_txtSolo.Cursor = [System.Windows.Forms.Cursors]::Hand; $script:stat_txtSolo.Font = $script:stat_fontRegular

    $script:stat_txtBest = New-Object System.Windows.Forms.RichTextBox
    $script:stat_txtBest.Multiline = $true; $script:stat_txtBest.BorderStyle = "None"; $script:stat_txtBest.Location = New-Object System.Drawing.Point(323, 215)
    $script:stat_txtBest.Size = New-Object System.Drawing.Size(250, 76); $script:stat_txtBest.ReadOnly = $true; $script:stat_txtBest.TabStop = $false; $script:stat_txtBest.ScrollBars = "None"
    $script:stat_txtBest.Font = $script:stat_fontRegular

    $script:stat_populateVisors = {
        $nl   = [Environment]::NewLine
        $vBg  = Get-VisorBgColor; $gCol = Get-GoldTextColor; $uCol = Get-GreenTextColor
        $script:stat_txtSolo.BackColor = $vBg; $script:stat_txtSolo.ForeColor = $gCol; $script:stat_txtSolo.Clear()
        if ($global:LastSoloBlockHeight -gt 0) {
            $soloHeightFmt = $global:LastSoloBlockHeight.ToString("N0", $script:stat_numCulture)
            $script:stat_txtSolo.SelectionFont = $script:stat_fontRegular; $script:stat_txtSolo.SelectionColor = $gCol
            $script:stat_txtSolo.AppendText("$(Get-Text 'TtfDate') $($global:LastSoloBlockTime)" + $nl + "$(Get-Text 'TtfSoloBlockLbl') ")
            $script:stat_txtSolo.SelectionFont = $script:stat_fontBold; $script:stat_txtSolo.SelectionColor = $gCol
            $script:stat_txtSolo.AppendText("#$soloHeightFmt ($($global:LastSoloBlockPool))")
            $script:stat_txtSolo.SelectionFont = $script:stat_fontBold; $script:stat_txtSolo.SelectionColor = $uCol
            $script:stat_txtSolo.AppendText($nl + "$(Get-Text 'TtfSoloPrizeLbl') $($global:LastSoloBlockReward)")
        } else {
            $script:stat_txtSolo.SelectionFont = $script:stat_fontNoData; $script:stat_txtSolo.SelectionColor = $gCol; $script:stat_txtSolo.AppendText($nl + (Get-Text "TtfSoloWait"))
        }
        $script:stat_txtSolo.SelectAll(); $script:stat_txtSolo.SelectionAlignment = [System.Windows.Forms.HorizontalAlignment]::Center
        $script:stat_txtSolo.SelectionLength = 0; $script:stat_txtSolo.SelectionStart = 0

        $script:stat_txtBest.BackColor = $vBg; $script:stat_txtBest.ForeColor = $gCol; $script:stat_txtBest.Clear()
        if (-not $script:stat_hasData) {
            $script:stat_txtBest.SelectionFont = $script:stat_fontNoData; $script:stat_txtBest.SelectionColor = $gCol
            $script:stat_txtBest.AppendText($nl + (Get-Text "TtfNoDataBox1") + $nl + (Get-Text "TtfNoDataBox2"))
        } elseif ($script:stat_isParsed) {
            $script:stat_txtBest.SelectionFont = $script:stat_fontRegular; $script:stat_txtBest.SelectionColor = $gCol
            $script:stat_txtBest.AppendText("$(Get-Text 'TtfDate') $($script:stat_bDate)" + $nl + "$(Get-Text 'TtfLuck') ")
            $script:stat_txtBest.SelectionFont = $script:stat_fontBold; $script:stat_txtBest.SelectionColor = $gCol; $script:stat_txtBest.AppendText($script:stat_bTtf)
            $script:stat_txtBest.SelectionFont = $script:stat_fontRegular; $script:stat_txtBest.SelectionColor = $gCol; $script:stat_txtBest.AppendText($nl + "$(Get-Text 'TtfPower') $($script:stat_bHash) ($($script:stat_bThr) Th)")
        } else { $script:stat_txtBest.Text = $script:stat_bestLine }
        $script:stat_txtBest.SelectAll(); $script:stat_txtBest.SelectionAlignment = [System.Windows.Forms.HorizontalAlignment]::Center
        $script:stat_txtBest.SelectionLength = 0; $script:stat_txtBest.SelectionStart = 0
    }
    & $script:stat_populateVisors

    $script:stat_txtSolo.Add_Click({
        if ($global:LastSoloBlockHeight -gt 0) { Start-Process ("https://mempool.space/pt/block/" + $global:LastSoloBlockHeight) }
        else { Start-Process "https://mempool.space/pt/mining/pool/solock" }
    })

    $global:statForm.Add_Paint({
        param($s, $e)
        $bCard   = New-Object System.Drawing.SolidBrush((Get-CardBgColor))
        $bVisor  = New-Object System.Drawing.SolidBrush((Get-VisorBgColor))
        $pBronze = New-Object System.Drawing.Pen($global:ColorBronzeBorder, 1)

        $e.Graphics.FillRectangle($bCard, 20, 14, 272, 130);  $e.Graphics.DrawRectangle($pBronze, 20, 14, 271, 129)
        $e.Graphics.FillRectangle($bCard, 312, 14, 272, 130); $e.Graphics.DrawRectangle($pBronze, 312, 14, 271, 129)
        $e.Graphics.DrawLine($pBronze, 334, 100, 562, 100)

        $e.Graphics.FillRectangle($bCard, 20, 158, 272, 154);  $e.Graphics.DrawRectangle($pBronze, 20, 158, 271, 153)
        $e.Graphics.FillRectangle($bCard, 312, 158, 272, 154); $e.Graphics.DrawRectangle($pBronze, 312, 158, 271, 153)

        $e.Graphics.FillRectangle($bVisor, 30, 210, 252, 86);  $e.Graphics.DrawRectangle($pBronze, 30, 210, 251, 85)
        $e.Graphics.FillRectangle($bVisor, 322, 210, 252, 86); $e.Graphics.DrawRectangle($pBronze, 322, 210, 251, 85)
        $bCard.Dispose(); $bVisor.Dispose(); $pBronze.Dispose()
    })

    $script:stat_btnSave = New-Object System.Windows.Forms.Button
    $script:stat_btnSave.Text = Get-Text "BtnSaveImg"; $script:stat_btnSave.Location = New-Object System.Drawing.Point(20, 332); $script:stat_btnSave.Size = New-Object System.Drawing.Size(160, 40)
    $script:stat_btnSave.Font = New-Object System.Drawing.Font("Segoe UI", 10); Set-ObsidianButtonStyle $script:stat_btnSave $false

    $script:stat_btnReset = New-Object System.Windows.Forms.Button
    $script:stat_btnReset.Text = Get-Text "BtnResetTtf"; $script:stat_btnReset.Location = New-Object System.Drawing.Point(222, 332); $script:stat_btnReset.Size = New-Object System.Drawing.Size(160, 40)
    $script:stat_btnReset.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold); Set-ObsidianButtonStyle $script:stat_btnReset $true
    $script:stat_btnReset.Add_Click({
        $ans = [System.Windows.Forms.MessageBox]::Show((Get-Text "TtfResetConfirm"), "$($global:ShortVersion)", [System.Windows.Forms.MessageBoxButtons]::OKCancel, [System.Windows.Forms.MessageBoxIcon]::Warning)
        if ($ans -eq [System.Windows.Forms.DialogResult]::OK) {
            Remove-Item -LiteralPath $global:TtfLogFile, $global:BackupTtfLogFile, $global:LegacyTtfLogFile -Force -ErrorAction SilentlyContinue
            $global:LastTtfLogged = ""; $global:LogQueue.Enqueue("[SISTEMA] Historico de estatisticas TTF zerado pelo usuario."); $global:statForm.Close()
        }
    })

    $script:stat_btnClose = New-Object System.Windows.Forms.Button
    $script:stat_btnClose.Text = Get-Text "BtnClose"; $script:stat_btnClose.Location = New-Object System.Drawing.Point(424, 332); $script:stat_btnClose.Size = New-Object System.Drawing.Size(160, 40)
    $script:stat_btnClose.Font = New-Object System.Drawing.Font("Segoe UI", 10); Set-ObsidianButtonStyle $script:stat_btnClose $false
    $script:stat_btnClose.Add_Click({ $global:statForm.Close() })

    $script:stat_btnSave.Add_Click({
        $bmp = Copy-WindowScreenImage $global:statForm $script:stat_btnClose
        $sfd = New-Object System.Windows.Forms.SaveFileDialog
        $sfd.Filter = "PNG Image|*.png"; $sfd.FileName = "MinerIsma_Stats_$(Get-Date -Format 'yyyyMMdd_HHmmss').png"
        if (($sfd.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) -and ($null -ne $bmp)) { $bmp.Save($sfd.FileName, [System.Drawing.Imaging.ImageFormat]::Png) }
        if ($null -ne $bmp) { $bmp.Dispose() }
    })

    $global:statForm.Tag = {
        $cBg = Get-CardBgColor; $oCol = Get-AccentOrangeColor; $gCol = Get-GoldTextColor; $uCol = Get-GreenTextColor; $sCol = Get-SecondaryTextColor
        foreach ($lbl in @($script:stat_lblPrizeHdr, $script:stat_lblPrizeBtc, $script:stat_lblPrizeUsd, $script:stat_lblDrawInfo, $script:stat_lblHalving, $script:stat_lblAvgHdr, $script:stat_lblAvgSub, $script:stat_lblAvgVal, $script:stat_lblCount, $script:stat_lblSoloTitle, $script:stat_lblSoloSub, $script:stat_lblBestTitle, $script:stat_lblBestSub)) { $lbl.BackColor = $cBg }
        foreach ($lbl in @($script:stat_lblPrizeHdr, $script:stat_lblAvgHdr, $script:stat_lblCount, $script:stat_lblSoloTitle, $script:stat_lblBestTitle)) { $lbl.ForeColor = $oCol }
        foreach ($lbl in @($script:stat_lblPrizeBtc, $script:stat_lblAvgVal)) { $lbl.ForeColor = $gCol }
        $script:stat_lblPrizeUsd.ForeColor = $uCol
        foreach ($lbl in @($script:stat_lblDrawInfo, $script:stat_lblHalving, $script:stat_lblAvgSub, $script:stat_lblSoloSub, $script:stat_lblBestSub)) { $lbl.ForeColor = $sCol }
        & $script:stat_populateVisors
        Set-ObsidianButtonStyle $script:stat_btnSave $false; Set-ObsidianButtonStyle $script:stat_btnReset $true; Set-ObsidianButtonStyle $script:stat_btnClose $false
    }

    $global:statForm.Add_FormClosed({ $global:statForm = $null })
    $global:statForm.Controls.AddRange(@($script:stat_lblPrizeHdr, $script:stat_lblPrizeBtc, $script:stat_lblPrizeUsd, $script:stat_lblDrawInfo, $script:stat_lblHalving, $script:stat_lblAvgHdr, $script:stat_lblAvgSub, $script:stat_lblAvgVal, $script:stat_lblCount, $script:stat_lblSoloTitle, $script:stat_lblSoloSub, $script:stat_txtSolo, $script:stat_lblBestTitle, $script:stat_lblBestSub, $script:stat_txtBest, $script:stat_btnSave, $script:stat_btnReset, $script:stat_btnClose))
    $global:statForm.ActiveControl = $script:stat_btnClose
    $global:statForm.Add_Shown({
        Set-WindowDarkTheme $global:statForm
        $script:stat_btnClose.Focus() | Out-Null
        if ($global:LastSoloBlockHeight -le 0) { Check-LastSoloBlock }
    })
    $global:statForm.Show()
}

function Invoke-BlockAlert {
    param([string]$bLine)
    $time = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    $blockHeight = $null
    foreach ($l in @($global:RecentLines)) { if ($l -match "Block\s+(\d+)") { $blockHeight = $Matches[1] } }

    $nl = [Environment]::NewLine
    $logText  = "[$time] ===== BLOCO ENCONTRADO =====" + $nl
    if ($blockHeight) { $logText += "Bloco (altura): $blockHeight" + $nl }
    $logText += "Threads em uso: $($global:CurrentThreads)" + $nl + "Linha do evento: $bLine" + $nl + "--- Contexto ---" + $nl + (@($global:RecentLines) -join $nl) + $nl
    $logText | Out-File -FilePath $global:LogFile -Append -Encoding utf8

    $global:SoundFile = Join-Path $global:ResPath $global:SoundFileName
    if (Test-Path $global:SoundFile) {
        try {
            if ($null -ne $global:SoundPlayer) { $global:SoundPlayer.Stop(); $global:SoundPlayer.Close() }
            $global:SoundPlayer = New-Object System.Windows.Media.MediaPlayer
            $global:SoundPlayer.Open([Uri]$global:SoundFile); $global:SoundPlayer.Play()
        } catch {}
    }

    if (-not $global:Visible) { Toggle-LogWindow }

    if ($null -ne $global:alertForm -and (-not $global:alertForm.IsDisposed)) {
        try { $global:alertForm.Close() } catch {}
    }

    $global:alertForm = New-Object System.Windows.Forms.Form
    $global:alertForm.Text = "$($global:ShortVersion) - $(Get-Text 'AlertWinTitle')"
    $global:alertForm.Size = New-Object System.Drawing.Size(580, 380); $global:alertForm.StartPosition = "CenterScreen"
    $global:alertForm.BackColor = Get-WindowBgColor; $global:alertForm.FormBorderStyle = "FixedSingle"; $global:alertForm.MaximizeBox = $false
    $global:alertForm.ShowIcon = $true; $global:alertForm.ShowInTaskbar = $true; $global:alertForm.Icon = $global:AppIcon

    $cleanWallet = $global:Wallet -replace '\..*?$', ''; $q = [char]34
    $infoText = $(if ($blockHeight) { "$(Get-Text 'AlertBlockHeight') $blockHeight$nl" } else { "" }) +
                "$(Get-Text 'AlertCheckWallet') $q$cleanWallet$q$nl$(Get-Text 'AlertRewardInfo')$nl$(Get-Text 'AlertLogInfo') $($q)BLOCK_FOUND_LOG.txt$($q) $(Get-Text 'AlertInFolder')"

    $script:alrt_lblTitle = New-UiLabel (Get-Text "AlertHeader") 110 20 0 0 (New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)) (Get-AccentOrangeColor)
    $script:alrt_lblInfo  = New-UiLabel $infoText 20 62 0 0 (New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Regular)) (Get-PrimaryTextColor)

    $script:alrt_txtDetails = New-Object System.Windows.Forms.TextBox
    $script:alrt_txtDetails.Text = $bLine; $script:alrt_txtDetails.Multiline = $true; $script:alrt_txtDetails.BorderStyle = "None"
    $script:alrt_txtDetails.Location = New-Object System.Drawing.Point(25, 175); $script:alrt_txtDetails.Size = New-Object System.Drawing.Size(510, 65)
    $script:alrt_txtDetails.ReadOnly = $true; $script:alrt_txtDetails.TabStop = $false
    $script:alrt_txtDetails.BackColor = Get-VisorBgColor; $script:alrt_txtDetails.ForeColor = Get-GreenTextColor
    $script:alrt_txtDetails.Font = New-Object System.Drawing.Font("Consolas", 11)

    $global:alertForm.Add_Paint({
        param($s, $e)
        $bFill = New-Object System.Drawing.SolidBrush((Get-VisorBgColor))
        $pBronze = New-Object System.Drawing.Pen($global:ColorBronzeBorder, 1)
        $e.Graphics.FillRectangle($bFill, 20, 170, 520, 75); $e.Graphics.DrawRectangle($pBronze, 20, 170, 519, 74)
        $bFill.Dispose(); $pBronze.Dispose()
    })

    $script:alrt_btnSave = New-Object System.Windows.Forms.Button
    $script:alrt_btnSave.Text = Get-Text "BtnSaveImg"; $script:alrt_btnSave.Location = New-Object System.Drawing.Point(20, 275); $script:alrt_btnSave.Size = New-Object System.Drawing.Size(140, 40)
    $script:alrt_btnSave.Font = New-Object System.Drawing.Font("Segoe UI", 10); Set-ObsidianButtonStyle $script:alrt_btnSave $false

    $script:alrt_btnClose = New-Object System.Windows.Forms.Button
    $script:alrt_btnClose.Text = Get-Text "BtnCelebrate"; $script:alrt_btnClose.Location = New-Object System.Drawing.Point(400, 275); $script:alrt_btnClose.Size = New-Object System.Drawing.Size(140, 40)
    $script:alrt_btnClose.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold); Set-ObsidianButtonStyle $script:alrt_btnClose $false
    $script:alrt_btnClose.Add_Click({
        if ($null -ne $global:SoundPlayer) { try { $global:SoundPlayer.Stop() } catch {} }
        Play-EffectSound $global:SfxCelebrateMario
        $global:alertForm.Close()
    })

    $script:alrt_btnSave.Add_Click({
        $bmp = Copy-WindowScreenImage $global:alertForm $script:alrt_btnClose
        $sfd = New-Object System.Windows.Forms.SaveFileDialog
        $sfd.Filter = "PNG Image|*.png"; $sfd.FileName = "MinerIsma_Bloco_$(Get-Date -Format 'yyyyMMdd_HHmmss').png"
        if (($sfd.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) -and ($null -ne $bmp)) { $bmp.Save($sfd.FileName, [System.Drawing.Imaging.ImageFormat]::Png) }
        if ($null -ne $bmp) { $bmp.Dispose() }
    })

    $global:alertForm.Tag = {
        $script:alrt_lblTitle.ForeColor   = Get-AccentOrangeColor
        $script:alrt_lblInfo.ForeColor    = Get-PrimaryTextColor
        $script:alrt_txtDetails.BackColor = Get-VisorBgColor; $script:alrt_txtDetails.ForeColor = Get-GreenTextColor
        Set-ObsidianButtonStyle $script:alrt_btnSave $false; Set-ObsidianButtonStyle $script:alrt_btnClose $false
    }

    $global:alertForm.Add_FormClosing({ if ($null -ne $global:SoundPlayer) { try { $global:SoundPlayer.Stop() } catch {} } })
    $global:alertForm.Add_FormClosed({ $global:alertForm = $null })
    $global:alertForm.Controls.AddRange(@($script:alrt_lblTitle, $script:alrt_lblInfo, $script:alrt_txtDetails, $script:alrt_btnSave, $script:alrt_btnClose))
    $global:alertForm.ActiveControl = $script:alrt_btnClose
    $global:alertForm.Add_Shown({
        Set-WindowDarkTheme $global:alertForm
        $script:alrt_txtDetails.SelectionLength = 0
        $script:alrt_btnClose.Focus() | Out-Null
    })
    $global:alertForm.Show()
}

# ============================================================
# API DO BITCOIN (COINGECKO) + DOLAR/EURO OFICIAL (AWESOMEAPI)
# ============================================================
function Update-FiatMenuLabel {
    if ($null -eq $global:usdBrlPriceItem) { return }
    $valStr = if ($global:Language -eq "PT") { $global:LastUsdBrlFormatted } else { $global:LastUsdEurFormatted }
    if (-not [string]::IsNullOrWhiteSpace($valStr)) {
        $global:usdBrlPriceItem.Text = "$(Get-Text 'UsdNowPrefix') $valStr"
    } else {
        $global:usdBrlPriceItem.Text = Get-Text "UsdUpdating"
    }
}

function Update-UsdBrlPrice {
    if (-not (Test-InternetConnected)) { return }
    try {
        $rawFiat = Fetch-UrlTextContent $global:FiatPriceUrl
        if (-not [string]::IsNullOrWhiteSpace($rawFiat)) {
            $jFiat = $rawFiat | ConvertFrom-Json
            if (($null -ne $jFiat.USDBRL) -and ($null -ne $jFiat.USDBRL.bid)) {
                $brlVal = [double]::Parse([string]$jFiat.USDBRL.bid, [System.Globalization.CultureInfo]::InvariantCulture)
                $global:LastUsdBrlFormatted = $brlVal.ToString("N2", [System.Globalization.CultureInfo]::GetCultureInfo("pt-BR"))
            }
            if (($null -ne $jFiat.USDEUR) -and ($null -ne $jFiat.USDEUR.bid)) {
                $eurVal = [double]::Parse([string]$jFiat.USDEUR.bid, [System.Globalization.CultureInfo]::InvariantCulture)
                $numCult = if ($global:Language -eq "EN") { [System.Globalization.CultureInfo]::InvariantCulture } else { [System.Globalization.CultureInfo]::GetCultureInfo("pt-BR") }
                $global:LastUsdEurFormatted = $eurVal.ToString("N2", $numCult)
            }
            Update-FiatMenuLabel
        }
    } catch {}
}

function Update-BtcPrice {
    if (-not (Test-InternetConnected)) { return }
    try {
        $url = $global:BtcPriceUrl + "&t=" + [DateTimeOffset]::Now.ToUnixTimeMilliseconds()
        $req = [System.Net.WebRequest]::Create($url)
        $req.Method = "GET"; $req.Timeout = 2500; $req.UserAgent = "MinerIsma/2.1.2"
        $res = $req.GetResponse(); $stream = $res.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($stream)
        $jsonText = $reader.ReadToEnd()
        $reader.Close(); $stream.Close(); $res.Close()

        $json = $jsonText | ConvertFrom-Json
        if ($json.bitcoin.usd) {
            $price = [double]$json.bitcoin.usd
            $global:LastBtcUsdValue = $price
            $global:LastBtcUsdFormatted = $price.ToString("N2", [System.Globalization.CultureInfo]::InvariantCulture)
            $global:btcPriceItem.Text = "$($global:BtcSym)$(Get-Text 'BtcNowPrefix')$($global:LastBtcUsdFormatted)"
        }
    } catch {}
    Update-UsdBrlPrice
}

function New-TrayIcon {
    $bmp = New-Object System.Drawing.Bitmap(32, 32)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias; $g.Clear([System.Drawing.Color]::Transparent)
    $brushOrange = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 247, 147, 26))
    $g.FillEllipse($brushOrange, 1, 1, 30, 30)
    $penWhite = New-Object System.Drawing.Pen([System.Drawing.Color]::White, 3)
    $penWhite.StartCap = [System.Drawing.Drawing2D.LineCap]::Round; $penWhite.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
    $g.DrawLine($penWhite, 8, 24, 22, 10); $g.DrawLine($penWhite, 16, 6, 26, 16)
    $brushOrange.Dispose(); $penWhite.Dispose(); $g.Dispose()
    return [System.Drawing.Icon]::FromHandle($bmp.GetHicon())
}

$global:HIconBig = [IntPtr]::Zero; $global:HIconSmall = [IntPtr]::Zero

function Get-MinerIsmaIcon {
    $candidates = @($global:CustomIconPath, (Join-Path $global:RootPath $global:CustomIconFileName), (Join-Path $global:BasePath $global:CustomIconFileName))
    foreach ($p in $candidates) {
        if (($null -ne $p) -and (Test-Path -LiteralPath $p)) {
            try {
                $hBig = [ProcCtl]::LoadImage([IntPtr]::Zero, $p, 1, 256, 256, 0x0010)
                if ($hBig -eq [IntPtr]::Zero) { $hBig = [ProcCtl]::LoadImage([IntPtr]::Zero, $p, 1, 0, 0, 0x0010 -bor 0x0040) }
                $hSml = [ProcCtl]::LoadImage([IntPtr]::Zero, $p, 1, 32, 32, 0x0010)
                if ($hBig -ne [IntPtr]::Zero) { $global:HIconBig = $hBig }
                if ($hSml -ne [IntPtr]::Zero) { $global:HIconSmall = $hSml }
                if ($hBig -ne [IntPtr]::Zero) { return [System.Drawing.Icon]::FromHandle($hBig) }
            } catch {}
            try {
                $icoObj = New-Object System.Drawing.Icon($p)
                $global:HIconBig = $icoObj.Handle; $global:HIconSmall = $icoObj.Handle; return $icoObj
            } catch {}
            try {
                $bmpObj = New-Object System.Drawing.Bitmap($p); $hBmp = $bmpObj.GetHicon()
                $global:HIconBig = $hBmp; $global:HIconSmall = $hBmp; return [System.Drawing.Icon]::FromHandle($hBmp)
            } catch {}
        }
    }
    $fallbackIco = New-TrayIcon
    $global:HIconBig = $fallbackIco.Handle; $global:HIconSmall = $fallbackIco.Handle; return $fallbackIco
}

$global:AppIcon = Get-MinerIsmaIcon
try {
    $conHwnd = [ProcCtl]::GetConsoleWindow()
    if ($conHwnd -ne [IntPtr]::Zero -and $null -ne $global:AppIcon) {
        [ProcCtl]::SendMessage($conHwnd, 0x0080, [IntPtr]0, $global:HIconSmall) | Out-Null
        [ProcCtl]::SendMessage($conHwnd, 0x0080, [IntPtr]1, $global:HIconBig) | Out-Null
    }
} catch {}

$global:notifyIcon = New-Object System.Windows.Forms.NotifyIcon
$global:notifyIcon.Icon = $global:AppIcon
$global:notifyIcon.Text = "$($global:ShortVersion)" + [Environment]::NewLine + (Get-Text "TrayWaitStart")
$global:notifyIcon.Visible = $true

$global:logForm = New-Object System.Windows.Forms.Form
$global:logForm.Text = "$($global:ShortVersion) - Console"; $global:logForm.Size = New-Object System.Drawing.Size(900, 520)
$global:logForm.StartPosition = "CenterScreen"; $global:logForm.ShowIcon = $true; $global:logForm.ShowInTaskbar = $true
$global:logForm.BackColor = Get-WindowBgColor; $global:logForm.Icon = $global:AppIcon

$global:logHostPanel = New-Object System.Windows.Forms.Panel
$global:logHostPanel.Dock = "Fill"; $global:logHostPanel.BackColor = [System.Drawing.Color]::FromArgb(9, 13, 18)

$global:logScrollBar = New-Object ObsidianVScrollBar
$global:logScrollBar.Dock = "Right"; $global:logScrollBar.IsLightMode = ($global:Theme -eq "Light")

$global:logBox = New-Object System.Windows.Forms.RichTextBox
$global:logBox.ReadOnly = $true; $global:logBox.ScrollBars = [System.Windows.Forms.RichTextBoxScrollBars]::ForcedVertical
$global:logBox.BackColor = [System.Drawing.Color]::FromArgb(9, 13, 18); $global:logBox.ForeColor = [System.Drawing.Color]::DarkGray
$global:logBox.Font = New-Object System.Drawing.Font("Consolas", 10); $global:logBox.BorderStyle = "None"

$global:logScrollBar.TargetBox = $global:logBox
$global:logBox.Add_VScroll({ $global:logScrollBar.Invalidate() })
$global:logBox.Add_TextChanged({ $global:logScrollBar.Invalidate() })
$global:logHostPanel.Add_Resize({
    $sbW = [System.Windows.Forms.SystemInformation]::VerticalScrollBarWidth
    $global:logBox.SetBounds(0, 0, ($global:logHostPanel.ClientSize.Width + $sbW), $global:logHostPanel.ClientSize.Height)
    $global:logScrollBar.Invalidate()
})

$global:logHostPanel.Controls.Add($global:logBox)
$global:logForm.Controls.AddRange(@($global:logHostPanel, $global:logScrollBar))
$sbInitW = [System.Windows.Forms.SystemInformation]::VerticalScrollBarWidth
$global:logBox.SetBounds(0, 0, ($global:logHostPanel.ClientSize.Width + $sbInitW), $global:logHostPanel.ClientSize.Height)
Set-WindowDarkTheme $global:logForm

$global:logForm.Add_FormClosing({
    param($s, $e)
    if ($e.CloseReason -eq [System.Windows.Forms.CloseReason]::UserClosing) {
        $e.Cancel = $true; $global:logForm.Hide(); $global:Visible = $false
    }
})

function Toggle-LogWindow {
    if ($global:Visible) {
        $global:Visible = $false; $global:logForm.Hide()
    } else {
        $global:Visible = $true; $global:logForm.Show(); Set-WindowDarkTheme $global:logForm
        if ($global:logForm.WindowState -eq "Minimized") { $global:logForm.WindowState = "Normal" }
        $global:logBox.SelectionStart = $global:logBox.TextLength; $global:logBox.ScrollToCaret()
        $global:logScrollBar.Invalidate(); $global:logForm.Activate()
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
        if ($h -ne [IntPtr]::Zero) { [ProcCtl]::SuspendThread($h) | Out-Null; [ProcCtl]::CloseHandle($h) | Out-Null }
    }
}

function Resume-MinerProcess {
    if (-not $global:CurrentProc -or $global:CurrentProc.HasExited) { return }
    $global:CurrentProc.Refresh()
    foreach ($t in $global:CurrentProc.Threads) {
        $h = [ProcCtl]::OpenThread(0x0002, $false, [uint32]$t.Id)
        if ($h -ne [IntPtr]::Zero) { [ProcCtl]::ResumeThread($h) | Out-Null; [ProcCtl]::CloseHandle($h) | Out-Null }
    }
}

function Disable-PulseMode {
    param([bool]$Silent = $false)
    if ($global:PulseMode -ne "") {
        $oldMode = $global:PulseMode
        $global:PulseMode = ""; $global:PulseActiveMins = 0; $global:PulsePauseMins = 0; $global:PulseNextSwitch = $null
        Save-MinerConfig
        if ($null -ne $global:itemPulse1) { $global:itemPulse1.Checked = $false }
        if ($null -ne $global:itemPulse2) { $global:itemPulse2.Checked = $false }
        if (-not $Silent) { $global:LogQueue.Enqueue("[SISTEMA] Modo Pulsar ($oldMode): DESATIVADO.") }
    }
}

function Set-PulseMode {
    param([string]$ModeName, [int]$ActiveMins, [int]$PauseMins)
    if ($global:PulseMode -eq $ModeName) {
        Disable-PulseMode $false
        if ($global:IsPaused) { Invoke-ResumeMining $false }
        return
    }
    $global:PulseMode = $ModeName; $global:PulseActiveMins = $ActiveMins; $global:PulsePauseMins = $PauseMins
    Save-MinerConfig
    if ($global:IsPaused) {
        Resume-MinerProcess; $global:IsPaused = $false; $global:PauseResumeAt = $null
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
    if ($global:PulseMode -ne "") { $global:PulseNextSwitch = $null }
    if (-not $global:IsPaused) { Suspend-MinerProcess; $global:IsPaused = $true }
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
    $global:IsPaused = $false; $global:PauseResumeAt = $null
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
        $global:StopRequested = $true; $global:CurrentProc.Kill(); Start-Sleep -Milliseconds 500
    }
    Get-Process -Name "cpuminer*" -ErrorAction SilentlyContinue | Stop-Process -Force

    if (-not (Test-Path $global:MinerExe)) {
        $global:LogQueue.Enqueue("[SISTEMA] ERRO: miner nao encontrado: $($global:MinerExe)")
        Write-ErrorLog "Minerador nao encontrado em $($global:BasePath)"
        return
    }

    $global:CurrentThreads = $Threads; $Affinity = Get-Affinity $Threads
    if ([string]::IsNullOrWhiteSpace($Affinity)) {
        $chaves = ($global:ThreadProfiles.Keys | ForEach-Object { [string]$_ }) -join ", "
        $msg = "Perfil de $Threads threads nao existe. Configurados: $chaves"
        $global:LogQueue.Enqueue("[SISTEMA] ERRO: $msg"); Write-ErrorLog $msg
        try { $global:notifyIcon.ShowBalloonTip(8000, "$($global:ShortVersion) - Erro", $msg, [System.Windows.Forms.ToolTipIcon]::Error) } catch {}
        return
    }

    $ArgList = "-a sha256d -o $($global:PoolUrl) -u $($global:Wallet) -p x -t $Threads --cpu-affinity $Affinity $($global:ExtraArgs)".Trim() -replace '\s+',' '
    if ($null -ne $global:advForm -and (-not $global:advForm.IsDisposed)) {
        try { & $script:adv_updatePreview } catch {}
    }

    try {
        $StartInfo = New-Object System.Diagnostics.ProcessStartInfo
        $StartInfo.FileName = $global:MinerExe; $StartInfo.Arguments = $ArgList; $StartInfo.WorkingDirectory = $global:BasePath
        $StartInfo.UseShellExecute = $false; $StartInfo.RedirectStandardOutput = $true; $StartInfo.RedirectStandardError = $true; $StartInfo.CreateNoWindow = $true

        $global:CurrentProc = New-Object System.Diagnostics.Process
        $global:CurrentProc.StartInfo = $StartInfo

        Get-EventSubscriber | Where-Object SourceIdentifier -match "MinerOut|MinerErr" | Unregister-Event -ErrorAction SilentlyContinue
        Get-Event | Where-Object SourceIdentifier -match "MinerOut|MinerErr" | Remove-Event -ErrorAction SilentlyContinue

        Register-ObjectEvent -InputObject $global:CurrentProc -EventName OutputDataReceived -SourceIdentifier "MinerOut" | Out-Null
        Register-ObjectEvent -InputObject $global:CurrentProc -EventName ErrorDataReceived -SourceIdentifier "MinerErr" | Out-Null

        $global:CurrentProc.Start() | Out-Null
        $global:CurrentProc.BeginOutputReadLine(); $global:CurrentProc.BeginErrorReadLine()

        $global:StopRequested = $false; $global:CrashNotified = $false
        $global:TtfLogAllowedAt = (Get-Date).AddSeconds($global:TtfWarmupSeconds)
        $global:LogQueue.Enqueue("[SISTEMA] Comando: $($global:DetectedMinerExe) $ArgList")
        $global:LogQueue.Enqueue("[SISTEMA] $($global:AppVersion) iniciado com $Threads Threads (Afinidade $Affinity)")
        if ($global:PulseMode -ne "") {
            $global:PulseNextSwitch = (Get-Date).AddMinutes($global:PulseActiveMins)
            $global:LogQueue.Enqueue("[SISTEMA] Modo Pulsar ($($global:PulseMode)) ativo na memoria (proxima pausa as $($global:PulseNextSwitch.ToString('HH:mm'))).")
        }
        $global:LogQueue.Enqueue("[SISTEMA] Para opcoes, clique com o botao Direito no icone do Tray")
    } catch {
        $global:LogQueue.Enqueue("[SISTEMA] ERRO ao iniciar o miner: $($_.Exception.Message)")
        Write-ErrorLog "Falha ao iniciar miner: $($_.Exception.Message)"
    }
}

# ============================================================
# MENUS DO TRAY E SUBMENUS COM CRIADOR AUTOMATICO (V2.1.2)
# ============================================================
$menu = New-Object System.Windows.Forms.ContextMenuStrip
$script:KeepMenuOpenOnLangChange = $false
$menu.Add_Closing({
    param($sender, $e)
    if ($script:KeepMenuOpenOnLangChange -and ($e.CloseReason -eq [System.Windows.Forms.ToolStripDropDownCloseReason]::ItemClicked)) {
        $e.Cancel = $true
        $script:KeepMenuOpenOnLangChange = $false
    }
})

$global:I18nMenuMap = New-Object System.Collections.Generic.List[object]

function Register-I18nItem {
    param($Item, [string]$Key, [string]$Prefix = "")
    $global:I18nMenuMap.Add([pscustomobject]@{ Item = $Item; Key = $Key; Prefix = $Prefix })
}

function Add-MenuHeader {
    param([System.Windows.Forms.ToolStripMenuItem]$ParentMenu, [string]$LangKey)
    $lbl = New-Object System.Windows.Forms.ToolStripLabel((Get-Text $LangKey))
    $lbl.Name = "SubHeaderLabel"
    $lbl.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
    Register-I18nItem $lbl $LangKey
    $ParentMenu.DropDownItems.Add($lbl) | Out-Null
    $ParentMenu.DropDownItems.Add("-") | Out-Null
    return $lbl
}

function Add-MenuLink {
    param($ParentMenu, [string]$KeyOrText, $Target, [bool]$IsTranslated = $true, [string]$Prefix = "")
    $txt = if ($IsTranslated) { "$Prefix$(Get-Text $KeyOrText)" } else { "$Prefix$KeyOrText" }
    $item = New-Object System.Windows.Forms.ToolStripMenuItem($txt)
    if ($IsTranslated) { Register-I18nItem $item $KeyOrText $Prefix }
    if ($Target -is [scriptblock]) {
        $item.Add_Click($Target)
    } elseif (-not [string]::IsNullOrWhiteSpace([string]$Target)) {
        $item.Tag = [string]$Target
        $item.Add_Click({ Start-Process ([string]$this.Tag) })
    }
    if ($ParentMenu -is [System.Windows.Forms.ContextMenuStrip]) {
        $ParentMenu.Items.Add($item) | Out-Null
    } else {
        $ParentMenu.DropDownItems.Add($item) | Out-Null
    }
    return $item
}

$global:notifyIcon.Add_MouseClick({ param($s, $e) if ($e.Button -eq [System.Windows.Forms.MouseButtons]::Left) { Toggle-LogWindow } })

# 1. Cabecalho Laranja: ⟳ (Ciano na margem esquerda se houver update) + MinerIsma v2.1.2 + [☾]/[☀] e [BR] ▸
$headerItem = New-Object System.Windows.Forms.ToolStripMenuItem("$($global:ShortVersion)                    ")
$headerItem.Name = "HeaderItem"; $headerItem.Padding = New-Object System.Windows.Forms.Padding(0, 4, 0, 4)
$headerItem.ForeColor = [System.Drawing.Color]::FromArgb(255, 247, 147, 26)
$headerItem.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)

$langMenuItems = @{}
foreach ($entry in ([ordered]@{ "PT" = "Portugues"; "EN" = "English"; "ES" = "Espanol" }).GetEnumerator()) {
    $lItem = New-Object System.Windows.Forms.ToolStripMenuItem([string]$entry.Value)
    $lItem.Tag = [string]$entry.Key
    $lItem.Add_MouseDown({ $script:KeepMenuOpenOnLangChange = $true })
    $lItem.Add_Click({
        $script:KeepMenuOpenOnLangChange = $true
        Set-AppLanguage ([string]$this.Tag)
    })
    $headerItem.DropDownItems.Add($lItem) | Out-Null
    $langMenuItems[[string]$entry.Key] = $lItem
}

$headerItem.Add_MouseDown({
    param($sender, $e)
    if ($e.Button -eq [System.Windows.Forms.MouseButtons]::Left) {
        if ($global:UpdateAvailable -and ($e.X -ge 0) -and ($e.X -le 26)) { Open-UpdateDownloadLink }
        elseif (($e.X -ge ($sender.Width - 74)) -and ($e.X -lt ($sender.Width - 44))) { Set-AppTheme $(if ($global:Theme -eq "Light") { "Dark" } else { "Light" }) }
        elseif ($e.X -ge ($sender.Width - 44)) { $sender.ShowDropDown() }
    }
})
$menu.Items.Add($headerItem) | Out-Null
$menu.Items.Add("-") | Out-Null

# 2. Bitcoin Agora (CoinGecko) clicavel abrindo CoinGecko
$global:btcPriceItem = New-Object System.Windows.Forms.ToolStripMenuItem("$($global:BtcSym)$(Get-Text 'BtcUpdating')")
$global:btcPriceItem.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
$global:btcPriceItem.Add_Click({ Start-Process $global:UrlCoinGecko })
$menu.Items.Add($global:btcPriceItem) | Out-Null
$menu.Items.Add("-") | Out-Null

# 3A. Submenu Bitcoin Links
$global:itemLinksMenu = Add-MenuLink $menu "BtcLinks" $null $true $global:BtcSym
Add-MenuHeader $global:itemLinksMenu "UsefulLinksHdr" | Out-Null
Add-MenuLink $global:itemLinksMenu "LinkMempool"   "https://mempool.space/pt/" | Out-Null
Add-MenuLink $global:itemLinksMenu "LinkTimeline"  "https://chaintimeline.com/" | Out-Null
Add-MenuLink $global:itemLinksMenu "LinkBlueWallet" $global:UrlBlueWallet | Out-Null
Add-MenuLink $global:itemLinksMenu "LinkHardWallet" "https://prohash.com.br" | Out-Null
Add-MenuLink $global:itemLinksMenu "LinkP2pBtc"    "https://www.alfredp2p.io" | Out-Null
Add-MenuLink $global:itemLinksMenu "LinkContaBtc"  "https://usepicnic.com/br" | Out-Null
Add-MenuLink $global:itemLinksMenu "LinkAtomicBtc" "https://sideshift.ai/a/MAZjxivlP" | Out-Null
Add-MenuLink $global:itemLinksMenu "LinkLearn"     "https://bitcoinpuzzles.io/pt/aulas" | Out-Null
Add-MenuLink $global:itemLinksMenu "LinkBtcCore"   "https://bitcoin.org/pt_BR" | Out-Null
Add-MenuLink $global:itemLinksMenu "LinkMissao1Btc" "https://missao-1-btc.onrender.com/" | Out-Null
Add-MenuLink $global:itemLinksMenu "LinkRetireBtc" "https://aaronlil.github.io/btc-retirement-planner/" | Out-Null
Add-MenuLink $global:itemLinksMenu "LinkCalcCripto" $global:UrlCalcConverter | Out-Null
Add-MenuLink $global:itemLinksMenu "LinkBtcMaps"   "https://btcmap.org/" | Out-Null
Add-MenuLink $global:itemLinksMenu "Whitepaper Satoshi" "https://bitcoin.org/files/bitcoin-paper/bitcoin_pt_br.pdf" $false | Out-Null
Add-MenuLink $global:itemLinksMenu "LinkLayer2Lgt" { Open-LightningIntroLink } | Out-Null
Add-MenuLink $global:itemLinksMenu "LinkWalletLgt" "https://www.walletofsatoshi.com" | Out-Null
Add-MenuLink $global:itemLinksMenu "LinkGpuMiner"  "https://www.kryptex.com/?ref=2103d720" | Out-Null

# 3B. Submenu Bitcoin Games
$global:itemGamesMenu = Add-MenuLink $menu "itcoin Games" $null $false $global:BtcSym
Add-MenuHeader $global:itemGamesMenu "UsefulLinksHdr" | Out-Null
Add-MenuLink $global:itemGamesMenu "21 Million"        { Open-GameWindow "https://kwertykwerty2.itch.io/21-million-demo" } $false | Out-Null
Add-MenuLink $global:itemGamesMenu "Puzzle 1000 BTC $" "https://bitcoinpuzzles.io/pt/puzzles/1000btc" $false | Out-Null
Add-MenuLink $global:itemGamesMenu "GameDesafios"      "https://bitcoinpuzzles.io/pt" | Out-Null
Add-MenuLink $global:itemGamesMenu "Puzzle 71 $"       "https://krackpot.io/" $false | Out-Null
Add-MenuLink $global:itemGamesMenu "Mestre Cacatal"    "https://www.youtube.com/channel/UCjVt3SWdIQL7Ty5ITXgEqnA" $false | Out-Null
Add-MenuLink $global:itemGamesMenu "GameBoard"         "https://bitcoincreative.org/biblioteca/to-the-moon-jogo-de-tabuleiro/" | Out-Null
Add-MenuLink $global:itemGamesMenu "Sunny Land"        { Open-GameWindow "https://alzahira.itch.io/en-busca-del-bitcoin-en-sunnyland" } $false | Out-Null

# 3C. Submenu Canais Cripto (Links Inspiradores + Cripto Traders com IDs permanentes)
$global:itemChannelsMenu = Add-MenuLink $menu "MenuChannels" $null
Add-MenuHeader $global:itemChannelsMenu "InspiringLinksHdr" | Out-Null
$channelsInspiradores = [ordered]@{
    "Bitnada"            = "https://www.youtube.com/channel/UCT50TWqh-Z5eo6DKJSabOMA"
    "Joao Hazim"         = "https://www.youtube.com/channel/UCkuQgEkF6nq26tcFKgCtgpg"
    "Denny Torres"       = "https://www.youtube.com/channel/UCxfUF7Kkr9JMFe8HzYeRNjA"
    "Juliano Caju"       = "https://www.youtube.com/channel/UC6m6J4QX0T3COcimWlsoxDw"
    "Hiago Driver"       = "https://www.youtube.com/channel/UChFLspccAZu8jvdQThbk_Mg"
    "Augusto Backes"     = "https://www.youtube.com/channel/UCNGqYuEd86K7dY70jE6dhKg"
    "Investidor 4.20"    = "https://www.youtube.com/channel/UC8oofAsuieQv3imZGvaUDOQ"
    "Prometheus HODL"    = "https://www.youtube.com/channel/UCgYcxn8JISuaSUGiKt708fg"
    "Renato Trezoitao"   = "https://www.youtube.com/channel/UCC-r6vnXtcwBYq0VxZYhoXg"
    "Ronaldeira Cripto"  = "https://www.youtube.com/channel/UCWLLvlKt9d0xxqq-j5M92xg"
    "BernardoPascowitch" = "https://www.youtube.com/channel/UCoNkJtAvRbc0t_KR8PSNs8w"
}
foreach ($entry in $channelsInspiradores.GetEnumerator()) {
    Add-MenuLink $global:itemChannelsMenu ([string]$entry.Key) ([string]$entry.Value) $false | Out-Null
}
$global:itemChannelsMenu.DropDownItems.Add("-") | Out-Null
Add-MenuHeader $global:itemChannelsMenu "TradersHdr" | Out-Null
$channelsTraders = [ordered]@{
    "Silveira Trader" = "https://www.youtube.com/channel/UCrSMB3hTnrxa8pM-ls0E_Pw"
    "DK CriptoTrader" = "https://www.youtube.com/channel/UC79S0IaSKp5quncCzwp_UBg"
    "Tori Trades"     = "https://www.youtube.com/channel/UC0ep2A36j7gTFdqW2Yvngbg"
    "Vela Trader"     = "https://www.youtube.com/channel/UC4nrWTj-YsYTLXvw7V5R-5g"
}
foreach ($entry in $channelsTraders.GetEnumerator()) {
    Add-MenuLink $global:itemChannelsMenu ([string]$entry.Key) ([string]$entry.Value) $false | Out-Null
}

# 3D. Submenu Portais Cripto (Com Dolar agora: R$ / € clicavel + Portais)
$global:itemPortalsMenu = Add-MenuLink $menu "MenuPortals" $null
Add-MenuHeader $global:itemPortalsMenu "UsefulLinksHdr" | Out-Null
$global:usdBrlPriceItem = New-Object System.Windows.Forms.ToolStripMenuItem((Get-Text "UsdUpdating"))
$global:usdBrlPriceItem.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
$global:usdBrlPriceItem.Add_Click({ Start-Process $global:UrlCalcConverter })
$global:itemPortalsMenu.DropDownItems.Add($global:usdBrlPriceItem) | Out-Null
$global:itemPortalsMenu.DropDownItems.Add("-") | Out-Null

Add-MenuLink $global:itemPortalsMenu "LinkMonitor"       "https://mercado.bitnada.com.br" | Out-Null
Add-MenuLink $global:itemPortalsMenu "LinkNews"          "https://bitnoticias.com.br" | Out-Null
Add-MenuLink $global:itemPortalsMenu "LinkCoinGecko"     $global:UrlCoinGecko | Out-Null
Add-MenuLink $global:itemPortalsMenu "LinkGlobalAcc"     "https://usepicnic.com/br" | Out-Null
Add-MenuLink $global:itemPortalsMenu "LinkMultiWallet"   "https://rabby.io" | Out-Null
Add-MenuLink $global:itemPortalsMenu "LinkAtomicSwap"    "https://pancakeswap.finance/swap" | Out-Null
Add-MenuLink $global:itemPortalsMenu "LinkRealizacao"    "https://nakpix.xyz" | Out-Null
Add-MenuLink $global:itemPortalsMenu "Area Bitcoin"      "https://www.areabitcoin.com.br" $false | Out-Null
Add-MenuLink $global:itemPortalsMenu "LinkMinerEvolua"   "https://www.julianocaju.com.br" | Out-Null
Add-MenuLink $global:itemPortalsMenu "Upgrade: PCdoFafa" "https://www.youtube.com/channel/UCI1FHmMbh27WuxHjGXyn2ww" $false | Out-Null
Add-MenuLink $global:itemPortalsMenu "LinkBubbles"       "https://cryptobubbles.net/pt" | Out-Null
$menu.Items.Add("-") | Out-Null

# 4. Subtitulo "Power | CPU ..." e Controle Dinamico de Threads
$global:lblPowerHeader = New-Object System.Windows.Forms.ToolStripLabel($global:PowerHeaderTitle)
$global:lblPowerHeader.Padding = New-Object System.Windows.Forms.Padding(22, 2, 0, 2)
$global:lblPowerHeader.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Regular)
$menu.Items.Add($global:lblPowerHeader) | Out-Null

function Set-ThreadConfig {
    param([int]$t)
    if ($global:IsPaused) { $global:itemPause.Text = Get-Text "MenuPause"; $global:IsPaused = $false; $global:PauseResumeAt = $null }
    if ($global:PulseMode -ne "") { $global:PulseNextSwitch = (Get-Date).AddMinutes($global:PulseActiveMins) }
    $global:CurrentThreads = $t; Save-MinerConfig
    $global:notifyIcon.Text = "$($global:ShortVersion)" + [Environment]::NewLine + "$t Threads | $(Get-Text 'TrayCalculating')"
    Start-MinerTask $t
}

$threadItems = @{}
foreach ($entry in $global:ThreadProfiles.GetEnumerator()) {
    $n = [int]$entry.Key
    $item = New-Object System.Windows.Forms.ToolStripMenuItem([string]$global:ThreadLabels[$n])
    $item.Name = "ThreadItem"; $item.Tag = $n
    $item.Add_Click({ Set-ThreadConfig ([int]$this.Tag) })
    $menu.Items.Add($item) | Out-Null
    $threadItems[$n] = $item
}
$menu.Items.Add("-") | Out-Null

# 5. Painel do Minerador, Iniciar com Windows, Testar Alerta, Tutorial e Compartilhar
function Test-DesktopShortcutExists { return (Test-Path -LiteralPath $global:DesktopShortcutPath) }

function Set-DesktopShortcut {
    param([bool]$Silent = $false)
    if (-not (Test-Path -LiteralPath $global:LauncherPath)) { return }
    try {
        $WshShell = New-Object -ComObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut($global:DesktopShortcutPath)
        $Shortcut.TargetPath = [string]$global:LauncherPath; $Shortcut.WorkingDirectory = [string]$global:RootPath
        if (Test-Path -LiteralPath $global:CustomIconPath) { $Shortcut.IconLocation = "$($global:CustomIconPath),0" }
        $Shortcut.Save()
        if ($null -ne $global:itemDesktopIcon) { $global:itemDesktopIcon.Checked = $true }
        if (-not $Silent) { $global:LogQueue.Enqueue("[SISTEMA] Atalho 'MinerIsma' criado/atualizado na Area de Trabalho.") }
    } catch {
        if (-not $Silent) { $global:LogQueue.Enqueue("[SISTEMA] ERRO ao criar atalho na Area de Trabalho: $($_.Exception.Message)") }
    }
}

function Remove-DesktopShortcut {
    try {
        if (Test-Path -LiteralPath $global:DesktopShortcutPath) { Remove-Item -LiteralPath $global:DesktopShortcutPath -Force -ErrorAction SilentlyContinue }
        if ($null -ne $global:itemDesktopIcon) { $global:itemDesktopIcon.Checked = $false }
        $global:LogQueue.Enqueue("[SISTEMA] Atalho 'MinerIsma' removido da Area de Trabalho.")
    } catch {}
}

if (Test-DesktopShortcutExists) { Set-DesktopShortcut $true }

# 5A. Submenu "Painel do Minerador"
$global:itemMinerPanel = Add-MenuLink $menu "MenuMinerPanel" $null

$global:lnkUpdates = New-Object System.Windows.Forms.ToolStripMenuItem((Get-Text "LinkUpdates"))
$global:lnkUpdates.Name = "UpdateSubItem"
$global:lnkUpdates.Padding = New-Object System.Windows.Forms.Padding(0, 2, -12, 2)
$global:lnkUpdates.Add_Click({ Open-UpdateDownloadLink })
$global:itemMinerPanel.DropDownItems.Add($global:lnkUpdates) | Out-Null

$global:itemWallet   = Add-MenuLink $global:itemMinerPanel "MenuWallet"   { Show-WalletConfig }
$global:itemTtfStats = Add-MenuLink $global:itemMinerPanel "MenuTtfStats" { Show-TtfStats }
$global:lnkPool      = Add-MenuLink $global:itemMinerPanel "LinkPool"     { Open-ActivePoolDashboard }
$global:lnkWeb       = Add-MenuLink $global:itemMinerPanel "LinkWeb" {
    if (-not [string]::IsNullOrWhiteSpace($global:UrlTutorial)) { Start-Process $global:UrlTutorial }
    else { [System.Windows.Forms.MessageBox]::Show((Get-Text "MsgWebSoon"), "$($global:ShortVersion) - Web", 0, 64) | Out-Null }
}
$global:itemDesktopIcon = Add-MenuLink $global:itemMinerPanel "MenuDesktopIcon" {
    if (Test-DesktopShortcutExists) { Remove-DesktopShortcut } else { Set-DesktopShortcut $false }
}
$global:itemDesktopIcon.Checked = (Test-DesktopShortcutExists)
$global:itemAdvanced = Add-MenuLink $global:itemMinerPanel "MenuAdvanced" { Show-AdvancedConfig }
$global:itemSupport  = Add-MenuLink $global:itemMinerPanel "MenuSupport"  { Show-SupportDialog }

# 5B. Submenu "Iniciar com Windows"
$global:itemStartup = Add-MenuLink $menu "MenuStartup" $null
$global:lblDelayHeader = Add-MenuHeader $global:itemStartup "DelayHeader"

function Test-StartupRegistered {
    if (Test-Path -LiteralPath $global:ShortcutPath) { return $true }
    try {
        $regObj = Get-ItemProperty -Path $global:RunRegKey -Name $global:RunRegName -ErrorAction SilentlyContinue
        if (($null -ne $regObj) -and (-not [string]::IsNullOrWhiteSpace($regObj.$($global:RunRegName)))) { return $true }
    } catch {}
    return $false
}

$delayMenuItems = @{}
function Update-StartupMenuChecks {
    $isReg = (Test-StartupRegistered)
    $global:itemStartup.Checked = $isReg
    foreach ($dKey in $delayMenuItems.Keys) { $delayMenuItems[$dKey].Checked = ($isReg -and ($global:ConfiguredDelay -eq $dKey)) }
}

function Enable-WindowsStartup {
    param([int]$DelaySec, [bool]$Silent = $false)
    $global:ConfiguredDelay = $DelaySec; $global:StartupInitialized = $true; $global:StartupEnabled = $true
    Save-MinerConfig
    if (-not (Test-Path -LiteralPath $global:LauncherPath)) {
        if (-not $Silent) { [System.Windows.Forms.MessageBox]::Show("O arquivo '$global:LauncherFileName' nao foi encontrado na pasta raiz.", "Erro", 0, 16) | Out-Null }
        Update-StartupMenuChecks; return
    }
    $registeredOk = $false
    try {
        if (-not (Test-Path -LiteralPath $global:StartupFolder)) { New-Item -ItemType Directory -Path $global:StartupFolder -Force -ErrorAction SilentlyContinue | Out-Null }
        if (Test-Path -LiteralPath $global:ShortcutPath) { Remove-Item -LiteralPath $global:ShortcutPath -Force -ErrorAction SilentlyContinue }
        $WshShell = New-Object -ComObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut($global:ShortcutPath)
        $Shortcut.TargetPath = [string]$global:LauncherPath; $Shortcut.WorkingDirectory = [string]$global:RootPath
        if (Test-Path -LiteralPath $global:CustomIconPath) { $Shortcut.IconLocation = "$($global:CustomIconPath),0" }
        $Shortcut.Save(); $registeredOk = $true
        Remove-ItemProperty -Path $global:RunRegKey -Name $global:RunRegName -ErrorAction SilentlyContinue
    } catch {
        try {
            $q = [char]34
            Set-ItemProperty -Path $global:RunRegKey -Name $global:RunRegName -Value "$q$($global:LauncherPath)$q" -Force -ErrorAction Stop
            $registeredOk = $true
        } catch {
            if (-not $Silent) { $global:LogQueue.Enqueue("[SISTEMA] ERRO ao ativar Iniciar com Windows: $($_.Exception.Message)") }
        }
    }
    Update-StartupMenuChecks
    if (($registeredOk) -and (-not $Silent)) { $global:LogQueue.Enqueue("[SISTEMA] Iniciar com Windows: ATIVADO (Delay: $($DelaySec)s).") }
}

function Disable-WindowsStartup {
    Remove-Item -LiteralPath $global:ShortcutPath -Force -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path $global:RunRegKey -Name $global:RunRegName -ErrorAction SilentlyContinue
    $global:ConfiguredDelay = $global:DefaultStartupDelay; $global:StartupInitialized = $true; $global:StartupEnabled = $false
    Save-MinerConfig; Update-StartupMenuChecks
    $global:LogQueue.Enqueue("[SISTEMA] Iniciar com Windows: DESATIVADO (Delay Padrao: 5s).")
}

foreach ($entry in ([ordered]@{ 5 = (Get-Text "DelayDefault"); 15 = "15seg."; 30 = "30seg."; 60 = "60seg." }).GetEnumerator()) {
    $dKey = [int]$entry.Key
    $dItem = New-Object System.Windows.Forms.ToolStripMenuItem([string]$entry.Value)
    $dItem.Tag = $dKey
    if ($dKey -eq 5) { Register-I18nItem $dItem "DelayDefault" }
    $dItem.Add_Click({
        $chosenDelay = [int]$this.Tag
        if ((Test-StartupRegistered) -and ($global:ConfiguredDelay -eq $chosenDelay)) { Disable-WindowsStartup }
        else { Enable-WindowsStartup $chosenDelay $false }
    })
    $global:itemStartup.DropDownItems.Add($dItem) | Out-Null
    $delayMenuItems[$dKey] = $dItem
}
$global:itemStartup.Add_Click({ if (Test-StartupRegistered) { Disable-WindowsStartup } else { Enable-WindowsStartup $global:ConfiguredDelay $false } })

if ((-not $global:StartupInitialized) -or ($global:StartupEnabled)) {
    $global:StartupInitialized = $true
    if (Test-Path -LiteralPath $global:LauncherPath) { Enable-WindowsStartup $global:ConfiguredDelay $true } else { Save-MinerConfig }
}
$global:StartupDelaySeconds = if (Test-StartupRegistered) { $global:ConfiguredDelay } else { $global:DefaultStartupDelay }
Update-StartupMenuChecks

# 5C. Submenu "Testar Alerta de Bloco"
function Invoke-TestBlockAlert {
    param([string]$SelectedSound)
    if (-not [string]::IsNullOrWhiteSpace($SelectedSound)) {
        $global:SoundFileName = $SelectedSound; $global:SoundFile = Join-Path $global:ResPath $global:SoundFileName; Save-MinerConfig
    }
    $fakeLine = "TESTE MANUAL - Accepted 999 S0 R0 B1, 12.345 sec (yay!!!)"
    $global:LogQueue.Enqueue("[SISTEMA] Simulando descoberta com audio: $($global:SoundFileName)")
    $global:LogQueue.Enqueue($fakeLine)
    Invoke-BlockAlert $fakeLine
}

$global:itemTestAlert  = Add-MenuLink $menu "MenuTestAlert" $null
$global:itemSoundKMS   = Add-MenuLink $global:itemTestAlert "KMS"   { Invoke-TestBlockAlert $global:SoundFileKMS } $false
$global:itemSoundSenna = Add-MenuLink $global:itemTestAlert "Senna" { Invoke-TestBlockAlert $global:SoundFileSenna } $false
$global:itemSoundMforN = Add-MenuLink $global:itemTestAlert "MforN" { Invoke-TestBlockAlert $global:SoundFileMforN } $false
$global:itemSoundCoins = Add-MenuLink $global:itemTestAlert "Coins" { Invoke-TestBlockAlert $global:SoundFileCoins } $false

# 5D. Tutorial e Compartilhar MinerIsma -> Copiar Link
$global:itemTutorial      = Add-MenuLink $menu "MenuTutorial" { Show-Tutorial }
$global:itemShare         = Add-MenuLink $menu "MenuShare"    { Invoke-ShareMinerIsma }
$global:itemCopyShareLink = Add-MenuLink $global:itemShare "MenuCopyLink" { Invoke-ShareMinerIsma }
$menu.Items.Add("-") | Out-Null

# 6. Mostrar/Ocultar e Pausar (com Submenu Manual, Tempos e Modo Pulsar)
$global:itemShowHide = Add-MenuLink $menu "MenuShowHide" { Toggle-LogWindow }
$global:itemPause    = New-Object System.Windows.Forms.ToolStripMenuItem((Get-Text "MenuPause"))
$pauseMenuItems = @{}
foreach ($entry in ([ordered]@{ 0 = "PauseManual"; 15 = "15min."; 30 = "30min."; 60 = "Pause1h"; 120 = "Pause2h" }).GetEnumerator()) {
    $pKey = [int]$entry.Key; $pVal = [string]$entry.Value
    $isTr = ($pKey -in @(0, 60, 120))
    $pItem = New-Object System.Windows.Forms.ToolStripMenuItem($(if ($isTr) { Get-Text $pVal } else { $pVal }))
    $pItem.Tag = $pKey
    if ($isTr) { Register-I18nItem $pItem $pVal }
    $pItem.Add_Click({
        $mins = [int]$this.Tag
        if ($global:IsPaused -and ($mins -eq 0)) { Invoke-ResumeMining $false } else { Set-MinerPause $mins }
    })
    $global:itemPause.DropDownItems.Add($pItem) | Out-Null
    $pauseMenuItems[$pKey] = $pItem
}
$global:itemPause.DropDownItems.Add("-") | Out-Null
$global:itemPulse1 = Add-MenuLink $global:itemPause "Pulse2h" { Set-PulseMode "2hx5" 120 5 }
$global:itemPulse2 = Add-MenuLink $global:itemPause "Pulse4h" { Set-PulseMode "4hx5" 240 5 }
$global:itemPause.Add_Click({ if ($global:IsPaused) { Invoke-ResumeMining $false } else { Set-MinerPause 0 } })
$menu.Items.Add($global:itemPause) | Out-Null
$menu.Items.Add("-") | Out-Null

# 7. Fechar Mineracao
$global:itemExit = Add-MenuLink $menu "MenuExit" {
    $timer.Stop(); $startTimer.Stop(); $btcTimer.Stop(); $updateCheckTimer.Stop(); $soloBlockTimer.Stop(); $global:shareBalloonTimer.Stop()
    if (($global:CurrentProc) -and (-not ($global:CurrentProc.HasExited))) {
        $global:StopRequested = $true
        if ($global:IsPaused) { Resume-MinerProcess }
        $global:CurrentProc.Kill()
    }
    Get-Process -Name "cpuminer*" -ErrorAction SilentlyContinue | Stop-Process -Force
    $global:notifyIcon.Visible = $false; $global:notifyIcon.Dispose(); $global:logForm.Dispose()
    [System.Windows.Forms.Application]::Exit()
}

Set-MenuObsidianTheme $menu

# Comutacao dinamica de idioma via lista automatizada $global:I18nMenuMap mantendo o Menu Principal aberto
function Set-AppLanguage {
    param([string]$LangCode)
    if ($LangCode -notin @("PT", "EN", "ES")) { return }
    $global:Language = $LangCode
    [ObsidianMenuColors]::CurrentLangBadge = if ($global:Language -eq "PT") { "BR" } else { $global:Language }
    Save-MinerConfig

    foreach ($m in $global:I18nMenuMap) {
        if ($null -ne $m.Item) { $m.Item.Text = "$($m.Prefix)$(Get-Text $m.Key)" }
    }

    $global:btcPriceItem.Text = if (-not [string]::IsNullOrWhiteSpace($global:LastBtcUsdFormatted)) {
        "$($global:BtcSym)$(Get-Text 'BtcNowPrefix')$($global:LastBtcUsdFormatted)"
    } else { "$($global:BtcSym)$(Get-Text 'BtcUpdating')" }

    Update-FiatMenuLabel

    $global:lnkUpdates.Text = if ($global:UpdateAvailable -and (-not [string]::IsNullOrWhiteSpace($global:LatestRemoteVersion))) {
        "$(Get-Text 'LinkUpdates') (v$($global:LatestRemoteVersion))"
    } else { Get-Text "LinkUpdates" }

    $global:itemPause.Text = if ($global:IsPaused) { Get-Text "MenuResume" } else { Get-Text "MenuPause" }

    if ($null -ne $global:tutForm -and (-not $global:tutForm.IsDisposed) -and $null -ne $script:tut_web -and $null -ne $script:tut_web.Document) {
        try { $script:tut_web.Document.InvokeScript("setTutorialLang", @([string]$global:Language)) | Out-Null } catch {}
    }

    foreach ($lKey in $langMenuItems.Keys) { $langMenuItems[$lKey].Checked = ($lKey -eq $global:Language) }
    $menu.PerformLayout()
    $menu.Invalidate()
    $global:LogQueue.Enqueue("[SISTEMA] $(Get-Text 'MenuLanguage'): $LangCode")
}

$menu.Add_Opening({
    [ObsidianMenuColors]::CurrentLangBadge  = if ($global:Language -eq "PT") { "BR" } else { $global:Language }
    [ObsidianMenuColors]::IsUpdateAvailable = $global:UpdateAvailable
    $global:itemCopyShareLink.Text          = Get-Text "MenuCopyLink"
    foreach ($n in $threadItems.Keys) { $threadItems[$n].Checked = ($n -eq $global:CurrentThreads) }
    Update-StartupMenuChecks
    $global:itemDesktopIcon.Checked = (Test-DesktopShortcutExists)
    $global:itemSoundKMS.Checked    = ($global:SoundFileName -eq $global:SoundFileKMS)
    $global:itemSoundSenna.Checked  = ($global:SoundFileName -eq $global:SoundFileSenna)
    $global:itemSoundMforN.Checked  = ($global:SoundFileName -eq $global:SoundFileMforN)
    $global:itemSoundCoins.Checked  = ($global:SoundFileName -eq $global:SoundFileCoins)
    $global:itemPulse1.Checked      = ($global:PulseMode -eq "2hx5")
    $global:itemPulse2.Checked      = ($global:PulseMode -eq "4hx5")
    foreach ($lKey in $langMenuItems.Keys) { $langMenuItems[$lKey].Checked = ($lKey -eq $global:Language) }
})

$global:notifyIcon.ContextMenuStrip = $menu

# ============================================================
# TIMERS DE INICIO, PRECO, CHECAGEM DE VERSAO, BLOCO SOLO E LEITURA
# ============================================================
Initialize-CpuDetection

# Se a carteira ainda nao estiver configurada (1a execucao), abre a janela em 0,8s sem esperar os 5s de delay
$startTimer = New-Object System.Windows.Forms.Timer
$startTimer.Interval = if (Test-WalletConfigured) { [Math]::Max(1, $global:StartupDelaySeconds) * 1000 } else { 800 }
$startTimer.Add_Tick({
    $startTimer.Stop()
    Start-MinerTask $global:DefaultThreads
    if ((-not $global:IsPaused) -and (Test-WalletConfigured)) {
        $global:notifyIcon.Text = "$($global:ShortVersion)" + [Environment]::NewLine + "$($global:DefaultThreads) Threads | $(Get-Text 'TrayCalculating')"
    }
})
$startTimer.Start()

# 1a busca de cotacao escalonada 2s apos a interface ja estar livre na bandeja (e depois a cada 60s)
$btcTimer = New-Object System.Windows.Forms.Timer
$btcTimer.Interval = 2000
$btcTimer.Add_Tick({
    $btcTimer.Interval = 60000
    Update-BtcPrice
})
$btcTimer.Start()

# Checagem de atualizacao escalonada 6s apos abrir (e depois a cada 6 horas)
$updateCheckTimer = New-Object System.Windows.Forms.Timer
$updateCheckTimer.Interval = 6000
$updateCheckTimer.Add_Tick({ $updateCheckTimer.Interval = 21600000; Check-MinerUpdate })
$updateCheckTimer.Start()

# Checagem de ultimo bloco solo escalonada 12s apos abrir (e depois a cada 6 horas)
$soloBlockTimer = New-Object System.Windows.Forms.Timer
$soloBlockTimer.Interval = 12000
$soloBlockTimer.Add_Tick({ $soloBlockTimer.Interval = 21600000; Check-LastSoloBlock })
$soloBlockTimer.Start()

$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 300
$timer.Add_Tick({
    try {
        if ($global:IsPaused) {
            if (($null -ne $global:PauseResumeAt) -and ((Get-Date) -ge ($global:PauseResumeAt))) { Invoke-ResumeMining $true }
        } elseif (($global:PulseMode -ne "") -and ($null -ne $global:PulseNextSwitch) -and ((Get-Date) -ge ($global:PulseNextSwitch))) {
            if (($null -ne $global:CurrentProc) -and (-not $global:CurrentProc.HasExited)) {
                Suspend-MinerProcess
                $global:IsPaused = $true; $global:itemPause.Text = Get-Text "MenuResume"
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

        $line = ""; $added = $false
        while ($global:LogQueue.TryDequeue([ref]$line)) {
            $global:RecentLines.Enqueue($line)
            while ($global:RecentLines.Count -gt 15) { $global:RecentLines.Dequeue() | Out-Null }

            if ($line -match "Block\s+(\d{6,7})\b" -and ([int]$Matches[1] -gt $global:CurrentBlockHeight)) {
                $global:CurrentBlockHeight = [int]$Matches[1]; Save-MinerConfig
            }

            if ($line -match "TTF @\s*([\d.,]+\s*\S+/s):\s*Block\s*([^,]+),\s*Share\s*(.+?)\s*$") {
                $hr = $Matches[1]; $ttfBlock = $Matches[2].Trim(); $ttfShare = $Matches[3].Trim()
                if ((-not $global:IsPaused) -and (Test-WalletConfigured)) {
                    $pBadge = if ($global:PulseMode -ne "") { " ($($global:PulseMode))" } else { "" }
                    $global:notifyIcon.Text = "$($global:ShortVersion)$pBadge" + [Environment]::NewLine + "$($global:CurrentThreads) Threads | $hr"
                }
                if ((Get-Date) -ge $global:TtfLogAllowedAt) {
                    $dias = Convert-TtfToDays $ttfBlock
                    if ($null -ne $dias) {
                        $limiteDias = if ($null -ne $global:TtfThresholds[$global:CurrentThreads]) { $global:TtfThresholds[$global:CurrentThreads] } else { 365 }
                        if (($dias -lt $limiteDias) -and ($ttfBlock -ne $global:LastTtfLogged)) {
                            $global:LastTtfLogged = $ttfBlock
                            $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
                            "[$stamp] Threads: $($global:CurrentThreads) | Hashrate: $hr | TTF Bloco: $ttfBlock | TTF Share: $ttfShare | Linha: $line" | Out-File -FilePath $global:TtfLogFile -Append -Encoding utf8
                            try { Copy-Item -LiteralPath $global:TtfLogFile -Destination $global:BackupTtfLogFile -Force -ErrorAction SilentlyContinue } catch {}
                        }
                    }
                }
            }

            $global:logBox.SelectionStart = $global:logBox.TextLength; $global:logBox.SelectionLength = 0
            $global:logBox.SelectionColor = if ($line -match "(?i)accepted") { [System.Drawing.Color]::LimeGreen }
                elseif ($line -match "(?i)rejected")    { [System.Drawing.Color]::Red }
                elseif ($line -match "(?i)yay|B[1-9]")  { [System.Drawing.Color]::Gold }
                elseif ($line -match "\x5BSISTEMA\x5D") { [System.Drawing.Color]::Cyan }
                else                                    { [System.Drawing.Color]::DarkGray }
            $global:logBox.AppendText($line + [Environment]::NewLine)
            $added = $true
        }

        if ($global:logBox.TextLength -gt 300000) {
            $headerEnd = if ($global:logBox.Lines.Count -gt 5) { [Math]::Max(0, $global:logBox.GetFirstCharIndexFromLine(5)) } else { 0 }
            $global:logBox.ReadOnly = $false
            $global:logBox.Select($headerEnd, 100000); $global:logBox.SelectedText = ""
            $global:logBox.ReadOnly = $true; $global:logBox.SelectionStart = $global:logBox.TextLength
        }
        if (($added) -and ($global:Visible)) {
            $global:logBox.SelectionStart = $global:logBox.TextLength; $global:logBox.ScrollToCaret(); $global:logScrollBar.Invalidate()
        }

        if (($global:CurrentProc) -and ($global:CurrentProc.HasExited) -and (-not ($global:StopRequested)) -and (-not ($global:CrashNotified))) {
            $global:CrashNotified = $true; $code = $global:CurrentProc.ExitCode
            $global:LogQueue.Enqueue("[SISTEMA] ATENCAO: o miner encerrou sozinho (codigo $code). Reiniciando em 15s...")
            $global:notifyIcon.ShowBalloonTip(8000, "$($global:ShortVersion)", "O miner encerrou (codigo $code). Veja a janela/log para detalhes. Reiniciando em 15s.", [System.Windows.Forms.ToolTipIcon]::Warning)
            $global:RestartAt = (Get-Date).AddSeconds(15)
        }
        if (($global:RestartAt) -and ((Get-Date) -ge ($global:RestartAt))) {
            $global:RestartAt = $null; Start-MinerTask $global:CurrentThreads
        }
        if ($global:BlockFoundLine) {
            $bLine = $global:BlockFoundLine; $global:BlockFoundLine = $null; Invoke-BlockAlert $bLine
        }
    } catch {}
})
$timer.Start()

if (Test-WalletConfigured) {
    $global:notifyIcon.ShowBalloonTip(5000, "$($global:ShortVersion)", "$(Get-Text 'BalloonStart1') $($global:StartupDelaySeconds) $(Get-Text 'BalloonStart2')", [System.Windows.Forms.ToolTipIcon]::Info)
}

[System.Windows.Forms.Application]::Run()