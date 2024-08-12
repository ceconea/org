#!/bin/bash

# directorio principal
main_dir="/mnt/grial_6/home_rdiff_backup"

# lista de subdirectorios
users=("aguirre" "argota" "chomik"  "coene"  "contardi"  "dev"  "duarte"  "guerrieri"  "lobon"  "lucini"  "manuel"  "marturet"  "obregon"  "pulido"  "rodas"  "rosa"  "ruiz"  "vargas"  "wiedmann")

# recorrer cada subdirectorio y mostrar el último registro del archivo backup.log
for user in "${users[@]}"; do
    log_file="$main_dir/$user/rdiff-backup-data/backup.log"
    
    if [ -f "$log_file" ]; then
        echo "=== Último registro de $log_file ==="
        tac "$log_file" | awk '
            BEGIN { RS="--------------------------------------------------" }
            NR==2 { print "--------------[ Session statistics ]--------------" $0; exit }
        '
        echo "========================================================================"
    else
        echo "Archivo $log_file no encontrado"
    fi
done



# recorrer cada subdirectorio y muestra el último registro del archivo backup.log usando una expresion regular no funciona bien
# devería hacer yo la expresion para que funcione bien

# for user in "${users[@]}"; do
#     log_file="$main_dir/$user/rdiff-backup-data/backup.log"
    
#     if [ -f "$log_file" ]; then
#         echo "=== Último registro de $log_file ==="
#         tac "$log_file" | awk '/^[0-9]{4}-[0-9]{2}-[0-9]{2}/{print; exit}'
#         echo "===================================="
#     else
#         echo "Archivo $log_file no encontrado"
#     fi
# done
