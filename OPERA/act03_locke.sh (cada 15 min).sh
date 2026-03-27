#!/bin/bash

for u in Oboe Clarinete Flauta Guitarra Corno Cello Contrabajo Sistro Timbal Conductor; do
    /opt/jidoor/act02.sh $u Limpiar
    /opt/jidoor/act02.sh $u Restablecer
done
logger "Se restauró la ópera"