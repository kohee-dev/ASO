#!/bin/bash
# 1. Definición de rutas
ORQUESTA="/srv/jidoor/opera/Il_barbiere_di_Siviglia/orquesta"
ARTISTAS="/srv/jidoor/opera/Il_barbiere_di_Siviglia/artistas"
# 2. Creación de las rutas
mkdir -p "$ORQUESTA"
mkdir -p "$ARTISTAS"
# 3. Bucle para procesar usuarios
for i in $(cat usuarios.csv)
do
# Extraemos nombre y grupo
        NOMBRE=$(echo $i | awk -F, '{print $1}')
        GRUPO=$(echo $i | awk -F, '{print $2}')
        echo "Procesando "$NOMBRE" del grupo  "$GRUPO"..."
# Aquí le decimos que vaya metiendo a cada uno en su sitio
        if [ "$GRUPO" = "artistas" ]; then
                CARPETA="$ARTISTAS"
        else
        CARPETA="$ORQUESTA"
        fi
        ARCHIVO="$CARPETA/$NOMBRE.txt"
        echo "$NOMBRE" > "$ARCHIVO"
# Asignamos permisos
        chown "$NOMBRE:$GRUPO" "$ARCHIVO"
        chmod 640 "$ARCHIVO"
done

echo "Creacion de partituras creadas correctamente"
# 4. Configuración de Permisos Especiales
# El Conductor debe poder leer y escribir en TODO
setfacl -R -m g:conductor:rwx "$ORQUESTA" "$ARTISTAS"
setfacl -R -m g:artistas:--- "$ORQUESTA"
setfacl -R -m g:cuerda:--- "$ARTISTAS"
setfacl -R -m g:viento_madera:--- "$ARTISTAS"
setfacl -R -m g:viento_metal:--- "$ARTISTAS"
setfacl -R -m g:percusion:--- "$ARTISTAS"
echo "Permisos asignados correctamente"