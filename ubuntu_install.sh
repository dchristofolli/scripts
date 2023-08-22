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
#sudo apt install zsh -y

# oh-my-zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y
rm -f google-chrome-stable_current_amd64.deb*

# Sdkman
#curl -s "https://get.sdkman.io" | bash
#echo "source $HOME/.sdkman/bin/sdkman-init.sh" >> $HOME/.zshrc
#source "$HOME/.sdkman/bin/sdkman-init.sh"
#sdk i java 11.0.12-open
#sdk i gradle

# IntelliJ
wget -q https://download.jetbrains.com/idea/ideaIU-2023.2.tar.gz
sudo tar -xzf ideaIU-2023.2.tar.gz -C /opt
rm ideaIU-2023.2.tar.gz

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

# Spotify
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update && sudo apt install spotify-client -y

# a lot of apps :D
sudo apt install git vlc virtualbox flameshot copyq evolution-ews libqt5webkit5 htop chrome-gnome-shell gnome-shell-extensions gnome-tweaks -y

# Teams
wget "https://teams.microsoft.com/downloads/desktopurl?env=production&plat=linux&arch=x64&download=true&linuxArchiveType=deb" -O teams.deb
sudo apt -y install ./teams.deb
rm teams.deb

# RocketChat
wget "https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/3.9.6/rocketchat-3.9.6-linux-amd64.deb" -O rocketchat.deb
sudo apt -y install ./rocketchat.deb
rm rocketchat.deb

sudo apt autoremove -y

# IntelliJ first run
/opt/idea-IU-232.8660.185/bin/idea.sh

# https://extensions.gnome.org/extension/615/appindicator-support/
# AppIndicator and KStatusNotifierItem SupportAppIndicator and KStatusNotifierItem Support (enables GlobalProtect tray icon)
