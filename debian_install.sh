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
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Docker
sudo apt -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker $USER
sudo systemctl start docker
sudo systemctl enable docker

# Firefox
sudo wget -O firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US"
sudo mv firefox.tar.bz2 /opt
sudo tar -jxvf /opt/firefox.tar.bz2 -C /opt
sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
sudo wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop -P /usr/local/share/applications
sudo chown -R $USER:$USER /opt/firefox
sudo rm /opt/firefox.tar.bz2

# Google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y
rm -f google-chrome-stable_current_amd64.deb*

# Sdkman
sudo apt install zip
curl -s "https://get.sdkman.io" | bash
echo "source $HOME/.sdkman/bin/sdkman-init.sh" >> $HOME/.zshrc
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk i java 11.0.12-open
sdk i gradle

#IntelliJ

#Android Studio

# NodeJS (NVM)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
echo "export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm" >> /home/$USER/.bashrc
echo "export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm" >> /home/$USER/.zshrc
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
rm -rf Postman

# Virtualbox
wget https://download.virtualbox.org/virtualbox/6.1.38/virtualbox-6.1_6.1.38-153438~Debian~bullseye_amd64.deb
sudo apt -y install ./virtualbox-*.deb
rm virtualbox-*.deb

# Spotify
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update && sudo apt install spotify-client -y

# a lot of apps :D
sudo apt install git vlc flameshot copyq kazam evolution-ews libqt5webkit5 htop chrome-gnome-shell gnome-shell-extensions -y

# Teams
wget "https://teams.microsoft.com/downloads/desktopurl?env=production&plat=linux&arch=x64&download=true&linuxArchiveType=deb" -O teams.deb
sudo apt install ./teams.deb
rm teams.deb

# Genymotion
wget "https://dl.genymotion.com/releases/genymotion-3.2.1/genymotion-3.2.1-linux_x64.bin" -O genymotion.bin
chmod +x genymotion.bin
sudo ./genymotion.bin -y
rm genymotion.bin

# RocketChat
wget "https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/3.8.9/rocketchat-3.8.9-linux-amd64.deb" -O rocketchat.deb
sudo apt install ./rocketchat.deb
rm rocketchat.deb

# Evernote
wget "https://github.com/search5/Evernote-for-Linux/releases/download/v10.40.9-linux-ddl-ga-3494/evernote-client_10.40.9-3494_amd64.deb" -O evernote.deb
sudo apt install ./evernote.deb
rm evernote.deb

# Discord
#wget "https://dl.discordapp.net/apps/linux/0.0.18/discord-0.0.18.deb" -O discord.deb
#sudo apt -y install ./discord.deb
#rm discord.deb

# Removing junky
sudo apt -y remove gnome-2048 aisleriot cheese gnome-chess five-or-more four-in-a-row hitori gnome-klotski lightsoff gnome-mahjongg gnome-mines gnome-music gnome-nibbles quadrapassel rhythmbox gnome-robots shotwell gnome-sound-recorder gnome-sudoku swell-foop tali gnome-taquin gnome-tetravex gnome-todo iagno

sudo apt autoremove -y
