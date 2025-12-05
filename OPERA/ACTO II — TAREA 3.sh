#!/bin/bash

USUARIO=$1
ACCION=$2



if [ "$ACCION" = "Restablecer" ]; then
    mkdir -p /home/$USUARIO/Acto_{1,2,3,4}
    echo "$USUARIO" > /home/$USUARIO/$USUARIO.txt #//root/
    for i in 1 2 3 4; do
        echo "$USUARIO" > /home/$USUARIO/Acto_${i}/"${USUARIO}_${i}.txt"
    done
    echo " Restablecido."
fi

if [ "$ACCION" = "Probar" ]; then
    echo "--- Probando estructura de $USUARIO ---"
    if [-r "/home/$USUARIO/$USUARIO.txt"]; then
        echo "OK Partitura principal"
    else
        echo "No existe O no tiene lectura"
    fi
fi

if [ "$ACCION" = "Limpiar" ]; then
    rm -rf /home/$USUARIO/*
    echo "Directorio de $USUARIO limpio."
fi
