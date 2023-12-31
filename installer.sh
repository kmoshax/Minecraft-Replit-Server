#!/bin/bash
echo -e "\e[1;34m==================================\e[0m"
echo "  _  ____  __  ___  ___ _  _   _   
 | |/ /  \/  |/ _ \/ __| || | /_\  
 | ' <| |\/| | (_) \__ \ __ |/ _ \ 
 |_|\_\_|  |_|\___/|___/_||_/_/ \_\
"
echo -e "\e[1;34m| Starting...
| Main author for this project is FDMZ17 & Edited By KmoSha.
| Create backup.me file to backup server file.
| For better performance use Hacker Plan Repl.
| Supported version: 1.20.x\e[0m".
echo -e "\e[1;34m==================================\e[0m"
read -r -p "
Could find server.sh
1) PaperMC    [JAVA]
2) Purpur     [JAVA]
3) Vanila     [JAVA]
4) Spigot     [JAVA]
0) Exit
Choose a Number from 0 to 5.
> " response
if [[ "$response" =~ ^([1][eE][sS]|[1])$ ]]
then
    wget https://raw.githubusercontent.com/kmoshax/Minecraft-Replit-Server/main/paper/server.sh
    bash server.sh
fi    

if [[ "$response" =~ ^([2][eE][sS]|[2])$ ]]
then
    wget https://raw.githubusercontent.com/kmoshax/Minecraft-Replit-Server/main/purpur/server.sh
    bash server.sh
fi

if [[ "$response" =~ ^([3][eE][sS]|[3])$ ]]
then
    wget https://raw.githubusercontent.com/kmoshax/Minecraft-Replit-Server/main/vanila/server.sh
    bash server.sh
fi

if [[ "$response" =~ ^([4][eE][sS]|[4])$ ]]
then
    wget https://raw.githubusercontent.com/kmoshax/Minecraft-Replit-Server/main/spigot/server.sh
    bash server.sh
fi

if [[ "$response" =~ ^([0][eE][sS]|[0])$ ]]
then
    exit
fi
