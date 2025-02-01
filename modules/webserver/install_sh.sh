#!/bin/bash
# Actualizar los paquetes e instalar NGINX
sudo apt-get update
sudo apt-get install -y nginx

# Iniciar NGINX
sudo systemctl start nginx

# Habilitar NGINX para que inicie al arrancar
sudo systemctl enable nginx
