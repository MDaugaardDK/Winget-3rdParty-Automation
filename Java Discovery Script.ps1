$AppName = "Java*"
$CurrentVersion = "8.0.3210.7"
$FindApp = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall -Recurse -ErrorAction SilentlyContinue | Foreach {Get-ItemProperty $_.pspath} -ErrorAction SilentlyContinue | Where-Object {$_.DisplayName -like $AppName} -ErrorAction SilentlyContinue

If ($FindApp.DisplayName -eq $null){
Write-Output $false
}
else{
	If ($FindApp.DisplayVersion -le $CurrentVersion)
        {

		    If ($FindApp.DisplayName -like $AppName -and $FindApp.DisplayVersion -lt $CurrentVersion)
                {
Write-Host "Old version of Java 8 Update were detected"
			        Write-Output $false
		        }
		    Else
                {
			        Write-Host "Current version of Java 8 Update were detected, but older versions were not found. Do nothing."
			        Write-Output $true
		        }
	    }
	Else
        {
		    Write-Host "Current version of Java 8 Update were not detected. Do nothing."
		    Write-Output $true
	    }
}