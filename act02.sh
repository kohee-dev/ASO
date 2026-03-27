#!bin/bash
# Parámetros: usuario y acción (restablecer, probar, limpiar)
USUARIO=$1
ACCION=$2
# Comprobamos la existencia del usuario
if ! id $USUARIO >/dev/null 2>&1; then
	echo "El usuario '$1' no existe"
	exit 1
fi
# En función de la existencia del usuario, tenemos 3 opciones.
# Las cuales, las creamos con los ifs
if [ "ACCION" = "restablecer" ]; then
	mkdir -p /$HOME/$USUARIO/Acto_{I,II,III,IV}
	echo "$USUARIO" > /$HOME/$USUARIO/$USUARIO.txt
	for i in 1 2 3 4; do
		echo "$USUARIO" > /$HOME/$USUARIO/Acto_${i}/"${USUARIO}_${i}.txt"
	done
	echo "Usuario restablecido"
fi

if [ "$ACCION" = "probar" ]; then
	if [ -r /$HOME/$USUARIO/$USUARIO.txt ]; then
		echo "Carpeta correcta y permisos correctos"
	else
		echo "Algo no funciona bien...."
	fi
fi

if [ "$ACCION" = "limpiar" ]; then
	rm -rf /$HOME/$USUARIO/*
	echo "Limpieza del directorio realizada"
fi
