#!/bin/bash


ARG=$1

# Crear usuario Locke si no existe
if ! id Locke >/dev/null; then
    useradd -m -s /bin/bash Locke
fi

# Borrado según el argumento
if [ "$ARG" = "--all" ]; then
    rm -rf /home/*/Acto_*

elif [ "$ARG" = "--01" ]; then
    rm -rf /home/*/Acto_01

elif [ "$ARG" = "--02" ]; then
    rm -rf /home/*/Acto_02

elif [ "$ARG" = "--03" ]; then
    rm -rf /home/*/Acto_03

elif [ "$ARG" = "--04" ]; then
    rm -rf /home/*/Acto_04

else
    echo "Parámetro invalido. Uso: --all --01 --02 --03 --04"
fi

