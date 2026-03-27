#!/bin/bash

OPCION=$1
OBJETO=$2

if ! id Ultros >/dev/null; then
    useradd -m Ultros
fi

if [ "$OPCION" = "--instruments" ]; then
    if id $OBJETO >/dev/null; then
        userdel -r $OBJETO
        echo "$OBJETO eliminado."
    fi
fi

if [ "$OPCION" = "--groups" ]; then
    if getent group $OBJETO >/dev/null; then
        delgroup $OBJETO
        echo "Grupo $OBJETO eliminado."
    fi
fi

if [ "$OPCION" = "--partitures" ]; then
    rm -rf /home/*/Acto_$OBJETO
    echo "Acto $OBJETO eliminado."
fi
