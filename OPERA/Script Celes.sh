#!/bin/bash

userdel -r Maria >/dev/null
useradd -m -s /bin/bash Celes
cp -r /home/Maria/* /home/Celes >/dev/null
mv /home/Celes/Maria.txt /home/Celes/Celes.txt >/dev/null
useradd -m Locke
echo "Celes y Locke preparados"
