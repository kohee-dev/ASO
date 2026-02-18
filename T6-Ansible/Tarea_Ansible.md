---
origen: https://asir.sudo.es/asi/ansible_p01_v03.html
asignatura: [ASO,ASIR]
tema: Ansible
Titulo: Crear una infraestructura de sistemas orquestada con Ansible
---

# Crear una infraestructura de sistemas orquestada con Ansible

## Preparación

Vamos a necesitar 3 maquinas virtuales.

- Primero verificad la integridad de los recursos proporcionados por el [sitio](https://www.linuxvmimages.com/) usando md5sum.
- Decomprimid los ficheros.

Crear una red NAT con las siguientes especificaciones:

+ Nombre: NAT-Ansible
+ CIDR: 10.0.2.0/24
+ DHCP: Activado
+ Reenvío de puertos:
    + IP-anfitrión:2260 -> 10.0.2.60:22
    + IP-anfitrión::2270 -> 10.0.2.70:22
    + IP-anfitrión::2280 -> 10.0.2.80:22

### Equipo 1


+ Nombre de la máquina virtual: ansible-deb1
+ Tipo: Linux
+ Versión: Debian (64-bit)
+ Tamaño de la memoria RAM: 1024 Mb. (2048 si el anfitrión aguanta 3 VM,s simultáneamente con este tamaño)
+ Núcleos de CPU: 1
+ Red:
    + Adaptador NIC1
    + Conectado a la red NAT NAT-Ansible
+ Almacenamiento:
    + Controlador SATA:
        + Asignar al puerto 0 al disco virtual ansible-deb1-disco.vdi
+ Audio: Deshabilitar
+ Puertos serie: Deshabilitar todos


### Equipo 2

+ Nombre de la máquina virtual: ansible-deb1
+ Tipo: Linux
+ Versión: Debian (64-bit)
+ Tamaño de la memoria RAM: 1024 Mb. (2048 si el anfitrión aguanta 3 VM,s simultáneamente con este tamaño)
+ Núcleos de CPU: 1
+ Red:
    + Adaptador NIC1
    + Conectado a la red NAT NAT-Ansible
+ Almacenamiento:
    + Controlador SATA:
        + Asignar al puerto 0 al disco virtual ansible-deb1-disco.vdi
+ Audio: Deshabilitar
+ Puertos serie: Deshabilitar todos


### Equipo 3

+ Nombre de la máquina virtual: ansible-userv
+ Tipo: Linux
+ Versión: Ubuntu (64-bit)
+ Tamaño de la memoria RAM: 1024 Mb. (2048 si el anfitrión aguanta 3 VM,s simultáneamente con este tamaño)
+ Núcleos de CPU: 1
+ Red:
    + Adaptador NIC1
    + Conectado a la red NAT NAT-Ansible
+ Almacenamiento:
    + Controlador SATA:
        + Asignar al puerto 0 al disco virtual ansible-userv-disco.vdi
+ Audio: Deshabilitar
+ Puertos serie: Deshabilitar todos

## Puesta a punto de los sistemas operativos


Los sistemas instalados en los discos cuentan con un usuario root y un usuario ordinario, este último de nombre igual a la distro (debian/ubuntu) y con password idéntica al nombre, ambos usuarios ordinarios están registrados en el subsistema sudoers con privilegios de root.

* Configuración de teclado, lenguaje, codificación de caracteres y zona horaria.

    * Para configurar estos cuatro aspectos de los sistemas el alumno se remitirá al tema que los trata estos conceptos correspondiente al primer trimestre. En cualquier caso téngase en cuenta la presencia del paquete console-data y el comando loadkeys

*  Montamos una puerta:

    * En todos los sistemas se necesita cliente y servidor openssh. Hacer lo necesario para proveerlo en caso de no existir.
    * Modificar /etc/ssh/sshd_config en los sistemas debian (sólo debian!!) para permitir la entrada de root vía ssh.

* Asignar IP fijas a los tres sistemas en la RedNat 10.0.2.0/24 de VBox:

    * ansible-userv:10.0.2.60
    * ansible-deb1:10.0.2.70
    * ansible-deb2:10.0.2.80

* Crear relación de confianza ssh entre 10.0.2.60 y 10.0.2.70

* Crear relación de confianza ssh entre 10.0.2.60 y 10.0.2.80

* Instalar ansible en 10.0.2.60 desde el repositorio de la distro.

* Modificar el HOSTNAME de sistema de la máquina ansible-userv a ansible-n0.

* En los tres sistemas registrar los nodos en /etc/hosts con los siguientes nombres:

|direccion|nodo|nombre|
|:-:|:-:|:-:|
|10.0.2.60|   nodo-0|   ansible-n0|
|10.0.2.70  | nodo-1   |ansible-n1|
|10.0.2.80   |nodo-2  | ansible-n2|

 + En caso de no existir, Instalar ansible desde los repositorios, en la máquina ansible-userv

+ En caso de no existir, instalar python desde los repositorios en las máquinas debian. Debe ser una versión compatible con la instalada en la máquina userv.

+ Insertar el usuario operador en nodo-0. Debe estar dotado de $HOME, passwd y una shell bash para interactuar con el sistema.

+ El usuario operador de nodo-0 necesita tener en su poder la parte privada de una par de claves creadas al efecto por root en los nodos administrados. Hacer las operaciones necesarias para alcanzar este objetivo.

+ En este punto, crear copias de seguridad de los vdi,s por si hay que dar marcha atrás en el desarrollo de las tareas con ansible.

## Ansible

Antes de proceder ten en cuenta que ansible ha sido instalado desde los repositorios de una distro, con lo cual, el despliegue de archivos sobre el sistema de ficheros es distinto al que se obtuvo con la instalación manual  descrita en ansible_director.pdf (podría no haberse hecho manualmente dependiendo de las instancias de AWS usadas), ahora, entre otras cosas, se cuenta con varios ficheros por defecto, un despliegue disperso por todo el árbol de directorios (usar dpkg -L si se quiere averiguar dónde está cada cosa) y una notable ampliación del catálogo de módulos disponibles (verifíquese con el comando help invocado desde el prompt que proporciona ansible-console).

Se aconseja al alumno que antes de insertar lineas de texto en los playbooks sin más, lo cual, le obligará a posteriori a ir depurando por el procedimiento de ejecución->error->depuración y vuelta a empezar, utilice al comando ansible para probar prototipos de argumentación de módulos antes de llevar la versión definitiva al fichero de texto. Esto le ahorrará tiempo y malos ratos.

Como el alumno sabe, los modificadores   -i   -u   --key-file   del comando ansible-playbook permiten a un usuario sin privilegios actuar como root en las máquinas objetivo, dicho lo cual..... hacer login al nodo-0 como operador y, manteniendo esta identidad, realizar las siguientes operaciones:

+ Crear el inventario de ansible de acuerdo a las siguientes especificaciones:
    + El nodo de control es nodo-0
    + Los nodos administrados son nodo-1 y nodo-2
    + Insertar entradas en el inventario que permitan actuar sobre los dos nodos como grupo y de forma independiente en cada uno

+ Completa las siguientes tareas

    + Prueba la conectividad entre nodo-0 y nodo-1 y entre nodo-0 y nodo-2
    + Ejecuta en el nodo-1 desde nodo-0 la instrucción hostname.
    + Crea un directorio en el nodo-1 y comprueba que se ha creado.
    + Instala el servidor nginx en nodo-1. Comprueba que se ha realizado la instalación.
    + Intenta volver a ejecutar nginx en nodo-1. ¿Qué ocurre?
    + ¿Qué módulo de ansible tienes que usar para gestionar el servicio que acabas de instalar? Para el servicio nginx. Comprueba que has parado el servicio.
    + Desinstala el servidor nginx. Comprueba la desinstalación.
    + Crea un usuario en el servicio remoto. Comprueba que el usuario se ha creado.
    + Elimina el usuario que has creado. Comprueba que se ha eliminado de forma correcta.


+ Crea un directorio de nombre $HOME/ansible/playbooks/ y en su interior crear los playbooks descritos a continuación:

    + Nombre: hostname-nodo-1.apb
        + Función: Modifica el HOSTNAME de 10.0.2.70 por ansible-n1.
        + Indicaciones: El módulo lineinfile sirve para esto.

    + Nombre: hostname-nodo-2.apb
        + Función: Modifica el HOSTNAME de 10.0.2.80 por ansible-n2.
        + Indicaciones: El módulo lineinfile sirve para esto.     

    + Nombre: dnssetup.apb
        + Función: En los dos nodos administrados establece como servidor DNS primario 1.1.1.1 y secundario 8.8.8.8
        + Indicaciones: El módulo lineinfile sirve para esto.
    

