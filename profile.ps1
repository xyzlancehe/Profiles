#region conda tools
Set-Alias -Name activate -Value Enter-CondaEnvironment
Set-Alias -Name act -Value Enter-CondaEnvironment
Set-Alias -Name deactivate -Value Exit-CondaEnvironment
Set-Alias -Name deact -Value Exit-CondaEnvironment
#endregion

#region symlink function
function New-Link { 
    <#
    .SYNOPSIS
        Creates a new hard or symbolic link.
        Needs to be run as administrator.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$target,
        [Parameter(Mandatory = $true)]
        [string]$link,
        [Parameter(Mandatory = $false)]
        [Switch]$symbolic
    )

    if ($symbolic) {
        New-Item -ItemType SymbolicLink -Path $link -Target $target
    }
    else {
        New-Item -ItemType HardLink -Path $link -Target $target
    }
}

Set-Alias -Name ln -Value New-Link
Set-Alias -Name mklink -Value New-Link
#endregion

#region quick source profile
function Invoke-CurrentUserProfile {
    if (Test-Path $Profile.CurrentUserAllHosts) {
        . $Profile.CurrentUserAllHosts
    }
    if (Test-Path $Profile.CurrentUserCurrentHost) {
        . $Profile.CurrentUserCurrentHost
    }
}

Set-Alias -Name '...' -Value Invoke-CurrentUserProfile
#endregion

#region custom prompt
function Set-TerminalTitle {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Title
    )
    $host.ui.RawUI.WindowTitle = $Title
}

function Get-RainbowText {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Text
    )

    $rainbowColors = @(
        [PSCustomObject]@{ R = 255; G = 0;   B = 0   },  # Red
        [PSCustomObject]@{ R = 255; G = 127; B = 0   },  # Orange
        [PSCustomObject]@{ R = 255; G = 255; B = 0   },  # Yellow
        [PSCustomObject]@{ R = 0;   G = 255; B = 0   },  # Green
        [PSCustomObject]@{ R = 0;   G = 0;   B = 255 },  # Blue
        [PSCustomObject]@{ R = 75;  G = 0;   B = 130 },  # Indigo
        [PSCustomObject]@{ R = 148; G = 0;   B = 211 }   # Violet
    )

    $totalSteps = [Math]::Max(2, $Text.Length)
    $result = ""

    for ($i = 0; $i -lt $Text.Length; $i++) {
        $t = $i / ($Text.Length - 1)
        $segment = [Math]::Floor($t * 6)
        $localT = ($t * 6) - $segment

        if ($segment -ge 6) {
            $segment = 5
            $localT = 1
        }

        $c1 = $rainbowColors[$segment]
        $c2 = $rainbowColors[$segment + 1]

        $r = [Math]::Round((1 - $localT) * $c1.R + $localT * $c2.R)
        $g = [Math]::Round((1 - $localT) * $c1.G + $localT * $c2.G)
        $b = [Math]::Round((1 - $localT) * $c1.B + $localT * $c2.B)

        $ansiColor = "`e[38;2;${r};${g};${b}m"
        $result += "${ansiColor}$($Text[$i])"
    }

    $result += "`e[0m"  # Reset color
    return $result
}
function Prompt {
    if ($env:CONDA_PROMPT_MODIFIER) {
        Write-Host ($env:CONDA_PROMPT_MODIFIER) -NoNewline
    }

    $WorkingDirectory = Get-Location
    Set-TerminalTitle "PowerShell: $WorkingDirectory"
    Write-Host ("PowerShell ") -NoNewline -ForegroundColor Yellow

    $UserName = $env:UserName
    $HostName = $env:HostName # self-defined
    if (-not $HostName) {
        $HostName = $env:ComputerName 
    }

    $PromptIdentity = Get-RainbowText "$UserName@$HostName"

    # Write-Host "$UserName@$HostName " -ForegroundColor Green
    Write-Host "$PromptIdentity " -NoNewline
    Write-Host $WorkingDirectory -NoNewline -ForegroundColor Cyan
    Write-Host ">" -NoNewline -ForegroundColor White
    return " "
}
#endregion

#region PSReadLine
$commandHistoryFilter = {
    param(
        [string]$line
    )
    if ($line -match "^something_to_exclude") {
        return $false;
    }
    return $true;
}

Set-PSReadLineOption -AddToHistoryHandler $commandHistoryFilter
Set-PSReadLineKeyHandler -Key Tab -Function Complete # Tab completion
#endregion

function git_proxy_on {
    param (
        [int]$port=7890
    )
    git config --global http.proxy "http://localhost:$port"
    git config --global https.proxy "http://localhost:$port"
    
}

function git_proxy_off {
    git config --global --unset http.proxy
    git config --global --unset https.proxy
}

