#!/bin/bash

# Comprobar si es root
if [ $(id -u) -ne 0 ]; then
    echo "Necesitas ser administrador para ejecutar este script"
    exit 1
fi

# Procesar el archivo de usuarios
while IFS=',' read -r NOMBRE GRUPO; do

    # Comprobar si el usuario ya existe
    if id "$NOMBRE" &>/dev/null; then
        echo "El usuario $NOMBRE ya esta creado"
    else
        echo "El usuario $NOMBRE va a ser creado"

        # Crear el grupo si no existe
        if ! getent group "$GRUPO" &>/dev/null; then
            groupadd "$GRUPO"
            echo "El grupo $GRUPO ha sido creado"
        fi

        # Crear usuario con home y shell bash
        useradd -s /bin/bash -m -g "$GRUPO" "$NOMBRE"

        # Establecer contraseña desatendida (mismo nombre que el usuario)
        echo "$NOMBRE:$NOMBRE" | chpasswd
    fi
done < usuarios.csv