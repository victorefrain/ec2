#!/bin/bash
# Importar la clave pública utilizada por el sistema de paquetes
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6

# Crear un archivo de lista de MongoDB para Ubuntu
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list

# Actualizar el índice de paquetes locales
sudo apt-get update

# Instalar los paquetes de MongoDB
sudo apt-get install -y mongodb-org

# Iniciar MongoDB
sudo systemctl start mongod

# Habilitar MongoDB para que inicie al arrancar
sudo systemctl enable mongod
