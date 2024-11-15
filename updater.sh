#!/bin/bash

# Updater v1.1, Author: Adrián Fernández Álvarez

#Colours
nocolor="\033[0m\e[0m"
green="\e[0;32m\033[1m"
red="\e[0;31m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"

#select language
is_root=("Necesitas ser root para ejecutar el script" "You need to be root to execute the script.")
inicio=("Iniciando..." "Starting...")
question=("Te recomendamos reiniciar el sistema. ¿Quieres hacerlo ahora? (s/n): " "We recomended reboot the system. do you want it now? (y/n): ")
restart_lan=("La maquina se reiniciara en unos instantes." "The system will restart in a few moments.")
rest_lan=("Has decidido no reiniciar de momento." "You have decided not to restart for now.")
option=$1
if [[ "$option" == "-es" ]]; then
	option=0
elif [[ "$option" == "-en" ]]; then
	option=1
else
	echo -e "${nocolor}Do you need to use ${red}-es ${nocolor}or ${red}-en${nocolor} argument to select the language."
	echo -e "${nocolor}Tienes que usar ${red}-es ${nocolor}o ${red}-en${nocolor} como argumento para selecionar el idioma."
	exit
fi

# Check if user is root
user=$(whoami)
if [[ "$user" != "root" ]]; then
	echo -e "${red}${is_root[$option]}${nocolor}"; exit
else
	echo -e "${purple}[${turquoise}-${purple}]${nocolor}${inicio[$option]}${nocolor}"
fi
clear

# Update, upgrade, autoremove system and do feedback
apt -y update > /dev/null 2>&1; echo -e "${purple}[${turquoise}-${purple}]${yellow} Update ${green}Ok${nocolor}"
apt -y upgrade > /dev/null 2>&1; echo -e "${purple}[${turquoise}-${purple}]${yellow} Upgrade ${green}Ok${nocolor}"
apt -y autoremove > /dev/null 2>&1; echo -e "${purple}[${turquoise}-${purple}]${yellow} Autoremove ${green}Ok${nocolor}"

# reboot the system if the user want
read -p "${question[$option]}" restart 
restart=$(echo "$restart" > /dev/null | tr '[:upper:]' '[:lower:]')
if [[ "$restart" == "y" || "$restart" == "yes" || "$restart" == "" || "$restart" == "si" || "$restart" == "s" ]]; then
	echo "${restart_lan[$option]}"
	sleep 2
	reboot -f
elif [[ "$restart" == "n" || "$restart" == "no" ]]; then
	echo "${rest_lan[$option]}."
else
	echo -e "${rojo}Error input code: #ae2857d550b5cc5baed4${nocolor}"
fi

