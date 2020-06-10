wget https://nodejs.org/dist/v12.17.0/node-v12.17.0-linux-x64.tar.xz
mkdir -p /usr/local/lib/nodejs
tar -xJvf node-v12.17.0-linux-x64.tar.xz -C /usr/local/lib/nodejs 
export PATH=/usr/local/lib/nodejs/node-v12.17.0-linux-x64/bin:$PATH
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo "export PATH=~/.npm-global/bin:$PATH < ~/.profile"
source ~/.profile
