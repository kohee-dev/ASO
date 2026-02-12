---
autor: Alejandro Bartolomé
asignatura: [ASO,ASIR]
tema: Samba
Titulo: Permisos con Samba
---
# Recursos compartidos con Samba

En esta práctica vamos a gestionar permisos de usuarios usando Samba.

## Requisitos

Para la realización de la actividad se necesitan los siguientes requisitos previos.

- Un sistema Linux y un sistema Windows que actuen como cliente.
- Un servidor Linux con 2 usuarios: Picard y Kirk
- Paciencia.

## Configuración inicial

Crea un directorio en `/srv/enterprise` y modifica el directorio para que Kirk sea propietario.

Ahora modifica los permisos para que unicamente el usuario y grupo propietarios puedan leer, escribir y ejecutar.

Modifica el fichero `/etc/samba/samba.conf` para que ambos usuarios tengan acceso

## Usuarios

Añade ambos usuarios creados previamente a Samba.

## Actividades

En el servidor:

+ Crea un fichero llamado `/srv/enterprise/USSEnterprise.txt` con Kirk que contenga `James T. Kirk`
+ Modifica el fichero `/srv/enterprise/USSEnterprise.txt` con Picard para que al final del fichero ponga `Jean-Luc Picard`

## Preguntas

1. ¿Puede Picard modificar los ficheros de Kirk?
2. ¿Que ocurre cuando cambio los permisos a 740?
3. ¿Que permisos tienen prioridad, los de Linux o los de Samba?
4. ¿Que cambios puedes hacer para que varios usuarios de distintos sistemas puedan acceder y modificar los ficheros creados en Samba?

## Tarea final

Define unas máscaras de creación y modifica los permisos necesarios para que los usuarios desde las maquinas cliente y desde el servidor puedan leer y escribir en ficheros ajenos.




