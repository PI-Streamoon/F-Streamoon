#!/bin/bash

sudo apt update

# Verificação do Java
JAVAVERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')

if [[ $JAVAVERSION == "17.0.5" ]];
    then
        echo "Java Instalado"
else
    sudo apt install openjdk-17-jre -y   
fi


# Verificação do Mysql

wget https://raw.githubusercontent.com/PI-Streamoon/B-Streamoon/main/script_streamoon.sql
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

sudo mysql -u "root" -h "localhost" "streamoon" < "script_streamoon.sql"
# Verificação se o .jar já foi instalado