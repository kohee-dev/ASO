#!/bin/bash


BASE="/srv/jidoor/opera/Il_barbiere_di_Siviglia"
mkdir -p $BASE/orquesta
mkdir -p $BASE/artistas

INSTR="Oboe Clarinete Flauta Guitarra Corno Cello Contrabajo Sistro Timbal Conductor"
ART="Maria Draco Ralse Narrador"

# ORQUESTA
for u in $INSTR; do
    mkdir -p $BASE/orquesta/$u
    echo "$u" > $BASE/orquesta/$u/$u.txt
    chown $u:Orquesta $BASE/orquesta/$u/$u.txt
    chmod 600 $BASE/orquesta/$u/$u.txt
done

# ARTISTAS
for a in $ART; do
    mkdir -p $BASE/artistas/$a
    echo "$a" > $BASE/artistas/$a/$a.txt
    chown $a:Artistas $BASE/artistas/$a/$a.txt
    chmod 600 $BASE/artistas/$a/$a.txt
done

chmod -R 750 $BASE

echo " Acto I completado"
