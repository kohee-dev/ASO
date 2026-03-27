#!/bin/bash

# Guardamos los argumentos en variables fáciles de leer
OPCION=$1
NOMBRE=$2

# Si no se pasan 2 argumentos, mostramos cómo se usa
if [ $# -ne 2 ]; then
    echo "Uso: $0 <opcion> <nombre>"
    echo "Opciones: -i (usuario), -g (grupo), -p (acto)"
    exit 1
fi

# Lógica del borrado
if [ "$OPCION" = "-i" ]; then
    # Borrar un usuario y su carpeta de un tirón
    echo "Borrando al músico $NOMBRE..."
    userdel -r "$NOMBRE"

elif [ "$OPCION" = "-g" ]; then
    # Borrar un grupo entero
    echo "Borrando el grupo $NOMBRE..."
    groupdel "$NOMBRE"

elif [ "$OPCION" = "-p" ]; then
    # Borrar archivos que terminen en el número de acto (ej: _1.txt)
    echo "Borrando partituras del Acto $NOMBRE..."
    rm -rf /home/*/*_"$NOMBRE".txt
    rm -rf /srv/jidoor/opera/*/*_"$NOMBRE".txt
else
    echo "Esa opción no existe."
fi

# El mensaje final de Ultros que pide el ejercicio
echo "¡María ha sido secuestrada!"
logger "¡María ha sido secuestrada!"