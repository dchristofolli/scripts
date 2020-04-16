#!/bin/bash
# Adicionando repositório docker
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
echo Atualizando repositórios..
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

   apt install docker-ce \
    docker-ce-cli \
    containerd.io docker-compose -y
echo “Instalação finalizada”