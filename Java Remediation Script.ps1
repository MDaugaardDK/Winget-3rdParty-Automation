$AppName = "Java*"
$CurrentVersion = "8.0.3210.7"
$PreviousVersion = "8.0.3010.9"
$InstallString = "\\ConfigurationManager$\SoftwareContent\AppInstalllation"
$FindApp = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall -Recurse -ErrorAction SilentlyContinue | Foreach {Get-ItemProperty $_.pspath} -ErrorAction SilentlyContinue | Where-Object {$_.DisplayName -like $AppName} -ErrorAction SilentlyContinue
Add-AppxPackage “$InstallString\WinGet.appxbundle”

If ($FindApp.DisplayName -eq $null)
    {
    winget install -e --id Oracle.JavaRuntimeEnvironment --silent --accept-source-agreements
    }
else
    {
	If ($FindApp.DisplayVersion -le $CurrentVersion){

		If ($FindApp.DisplayName -like $AppName -and $FindApp.DisplayVersion -lt $CurrentVersion){
			Write-Host "Older versions of Java 8 Update were detected. Trying to Update."

				Try{
					Get-Package -Name $AppName -MaximumVersion $PreviousVersion -ProviderName "msi" | Uninstall-Package -Force
                    winget install -e --id Oracle.JavaRuntimeEnvironment --silent --accept-source-agreements
				}
				Catch{
					Write-Host "Failed to uninstall older versions of Java 8 Update"
					Write-Host "$_.Exception.Message"
				}
		}
		Else{
			Write-Host "Current version of Java 8 Update were detected, but older versions were not found. Do nothing."
		}
	}
	Else{
		Write-Host "Older version of Java 8 Update were not detected. Do nothing."
	}
}
