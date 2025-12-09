function Ensure-ParentDirectory {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )
    $dir = Split-Path -Parent $Path
    if (-not [string]::IsNullOrWhiteSpace($dir) -and -not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
    }
}

function Write-Log {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        [string]$Message
    )
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    $line = "[{0}] {1}" -f $timestamp, $Message
    Add-Content -Path $Path -Value $line
}

function Resolve-PathSafe {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )
    if (Test-Path $Path) {
        return (Resolve-Path $Path).Path
    }
    else {
        # if path is relative, resolve against current directory
        $full = [System.IO.Path]::GetFullPath($Path)
        return $full
    }
}

Export-ModuleMember -Function Ensure-ParentDirectory, Write-Log, Resolve-PathSafe
