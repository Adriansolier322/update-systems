#!/bin/bash

# Updater v1.0, Author: Adrián Fernández Álvarez

#Colours
nocolor="\033[0m\e[0m"
green="\e[0;32m\033[1m"
red="\e[0;31m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"

#select language
language=("Te recomendamos reiniciar el sistema. ¿Quieres hacerlo ahora? (y/n): " "We recomended reboot the system. do you want it now? (y/n): ")
option=$1
if [[ "$option" == "-es" ]]; then
	option="${language[0]}"
elif [[ "$option" == "-en" ]]; then
	option="${language[1]}"
else
	echo -e "${nocolor}Do you need to use ${red}-es ${normal}or ${red}-en${normal} argument to select the language."
	echo -e "${nocolor}Tienes que usar ${red}-es ${normal}o ${red}-en${normal} como argumento para selecionar el idioma."
	exit
fi
clear

# Check if user is root
function user_root(){
	user=$(whoami)
	if [[ "$user" != "root" ]]; then
		echo -e "${red}Necesitas ser root para ejecutar el script"; tput cnorm; exit
	else
	echo -e "${purple}[${turquoise}-${purple}]${nocolor} Iniciando...${nocolor}"
	fi
}

# Update, upgrade, autoremove system and do feedback
apt -y update > /dev/null 2>&1; echo -e "${purple}[${turquoise}-${purple}]${yellow} Update ${green}Ok${nocolor}"
apt -y upgrade > /dev/null 2>&1; echo -e "${purple}[${turquoise}-${purple}]${yellow} Upgrade ${green}Ok${nocolor}"
apt -y autoremove > /dev/null 2>&1; echo -e "${purple}[${turquoise}-${purple}]${yellow} Autoremove ${green}Ok${nocolor}"

# reboot the system if the user want
read -p "$option" restart 
restart=$(echo "$restart" > /dev/null | tr '[:upper:]' '[:lower:]')
if [[ "$restart" == "y" || "$restart" == "yes" || "$restart" == "" ]]; then
	echo "La maquina se reiniciara en unos instantes."
	sleep 2
	reboot -f
elif [[ "$restart" == "n" || "$restart" == "no" ]]; then
	echo "Has decidido no reiniciar ahora."
else
	echo "Respuesta invalida."
fi

