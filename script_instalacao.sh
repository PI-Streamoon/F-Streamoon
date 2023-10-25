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


if [ ! -e "$BDPATH" ];
    then
        echo "Baixando Banco de Dados"
        wget https://raw.githubusercontent.com/PI-Streamoon/B-Streamoon/main/bd_stable.sql
fi

which mysql

if [ $? == 0 ];
        then 
            echo "MySql Instalado"
            /etc/init.d/mysql start
else 
    echo "MySql não instalado"
    sudo apt install mysql-server -y
    echo "Configur o seu MySql"
    /etc/init.d/mysql start
    sudo mysql_secure_installation
fi

sudo mysql -u "root" -h "localhost" -e "USE streamoon"

if [ $? != 0 ];
    then
        sudo mysql -u "root" "" < "$BDPATH"
    else
        echo "banco criado"
fi

# Verificação se o .jar já foi instalado

if [ ! -e "$JARPATH" ];
    then
        echo "Baixando .Jar"
        wget https://github.com/PI-Streamoon/D-Streamoon/releases/download/v1/projeto-streamoon.jar

fi

# Executando .jar

java -jar "$JARPATH"

