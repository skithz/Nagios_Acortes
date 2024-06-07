#!/bin/bash

# Reiniciar el servicio Nagios
echo "Reiniciando el servicio de Nagios..."
service nagios reload
echo "Servicio de Nagios reiniciado."

# Iniciar Apache en primer plano
echo "Iniciando Apache..."
apache2ctl -D FOREGROUND