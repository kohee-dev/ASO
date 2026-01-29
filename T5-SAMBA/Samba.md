---
autor: Alejandro Bartolomé
asignatura: [ASO,ASIR]
tema: Samba
Titulo: Recursos Compartidos con Samba
---
# Recursos compartidos con Samba

En esta práctica vamos a crear un recurso compartido usando Samba.

## Requisitos

Para la realización de la actividad se necesitan los siguientes requisitos previos.

- Un sistema Linux y un sistema Windows que actuen como cliente.
- Un servidor Linux.
- Paciencia.


## Instalación

```bash
sudo apt update 
sudo apt install samba 
```

## Configuración inicial

El fichero de configuración se encuentra en la siguiente ruta `/etc/samba/smb.conf`.

Este archivo controla cómo se definen los recursos compartidos y cómo pueden acceder a ellos los clientes. Antes de realizar cualquier cambio, vamos a hacer una copia de seguridad del archivo de configuración original.

```bash
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bckup
```

Ahora crearemos la carpeta que querremos compartir y le daremos los permisos pertinentes

```bash
sudo mkdir -p /srv/sambashare 
sudo chmod 2775 /srv/sambashare
sudo chown nobody:nogroup /srv/sambashare

```
¿Que implica `2775` en el chmod?

Indica que usuarios podrán escribir, que usuarios podrán leer y que usuarios podrán acceder a la carpeta. 

Ahora en `/etc/samba/smb.conf` agrega lo siguiente al final

```
[sambashare]
path = /srv/sambashare
browsable = yes
writable = yes
guest ok = yes
read only = no
```

- **path**: Especifica el directorio que se va a compartir.
- **browsable**: Permite que el recurso compartido sea visible al navegar por la red.
- **writable**: Permite a los usuarios escribir en el directorio compartido.
- **guest ok**: Permite a los usuarios invitados acceder al recurso compartido sin necesidad de contraseña.
- **read only**: Si se establece en no, los usuarios pueden modificar los archivos del recurso compartido.

Guarda y reinicia el servicio `smbd`

## Usuarios

Crea el usuario `smbuser` y luego dale una contraseña Samba con el siguiente comando:

```
sudo smbpasswd -a smbuser
```

¿Que otras opciones tiene smbpasswd?

Ahora prueba la configuración de Samba con el siguiente comando:

```
testparm
```

## Conexión

Con todo configurado correctamente solo quedan hacer las pruebas de conexión. Abre los clientes de Windows y Linux e intenta entrar en el recurso compartido.

### Windows
```
\\IP-address\sambashare 
```
### Linux
```
smbclient //dirección-IP/sambashare -U smbuser 
```
o
```
sudo mount -t cifs //IP-address/sambashare /mnt/sambashare -o username=smbuser 
```




