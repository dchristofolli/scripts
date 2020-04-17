#!/bin/bash
echo Updating repositories..
if ! apt update
then
    echo “Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list”
    exit 1
fi
echo “Atualização feita com sucesso”

echo “Atualizando pacotes já instalados”
if ! apt dist-upgrade -y
then
    echo “Não foi possível atualizar pacotes.”
    exit 1
fi
echo “Atualização de pacotes feita com sucesso”

# Docker
apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    
# Usando repositório Bionic enquanto o Eoan não é lançado 
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   bionic \
   stable"
   
# Descomentar quando a versão Eoan for lançada
# add-apt-repository \
# "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
# $(lsb_release -cs) \
# stable"
   
   apt update

apt install docker-ce \
    docker-ce-cli \
    containerd.io docker-compose -y
    
# sdkman
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./google-chrome-stable_current_amd64.deb -y
rm -f google-chrome-stable_current_amd64.deb*

# Checkpoint vpn
apt install default-jre \
    libnss3-tools \
    openssl xterm libpam0g:i386 \
    libx11-6:i386 \
    libstdc++6:i386 \
    libstdc++5:i386 -y
wget https://vpn.dimed.com.br/sslvpn/SNX/INSTALL/snx_install.sh --no-check-certificate
wget https://vpn.dimed.com.br/sslvpn/SNX/INSTALL/cshell_install.sh --no-check-certificate
chmod +x *.sh
./snx_install.sh -y
./cshell_install.sh -y
rm -f snx_install.sh cshell_install.sh

# VS Code
wget https://go.microsoft.com/fwlink/?LinkID=760868
apt install ./code*.deb -y
rm -f code*.deb

# Insomnia rest
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list
wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc \
    | sudo apt-key add -
apt update
apt install insomnia -y

echo “Instalação finalizada”
