#!/bin/bash

"""
  Script de verificacion del estado de los backup
"""
# Directorio base, estan todos directorios a verificar
BASE_DIR="/mnt/grial_6/home_rdiff_backup"

# Lista de directorios a verificar
DIRECTORIES=(
  "aguirre" "argota" "chomik" "coene" "contardi" "dev" "duarte"
  "guerrieri" "lobon" "lucini" "manuel" "marturet" "obregon"
  "pulido" "rodas" "rosa" "ruiz" "vargas" "wiedmann"
)

# Archivo log para registrar los resultados
LOG_FILE="/var/log/rdiff-backup-verify.log"

# Fecha y hora actuales
CURRENT_DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Función para verificar un directorio
verificar_directorio() {
  local dir=$1
  echo "Verificando $dir ..."
  rdiff-backup --verify "$BASE_DIR/$dir" >> "$LOG_FILE" 2>&1
  if [ $? -eq 0 ]; then
    echo "[$CURRENT_DATE] Verificación exitosa para $dir" >> "$LOG_FILE"
  else
    echo "[$CURRENT_DATE] ===== Error en la verificación para ===== $dir" >> "$LOG_FILE"
  fi
}

# Verificar cada directorio en la lista
for dir in "${DIRECTORIES[@]}"; do
  verificar_directorio "$dir"
done

echo "Verificación finalizada. Revisar el log en $LOG_FILE para más detalles."

