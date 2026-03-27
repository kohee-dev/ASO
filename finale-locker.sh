#!/bin/bash

# Leemos el archivo de usuarios línea a línea
for i in $(cat usuarios.csv)
do
    # Sacamos nombre y grupo (separados por coma)
    NOMBRE=$(echo $i | cut -d',' -f1)
    GRUPO=$(echo $i | cut -d',' -f2)

    # Si el usuario no existe, lo creamos rápido
    if ! id "$NOMBRE" &>/dev/null; then
        echo "Recreando al usuario: $NOMBRE"
        
        # Si el grupo no existe, lo crea; si existe, no hace nada
        groupadd -f "$GRUPO"
        
        # Crea al usuario con su carpeta y contraseña
        useradd -m -g "$GRUPO" "$NOMBRE"
        echo "$NOMBRE:$NOMBRE" | chpasswd
    fi
done

echo "Sistema listo. Lanzando restauracion..."

# Ejecuta el script que ya tenías hecho
bash ./act03-locke.sh