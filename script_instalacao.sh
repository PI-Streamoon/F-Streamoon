#!/bin/bash

# Verificação do Java
JAVAVERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
BDPATH="bd_stable.sql"
JARPATH="projeto-streamoon.jar"


sudo apt update

if [[ $JAVAVERSION == "17.0.5" ]];
    then
        echo "Java Instalado"
else
    sudo apt install openjdk-17-jre -y   
fi


# Verificação do Mysql

which docker

if [ $? != 0 ]
    then sudo apt install docker.io
fi

sudo systemctl start docker

sudo systemctl enable docker

sudo docker pull mysql:8.0

sudo docker run -d -p 3306:3306 --name containerBD  -e "MYSQL_ROOT_PASSWORD=urubu100" mysql:8.0

sudo docker exec -i containerBD mysql -h 0.0.0.0 -P 3306 -u root -p urubu100 mysql < bd_stable.sql



# Verificação se o .jar já foi instalado

if [ ! -e "$JARPATH" ];
    then
        echo "Baixando .Jar"
        wget https://github.com/PI-Streamoon/D-Streamoon/releases/download/v1/projeto-streamoon.jar

fi

# Executando .jar

java -jar "$JARPATH"

