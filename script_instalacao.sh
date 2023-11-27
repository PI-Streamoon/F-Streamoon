#!/bin/bash

# Verificação do Java
JAVAVERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
BDPATH="script_streamoon.sql"
JARPATH="projeto-streamoon.jar"


sudo apt update
sudo apt upgrade -y

if [[ $JAVAVERSION == "17.0.5" ]];
    then
        echo "Java Instalado"
else
    sudo apt install openjdk-17-jre -y   
fi


# Verificação do Mysql

if [ ! -e "$BDPATH" ];
    then
        echo "Baixando Banco de Dados"
        wget https://raw.githubusercontent.com/PI-Streamoon/B-Streamoon/main/script_streamoon.sql
fi

which docker

if [ $? != 0 ]
    then sudo apt install docker.io
fi

sudo systemctl start docker

sudo systemctl enable docker

sudo docker pull mysql:8.0

sudo docker run -d -p 3306:3306 --name containerBD  -e "MYSQL_ROOT_PASSWORD=urubu100" mysql:8.0
sudo docker start containerBD
sudo docker exec -i containerBD mysql -P 3306 -uroot -purubu100 mysql < script_streamoon.sql


# Verificação se o .jar já foi instalado

if [ ! -e "$JARPATH" ];
    then
        echo "Baixando .Jar"
        wget https://github.com/PI-Streamoon/D-Streamoon/releases/download/v2/projeto-streamoon.jar

fi

# Executando .jar

java -jar "$JARPATH"
