#!/bin/bash  - så vi vet vilken interpter att köra

# sätter filen som en variabel
logfile="security_log.txt"


# skapar funktionen "log"
log() { 
        #skriver ut datum o tar in ett värde som skickas med och sen lägger till det i "logfile"
       echo "$(date) - $1" | tee -a $logfile
}

# skapar funktionen "check_file"
check_file() {
    #skapar en lokal variabel som tar emot ett värde
    local file=$1

    if [ -f "$file" ]; then
        log "Filen '$file' finns." 
        ls -l "$file" | tee -a $logfile
    else        
        log "VARNING: Filen '$file' saknas."
    fi
}
check_user() {
    local user=$1    
    if id  "$user" &>/dev/null; then 
        log "Användaren '$user' finns."
    else        
        log "VARNING: Användaren '$user' saknas."
    fi
}

 read -p "Ange fil att kontrollera: " file_input
 check_file "$file_input"
 
 read -p "Ange användarnamn att kontrollera: " user_input
 check_user "$user_input"

 log "Kontroller slutförda."