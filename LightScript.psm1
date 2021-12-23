foreach ($file in Get-ChildItem $psScriptRoot -Filter *-*.ps1) {
    . $file.Fullname
}


<#

#region Core Bridge Commands
. $PSScriptRoot\Join-HueBridge.ps1
. $PSScriptRoot\Find-HueBridge.ps1
. $PSScriptRoot\Send-HueBridge.ps1
. $PSScriptroot\Get-HueBridge.ps1
#endregion Core Bridge Commands

#region -Light Commands
. $PSScriptRoot\Copy-Light.ps1
. $PSScriptRoot\Get-Light.ps1
. $PSScriptRoot\Set-Light.ps1
. $PSScriptRoot\Save-Light.ps1
. $PSScriptRoot\Rename-Light.ps1
#endregion -Light Commands

#region -HueRoom Commands
. $PSScriptRoot\Get-HueRoom.ps1
. $PSScriptRoot\Remove-HueRoom.ps1
#endregion -HueRoom Commands

#region -HueResource Commands
. $PSScriptRoot\Get-HueResource.ps1
. $PSScriptRoot\Remove-HueResource.ps1
#region -HueResource Commands

#region -HueRule Commands
. $PSScriptRoot\Get-HueRule.ps1
. $psScriptRoot\Set-HueRule.ps1
. $PSScriptRoot\Remove-HueRule.ps1
#endregion -HueRule Commands

#region -HueSchedule Commands
. $PSScriptRoot\Add-HueSchedule.ps1
. $PSScriptRoot\Get-HueSchedule.ps1
. $PSScriptRoot\Remove-HueSchedule.ps1
#endregion -HueSchedule Commands

#region -HueSensor Commands
. $PSScriptRoot\Add-HueSensor.ps1
. $PSScriptRoot\Get-HueSensor.ps1
. $PSScriptRoot\Read-HueSensor.ps1
. $PSScriptRoot\Remove-HueSensor.ps1
. $PSScriptRoot\Write-HueSensor.ps1
#endregion -HueSensor Commands

#region -HueScene Commands
. $PSScriptRoot\Get-HueScene.ps1
. $PSScriptRoot\Restore-HueScene.ps1
. $PSScriptRoot\Remove-HueScene.ps1
. $PSScriptRoot\Save-HueScene.ps1
#endregion -HueScene Commands


. $psScriptRoot\Start-LightChase.ps1

#>

if ($home) {
    $Script:KnownResources =
        @(
            Get-HueLight
            Get-HueRoom
            Get-NanoLeaf
        )

    foreach ($resource in $Script:KnownResources) {
        if ($resource.pstypenames -contains 'Hue.Light') {
            Set-Alias -Name ($resource.Name -replace '\s') -Value Set-HueLight
        }
        if ($resource.pstypenames -contains 'Hue.Group' -or
            $resource.pstypenames -contains 'Hue.LightGroup') {
            Set-Alias -Name ($resource.Name -replace '\s') -Value Set-HueLight
        }
    }

    <#
    $gotLightsAndInfo = Get-ChildItem -Filter LightScript -Directory -Path $home |
        Get-ChildItem -Filter *.clixml |
        Group-Object { @($_.Name -split '\.')[-2] } -NoElement |
        Sort-Object Name |
        ForEach-Object {
            $getCmd = $ExecutionContext.SessionState.InvokeCommand.GetCommand("Get-$($_.Name)", 'All')
            if ($getCmd) {
                & $getCmd
            }
        }
    #>

}