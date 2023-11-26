#!/bin/bash

# Verificação do Java
JAVAVERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
JARPATH="projeto-streamoon.jar"


sudo apt update
sudo apt upgrade -y

if [[ $JAVAVERSION == "17.0.5" ]];
    then
        echo "Java Instalado"
else
    sudo apt install openjdk-17-jre -y   
fi


# Verificação se o .jar já foi instalado

if [ ! -e "$JARPATH" ];
    then
        echo "Baixando .Jar"
        wget https://github.com/PI-Streamoon/D-Streamoon/releases/download/v2/projeto-streamoon.jar

fi

# Executando .jar

java -jar "$JARPATH"
