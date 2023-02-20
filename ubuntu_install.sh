#!/bin/bash
echo Updating repositories..
if ! sudo apt update
then
    echo "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/sudo apt/sources.list"
    exit 1
fi
echo “Atualização feita com sucesso”

echo “Atualizando pacotes já instalados”
if ! sudo apt upgrade -y
then
    echo “Não foi possível atualizar pacotes.”
    exit 1
fi
# shellcheck disable=SC1110
echo “Atualização de pacotes feita com sucesso”

# Zsh
sudo apt install zsh -y

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Docker
sudo apt -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo  tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt -y install docker-ce \
    docker-ce-cli \
    containerd.io -y \
    docker-compose-plugin

sudo tee -a /etc/docker/daemon.json > /dev/null << EOT
{
 "default-address-pools":[
   {"base":"10.16.0.0/16","size":24}
 ]
}
EOT

sudo usermod -aG docker $USER
sudo systemctl start docker
sudo systemctl enable docker

# Google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y
rm -f google-chrome-stable_current_amd64.deb*

# Sdkman
curl -s "https://get.sdkman.io" | bash
echo "source $HOME/.sdkman/bin/sdkman-init.sh" >> $HOME/.zshrc
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk i java 11.0.12-open
sdk i gradle

# IntelliJ
wget -q https://download.jetbrains.com/idea/ideaIU-2022.3.2.tar.gz
sudo tar -xzf ideaIU-2022.3.2.tar.gz -C /opt
rm ideaIU-2022.3.2.tar.gz

# NodeJS (NVM)
#curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
#echo "export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm" >> /home/$USER/.bashrc
#echo "export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm" >> /home/$USER/.zshrc
#export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
#nvm install --lts

# VS Code
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" -y
sudo apt update
sudo apt install code

# Postman
curl https://dl.pstmn.io/download/latest/linux -o postman.tar.gz
tar zxvf postman.tar.gz
sudo mv Postman /opt
sudo ln -s /opt/Postman/Postman /usr/local/bin/postman
sudo tee -a /usr/share/applications/postman.desktop > /dev/null << EOT
[Desktop Entry]
Type=Application
Name=Postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Exec="/opt/Postman/Postman"
Comment=Postman GUI
Categories=Development;Code;
EOT
rm postman.tar.gz

# Genymotion
wget -q https://dl.genymotion.com/releases/genymotion-3.2.1/genymotion-3.2.1-linux_x64.bin
chmod +x genymotion-3.2.1-linux_x64.bin                                         
sudo ./genymotion-3.2.1-linux_x64.bin -y
rm genymotion-3.2.1-linux_x64.bin

# Spotify
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update && sudo apt install spotify-client -y

# a lot of apps :D
sudo apt install git vlc virtualbox flameshot copyq evolution-ews libqt5webkit5 htop chrome-gnome-shell gnome-shell-extensions gnome-tweaks -y

# Teams
wget "https://teams.microsoft.com/downloads/desktopurl?env=production&plat=linux&arch=x64&download=true&linuxArchiveType=deb" -O teams.deb
sudo apt -y install ./teams.deb
rm teams.deb

# RocketChat
wget "https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/3.8.7/rocketchat-3.8.7-linux-amd64.deb" -O rocketchat.deb
sudo apt -y install ./rocketchat.deb
rm rocketchat.deb

# Evernote
#wget "https://github.com/search5/Evernote-for-Linux/releases/download/v10.40.9-linux-ddl-ga-3494/evernote-client_10.40.9-3494_amd64.deb" -O evernote.deb
#sudo apt -y install ./evernote.deb
#rm evernote.deb

# Discord
#wget "https://dl.discordapp.net/apps/linux/0.0.20/discord-0.0.20.deb" -O discord.deb
#sudo apt -y install ./discord.deb
#rm discord.deb

# Gnome shell extensions

sudo apt autoremove -y

# IntelliJ first run
/opt/idea-IU-222.4167.29/bin/idea.sh

# https://extensions.gnome.org/extension/615/appindicator-support/
# AppIndicator and KStatusNotifierItem SupportAppIndicator and KStatusNotifierItem Support (enables GlobalProtect tray icon)
