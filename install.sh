#!/bin/bash
echo Updating repositories..
if ! apt update
then
    echo "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list"
    exit 1
fi
echo “Atualização feita com sucesso”

echo “Atualizando pacotes já instalados”
if ! apt dist-upgrade -y
then
    echo “Não foi possível atualizar pacotes.”
    exit 1
fi
# shellcheck disable=SC1110
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

# Google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./google-chrome-stable_current_amd64.deb -y
rm -f google-chrome-stable_current_amd64.deb*

# Checkpoint vpn
apt install default-jdk \
    libnss3-tools \
    openssl xterm libpam0g:i386 \
    libx11-6:i386 \
    libstdc++6:i386 \
    libstdc++5:i386 -y
wget https://vpn.dimed.com.br/sslvpn/SNX/INSTALL/snx_install.sh --no-check-certificate
wget https://vpn.dimed.com.br/sslvpn/SNX/INSTALL/cshell_install.sh --no-check-certificate
chmod +x *.sh
sudo ./snx_install.sh
sudo ./cshell_install.sh
rm -f snx_install.sh cshell_install.sh

# VS Code
wget "https://go.microsoft.com/fwlink/?LinkID=620884" -O vscode.tar.gz
tar -vzxf vscode.tar.gz -C /opt/
mv /opt/VSCode*/ /opt/vscode/
ln -sf /opt/vscode/code /usr/bin/code
echo -e '[Desktop Entry]\n Version=1.0\n Name=vscode\n 
Exec=/opt/vscode/code\n Icon=/opt/vscode/resources/app/resources/linux/code.png\n 
Type=Application\n Categories=Application' | 
tee /usr/share/applications/vscode.desktop

# Insomnia rest
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list
wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc \
    | sudo apt-key add -
apt update
apt install insomnia -y

# Sublime text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
apt update
apt install sublime-text -y

# Zsh
apt install zsh -y

# Spotify
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
apt update && apt install spotify-client -y

# VLC
apt install vlc -y

# Slack
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.4.3-amd64.deb
apt install ./slack-desktop-4.4.3-amd64.deb -y
rm -f slack-desktop-4.4.3-amd64.deb

# Sdkman
curl -s "https://get.sdkman.io" | bash
Follow the instructions on-screen to complete installation.
source "$HOME/.sdkman/bin/sdkman-init.sh

# NodeJS
wget https://nodejs.org/dist/v12.16.3/node-v12.16.3-linux-x64.tar.xz
mkdir -p /usr/local/lib/nodejs
tar -xJvf node-v12.16.3-linux-x64.tar.xz -C /usr/local/lib/nodejs 
export PATH=/usr/local/lib/nodejs/node-v12.16.3-linux-x64/bin:$PATH
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo "export PATH=~/.npm-global/bin:$PATH < ~/.profile"
source ~/.profile

# Configuração driver Nvidia
bash -c "echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
bash -c "echo options nouveau modeset=0 >> /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
bash -c "echo options nvidia-drm modeset=1 >>  /etc/modprobe.d/nvidia-drm-nomodeset.conf"

# Limpeza e finalização
apt upgrade -y
apt install -f
update-initramfs -u
apt autoremove -y
reboot
