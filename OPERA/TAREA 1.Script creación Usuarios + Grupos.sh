#!/bin/bash

USUARIOS="Oboe Clarinete Flauta Guitarra Corno Cello Contrabajo Sistro Timbal Conductor"
GRUPOS="Cuerda Viento_madera Viento_metal Percusion Conductor Orquesta Artistas"

# Crear grupos
for g in $GRUPOS; do
    if getent group $g >/dev/null; then --
        echo "Grupo $g ya existe."
    else
        groupadd $g
        echo "Grupo $g creado."
    fi
done

# Crear usuarios
for u in $USUARIOS; do
    if id "$u">/dev/null; then
        echo "Usuario $u ya existe."
    else
        useradd -m -s /bin/bash $u
        echo "$u:1234" | chpasswd
        echo "Usuario $u creado."
    fi
done

# Grupo Orquesta
for u in $USUARIOS; do
    usermod -a -G Orquesta $u
done

# Reparto de grupos
usermod -a -G Cuerda Cello
usermod -a -G Cuerda Contrabajo
usermod -a -G Cuerda Guitarra

usermod -a -G Viento_madera Oboe
usermod -a -G Viento_madera Clarinete
usermod -a -G Viento_metal Flauta
usermod -a -G Viento_metal Corno

usermod -a -G Percusion Sistro
usermod -a -G Percusion Timbal

usermod -a -G Conductor Conductor

# Artistas
for a in Maria Draco Ralse Narrador; do
    if ! id $a >/dev/null; then
        useradd -m -s /bin/bash $a
        echo "$a:1234" | chpasswd
    fi
    usermod -a -G Artistas $a
done

echo " Tarea 1 completada."

