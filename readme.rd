# **Instrucciones para Desplegar el Contenedor Nagios**

## Clonar el Repositorio

    Clona el repositorio que contiene los archivos.

    git clone https://github.com/skithz/Nagios_Acortes.git

## Desplegar con Docker Compose

docker-compose up -d

## Acceder a la Interfaz Web de Nagios

    Para una maquina local abrir un navegador web e ingresar a http://localhost:8080/nagios, en caso de ser una instancia se debe agregar el puerto 8080 en las reglas del firewal, luego ingresar a  http://ip_publica:8080/nagios
    Utiliza las siguientes credenciales para iniciar sesión

            +---------------------------+
            |        Credenciales       |
            +-------------+-------------+
            |   Usuario   |  Contraseña |
            +-------------+-------------+
            | nagiosadmin | Nagios.2024 |
            +-------------+-------------+
