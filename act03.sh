#!/bin/bash
# Comprobación de existencia de Locke; si no existe, se crea
if ! id Locke &>/dev/null; then
    useradd -s /bin/bash locke
    echo "Usuario Locke creado"
else
    echo "El usuario Locke ya existe"
fi

# Solicitamos al usuario qué acto desea sabotear
read -p "Seleccione que acto desea borrar (all, --01, --02, --03, --04): " respuesta

# Lógica de eliminación basada en la respuesta
if [ "$respuesta" = "--01" ]; then
    rm -rf /home/Locke/Acto_I
    echo "El acto I ha sido eliminado"
elif [ "$respuesta" = "--02" ]; then
    rm -rf /home/Locke/Acto_II
    echo "El acto II ha sido eliminado"
elif [ "$respuesta" = "--03" ]; then
    rm -rf /home/Locke/Acto_III
    echo "El acto III ha sido eliminado"
elif [ "$respuesta" = "--04" ]; then
    rm -rf /home/Locke/Acto_IV
    echo "El acto IV ha sido eliminado"
elif [ "$respuesta" = "--all" ]; then
    # Eliminación de todos los actos de Locke
    rm -rf /home/Locke/Acto_I
    rm -rf /home/Locke/Acto_II
    rm -rf /home/Locke/Acto_III
    rm -rf /home/Locke/Acto_IV
    echo "Todos los actos han sido eliminados"
else
    # Mensaje de error si el argumento no es válido
    echo "Error en la eliminación del acto"
fi
# Bucle infinito para sabotaje continuo cada 10 minutos
while true: do
# Genera un número aleatorio entre 1 y 4 para decidir el acto
	n=$((RANDOM % 4 + 1))
	# Ejecuta el borrado del acto correspondiente en el home de Locke
	rm -rf "/$HOME/Locke/Acto_$n"
	if [[ $n -eq 5 ]]; then
		rm -rf "/$HOME/Locke/Acto_"*
		echo "Se han eliminaron todos los actos"
	else
		rm -rf "$HOME/Locke/Acto_0$n"
		echo "Se elimino el Acto_0$n"
	fi
	# Pausa de 10 minutos
	sleep 600
done

