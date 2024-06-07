# Usa una imagen base de Ubuntu
FROM ubuntu:latest

# Actualiza los repositorios e instala las dependencias necesarias
RUN apt-get update && \
    apt-get install -y wget build-essential apache2 php libapache2-mod-php libgd-dev unzip

# Crea un usuario y grupo para Nagios
RUN useradd nagios && \
    usermod -a -G nagios www-data

# Descarga e instala Nagios Core
RUN cd /tmp && \
    wget https://github.com/NagiosEnterprises/nagioscore/releases/download/nagios-4.4.6/nagios-4.4.6.tar.gz && \
    tar xzf nagios-4.4.6.tar.gz && \
    cd nagios-4.4.6 && \
    ./configure --with-httpd-conf=/etc/apache2/sites-enabled && \
    make all && \
    make install && \
    make install-init && \
    make install-config && \
    make install-commandmode && \
    make install-webconf

# Descarga e instala plugins de Nagios
RUN cd /tmp && \
    wget https://nagios-plugins.org/download/nagios-plugins-2.3.3.tar.gz && \
    tar xzf nagios-plugins-2.3.3.tar.gz && \
    cd nagios-plugins-2.3.3 && \
    ./configure && \
    make && \
    make install

# Copia el archivo de configuración de Apache para Nagios a sites-available
COPY nagios.conf /etc/apache2/sites-available/

# Configura ServerName para evitar advertencias de Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Modifica el permiso del directorio para que el usuario tenga control sobre los archivos
RUN chown -R nagios:nagios /usr/local/nagios/etc/

# Habilita los módulos de Apache necesarios y reinicia Apache
RUN a2enmod cgi && \
    service apache2 restart

# Establece la contraseña para el usuario 'nagiosadmin'
RUN htpasswd -b -c /usr/local/nagios/etc/htpasswd.users nagiosadmin Nagios.2024

#Exoner el puerto 80
EXPOSE 80

# Copia el script de inicio al contenedor
COPY script.sh /usr/local/bin/script.sh

# Da permisos de ejecución al script de inicio
RUN chmod +x /usr/local/bin/script.sh

# Usar el script de inicio como el comando para iniciar el contenedor
CMD ["/usr/local/bin/script.sh"]