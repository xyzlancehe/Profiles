#region conda tools
function Enter-CondaEnvironmentWithNameRemap {
    param (
        [Parameter(Mandatory)]
        [string]$envName
    )
    $remappedEnvName = &"python.exe" "${home}\bin\CondaNameMap\GetCondaEnvName.py" $envName
    if ($remappedEnvName -ne "") {
        Write-Host ("Remap environment to: " + $remappedEnvName)
        $envName = $remappedEnvName
    }
    Enter-CondaEnvironment -Name $envName 
}

Set-Alias -Name activate -Value Enter-CondaEnvironmentWithNameRemap 
Set-Alias -Name act -Value Enter-CondaEnvironmentWithNameRemap
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
        $HostName = $env:ComputerName # default by windows, all upper case, not good
    }

    Write-Host ($UserName + "@" + $HostName + " ") -NoNewline -ForegroundColor Green
    Write-Host ($WorkingDirectory) -NoNewline -ForegroundColor Cyan
    Write-Host (">") -NoNewline -ForegroundColor White
    return " "
}
#endregion