#!/bin/bash
set -e
root=$PWD
mkdir -p server
cd server


# Server Config
MC=1.20.1
RAM=200m

download() {
    set -e
    echo -e "\e[1;33mfdmz17@script~\e[0m" Running agreement script...
    echo -e "\e[1;33m[FDMZ17 Script]:\e[0m" ---------- Script version: 1.5  ----------
    echo -e "\e[1;33m[FDMZ17 Script]:\e[0m" By executing this script you agree to:
    echo -e "\e[1;33m[FDMZ17 Script]:\e[0m" The MIT license
    echo -e "\e[1;33m[FDMZ17 Script]:\e[0m" The JRE License 
    echo -e "\e[1;33m[FDMZ17 Script]:\e[0m" The Mojang Minecraft EULA.
    echo -e "\e[1;33m[FDMZ17 Script]:\e[0m" Press Enter to agree, press Ctrl+C if you do not agree to any of these licenses.
    read     -s agree_text
    echo -e "\e[1;33m[FDMZ17 Script]:\e[0m" Thank you \for agreeing, the download will now begin.
    echo -e "\e[1;33mfdmz17@script~\e[0m" Running setup script...
    wget -O server.jar "https://api.pl3x.net/v2/purpur/1.16.5/1171/download"
    echo Paper downloaded
    wget -O server.properties "https://raw.githubusercontent.com/kmoshax/Minecraft-Replit-Server/main/server.properties"
    echo Server properties downloaded
    echo "eula=true" > eula.txt
    echo Agreed to Mojang EULA
    wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
    wget https://raw.githubusercontent.com/kmoshax/Minecraft-Replit-Server/main/world/world.zip
    unzip -o world.zip
    unzip -o ngrok.zip
    rm -rf world.zip
    rm -rf ngrok.zip
    echo "Download complete" 
}

require() {
    if [ ! $1 $2 ]; then
        echo $3
        download
    fi
}
require_file() { require -f $1 ""; }
require_dir()  { require -d $1 ""; }
require_env()  {
    var=`python3 -c "import os;print(os.getenv('$1',''))"`
    if [ -z "${var}" ]; then
        echo "Environment variable $1 not set. "
        echo "Make a new secret called $1 and set it to $2"
        exit
    fi
    eval "$1=$var"
}
require_executable() {
    require_file "$1"
    chmod +x "$1"
}

# server files
require_file "eula.txt"
require_file "server.properties"
require_file "server.jar"
require_executable "ngrok"

# environment variables
require_env "ngrok_token" "your ngrok authtoken from https://dashboard.ngrok.com/get-started/your-authtoken"
require_env "ngrok_region" "choose your region, select one:
us - United States (Ohio)
eu - Europe (Frankfurt)
ap - Asia/Pacific (Singapore)
au - Australia (Sydney)
sa - South America (Sao Paulo)
jp - Japan (Tokyo)
in - India (Mumbai)" 

# start tunnel
mkdir -p ./logs
touch ./logs/temp 
rm ./logs/*
echo "Starting server ngrok at tunnel $ngrok_region"
./ngrok authtoken $ngrok_token
touch logs/ngrok.log
./ngrok tcp -region $ngrok_region --log=stdout 1025 > ./logs/ngrok.log &
tail -f ./logs/ngrok.log | sed '/started tunnel/ q'
orig_server_ip=`curl --silent http://127.0.0.1:4040/api/tunnels | jq '.tunnels[0].public_url'`
trimmed_server_ip=`echo $orig_server_ip | grep -o '[a-zA-Z0-9.]*\.ngrok.io[0-9:]*'`
server_ip="${trimmed_server_ip:-$orig_server_ip}"
echo "Minecraft server ip: $server_ip"
echo "Minecraft server ip: $server_ip" > $root/server_ip.txt

touch logs/latest.log

echo -e "\e[1;33m[FDMZ17 Script]:\e[0m" Checking requirement file...
echo -e "\e[1;33m[FDMZ17 Script]:\e[0m" Running startup script...
echo -e "\e[1;33mfdmz17@script~\e[0m" Starting server...
echo -e "\e[1;33m[FDMZ17 Script]:\e[0m" Starting server at: $server_ip
echo -e "\e[1;33m[FDMZ17 Script]:\e[0m" Create file wth name backup.me to backup your server data

#Java startup argument
java -Xms128M -Xmx200M -Dterminal.jline=false -Dterminal.ansi=true -jar server.jar

echo -e "\e[1;33mfdmz17@script~\e[0m" Stopping server...
echo
echo -e "\e[1;33m[FDMZ17 Script]:\e[0m" ---------- Stopping server... ----------
echo -e "\e[1;33m[FDMZ17 Script]:\e[0m" Exit code: $?
echo -e "\e[1;33m[FDMZ17 Script]:\e[0m" Thank you for using my script
echo -e "\e[1;33m[FDMZ17 Script]:\e[0m" Script version: 1.5
echo -e "\e[1;33m[FDMZ17 Script]:\e[0m" Stopping server...
echo -e "\e[1;33mfdmz17@script~\e[0m" Server offline...