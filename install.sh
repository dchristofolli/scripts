﻿#!/bin/bash
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
    
# Adicionando repositório docker
# Using bionic repository while eoan is not released 
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   bionic \
   stable"
   
# Uncomment when eoan repository available
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
apt install ./google-chrome-stable_current_amd64.deb
rm -f google-chrome-stable_current_amd64.deb*

echo “Instalação finalizada”
