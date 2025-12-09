function Parse-DemoTicker {
    param(
        [Parameter(Mandatory = $true)]
        [hashtable]$Raw,
        [Parameter(Mandatory = $true)]
        [string]$Symbol
    )

    return [PSCustomObject]@{
        symbol = $Symbol
        price  = [double]$Raw.price
        volume = [double]$Raw.volume
        interval = $Raw.interval
        timestampUtc = $Raw.ts
    }
}

Export-ModuleMember -Function Parse-DemoTicker
