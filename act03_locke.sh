#!bin/bash
SCRIPT="./act02.sh"
# Filtramos el archivo /etc/passwd para obtener una lista de todos los usuarios reales del sistema (aquellos con un UID mayor o igual a 100 y que no sean el usuario "nobody").
USUARIO=$(awk -F: '$3 >= 100 && $1 != "nobody" {print}' /etc/passwd)
# Con este bucle recorremos la lista de usuarios obtenida
for usuario in $USUARIO; do
# Ejecuta mi script act02.sh con el parámetro probar para cada músico.
	bash "$SCRIPT" "$USUARIO" probar
	echo "Se ha ejecutado el parametro probar del el script act02.sh para $USUARIO"
done
# El script se detiene durante 15 minutos (900 segundos) antes de seguir, tal como pide el ejercicio
echo "Esperando 15 minutos para la siguiente acción"
sleep 900
# Ejecuta la acción de borrado total en el home de cada usuario para eliminar cualquier rastro del sabotaje de Locke .
for usuario in $USUARIO; do
	bash "$SCRIPT" "$USUARIO" limpiar
	echo "Se ha ejecutado el parametro limpiar del el script act02.sh para $USUARIO"
done

echo "Esperando 15 minutos para la siguiente acción"
sleep 900
# Finalmente, vuelve a crear todas las carpetas (Acto_I, Acto_II, etc.) y las partituras para que la función pueda continuar .
for usuario in $USUARIO; do
	bash "$SCRIPT" "$USUARIO" restablecer
	echo "Se ha ejecutado el parametro restablecer del el script act02.sh para $USUARIO"
done

echo "Se ha restaurado los actos de todos los usuarios"
