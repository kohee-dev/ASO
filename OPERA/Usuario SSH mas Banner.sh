

#!/bin/bash

cp banner.txt /etc/banner.txt

if ! grep -q "Banner /etc/banner.txt" /etc/ssh/sshd_config; then
    echo "Banner /etc/banner.txt" >> /etc/ssh/sshd_config
fi

if ! id espectador >/dev/null; then
    useradd -m espectador
    echo "espectador:1234" | chpasswd
fi


cat << 'EOF' > /home/espectador/.bash_profile
ls /srv/jidoor/opera
exit
EOF

chown espectador:espectador /home/espectador/.bash_profile
chmod 644 /home/espectador/.bash_profile

systemctl restart sshd

echo "Espectador configurado."

