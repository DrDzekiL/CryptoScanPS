function Get-DemoTicker {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Symbol,
        [Parameter(Mandatory = $true)]
        [string]$Interval
    )

    # DEMO: вместо реального HTTP-запроса возвращаем псевдо-данные
    # В реальной версии здесь будет Invoke-RestMethod с API биржи.

    $rnd = New-Object System.Random
    $price = [math]::Round(1000 + $rnd.NextDouble() * 50000, 2)
    $volume = [math]::Round(1000000 + $rnd.NextDouble() * 10000000, 0)

    return @{
        symbol = $Symbol
        interval = $Interval
        price = $price
        volume = $volume
        ts = (Get-Date).ToUniversalTime().ToString("o")
    }
}

Export-ModuleMember -Function Get-DemoTicker
