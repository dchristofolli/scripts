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

# Git
apt install git -y

# Zsh
apt install zsh -y
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y

# Gnome
apt install gnome-session -y

# Docker
apt -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
 add-apt-repository \
 "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
 $(lsb_release -cs) \
 stable"
apt update
apt -y install docker-ce \
    docker-ce-cli \
    containerd.io -y
usermod -aG docker $USER
systemctl start docker
systemctl enable docker
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./google-chrome-stable_current_amd64.deb -y
rm -f google-chrome-stable_current_amd64.deb*

# Sublime text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
apt update
apt install sublime-text -y

# Sdkman
curl -s "https://get.sdkman.io" | bash
echo "source $HOME/.sdkman/bin/sdkman-init.sh" >> $HOME/.shrc
echo "source $HOME/.sdkman/bin/sdkman-init.sh" >> $HOME/.zshrc
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk i java 11.0.12-open
sdk i gradle

# NodeJS
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
echo "export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm" >> /home/daniel/.bashrc
echo "export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm" >> /home/daniel/.zshrc
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts

# VS Code
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install code

# Postman
curl https://dl.pstmn.io/download/latest/linux -o postman.tar.gz
tar zxvf postman.tar.gz
mv Postman /opt
ln -s /opt/Postman/Postman /usr/local/bin/postman
cat <<EOF > /usr/share/applications/postman.desktop
[Desktop Entry]
Type=Application
Name=Postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Exec="/opt/Postman/Postman"
Comment=Postman GUI
Categories=Development;Code;
EOF
rm Postman-linux-x64-*.tar.gz

# Spotify
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
apt update && apt install spotify-client -y

# VLC e Virtualbox
apt install vlc virtualbox -y

# Teams
wget "https://teams.microsoft.com/downloads/desktopurl?env=production&plat=linux&arch=x64&download=true&linuxArchiveType=deb" -O teams.deb
apt install ./teams.deb
rm teams.deb

# RocketChat
wget "https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/3.7.7/rocketchat_3.7.7_amd64.deb" -O rocketchat.deb
apt install ./rocketchat.deb
rm rocketchat.deb