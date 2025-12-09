param(
    [string]$Config = ".\src\config.json"
)

# Add modules
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$modulesPath = Join-Path $scriptDir "modules"

Import-Module (Join-Path $modulesPath "utils.psm1") -Force
Import-Module (Join-Path $modulesPath "http.psm1") -Force
Import-Module (Join-Path $modulesPath "parser.psm1") -Force

if (-not (Test-Path $Config)) {
    Write-Error "Config file not found: $Config"
    exit 1
}

$configJson = Get-Content $Config -Raw | ConvertFrom-Json

$logPath = Resolve-PathSafe $configJson.logPath
Ensure-ParentDirectory $logPath
Write-Log -Path $logPath -Message "=== CryptoScanPS run started ==="

try {
    $symbols = $configJson.symbols
    $exchange = $configJson.exchange
    $minVolume = [double]$configJson.minVolume
    $interval = $configJson.interval

    Write-Log -Path $logPath -Message "Exchange: $exchange; Symbols: $($symbols -join ', '); MinVolume: $minVolume; Interval: $interval"

    $results = @()

    foreach ($symbol in $symbols) {
        $raw = Get-DemoTicker -Symbol $symbol -Interval $interval
        $parsed = Parse-DemoTicker -Raw $raw -Symbol $symbol

        if ($parsed.volume -ge $minVolume) {
            $results += $parsed
            Write-Log -Path $logPath -Message "PASS $symbol volume=$($parsed.volume)"
        }
        else {
            Write-Log -Path $logPath -Message "SKIP $symbol volume=$($parsed.volume)"
        }
    }

    $results | ConvertTo-Json -Depth 5
}
catch {
    Write-Log -Path $logPath -Message "ERROR: $($_.Exception.Message)"
    throw
}
finally {
    Write-Log -Path $logPath -Message "=== CryptoScanPS run finished ==="
}
