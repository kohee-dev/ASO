#!/bin/bash
#Borrams y añadimos los usuarios
sudo userdel -r maria
useradd -s /bin/bash -m -g artistas celes
useradd -s /bin/bash -m -g artistas locke
# Realizamos el read para la pregunta
read -p "¿Quieres leer el guion? (si/no): " respuesta
# Hacemos el condicional debido a que en función de la respuesta saldrá o bien el guión o bienm diciendo que no se leera
if [ "$respuesta" = "si" ]; then
    echo "Leyendo el guion..."
    while read -r linea; do
        echo "$linea"
        sleep 2
    done < script.txt
else
    echo "No se leera el guion"
fi



