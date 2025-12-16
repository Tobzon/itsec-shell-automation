$LogFile = "process_check_2.log"

function Write-Log {
    param([string]$Message)
    $entry = "$(Get-Date) - $Message"
    $entry | Tee-Object -FilePath $LogFile -Append
}

function Check-Process {
   param([string]$Name)
   if (Get-Process -Name $Name -ErrorAction SilentlyContinue) {
        Write-Log "Processen '$Name' existerar."
   }
    else {
        Write-Log "Varning: Processen '$Name' existerar inte."
    }
}

function Run-Checks {
    param([string]$Path)
    if (-Not (Test-Path $Path)) {
        Write-Log "FEL: Filen '$Path' saknas"
        exit
    }
    
    foreach ($p in Get-Content $Path) {
       Check-Process -Name $p 
    }
    
}

Run-Checks "processlist.txt"
Write-Log "Kontroller klara."
