# sudo dockerd - запустить демон docker
# загрузить без докерфайла: docker pull debian:bullseye
# установить образ: docker run -it debian:bullseye /bin/bash
# установить образ с именем: docker run -it --name debian_bullseye debian:bullseye /bin/bash
# запустить образ: docker start debian_bullseye
# подключиться к образу: docker exec -it debian_bullseye /bin/bash
# проверить образы: docker images
# удалить образ: docker rm debian_bullseye
# docker build srcs/requirements/nginx/ -t nginx
# docker build . -t имя - собрать образ из dockerfile в каталоге . (текущем)
# docker ps - Выводит список запущенных контейнеров и информацию о них
# docker ps -a - Выводит список всех контейнеров и информацию о них (и запущенных, и не запущенных)
# docker stop $(docker ps -a -q) - остановить все контейнеры
# docker rm $(docker ps -a -q) - удалить все контейнеры
# docker rm <container_id> - удалить контейнер

# Работа с dockerfile:
# FROM - образ на базе которого создается новый образ контейнера
# RUN - запустить команду на указанном образе
# COPY app.py /opt/app.py - скопировать файл app.py в образ в каталог /opt/app.py
# ENTRYPOINT - процесс запускаемый в контейнере

#-----------------------------------------------------------------------------------------------------
#указывает, что используется образ Debian версии Bullseye (Debian 11) в качестве основы для вашего контейнера.
FROM debian:bullseye

# Установка необходимых пакетов (загружает информацию о последних версиях пакетов, устанавливает обновления и пакеты, -y - автоматический ответ да на все вопросы)
RUN apt update && apt upgrade -y
RUN apt install -y curl vim wget nginx

RUN apt install openssl -y
RUN mkdir -p /etc/nginx/ssl && chmod 777 /etc/nginx/ssl

# создание SSL-сертификата самоподписанного(-х509) без шифрования(-nodes) сроком на 365 дней(-days 365) с использованием алгоритма RSA и длиной ключа 2048 бит(-newkey rsa:2048) subject(-subj) указывает на то, что сертификат будет выдан для домена adelaloy.42.fr
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048\
    -out /etc/nginx/ssl/adelaloy.42.fr.crt \
    -keyout /etc/nginx/ssl/adelaloy.42.fr.key \
    -subj "/C=CH/ST=VD/L=Lausanne/O=42/OU=42Lausanne/CN=adelaloy.42.fr/UID=adelaloy"

COPY conf/nginx.conf /etc/nginx/nginx.conf

# give rights to www-data
RUN chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html

# Для инфы. Команда EXPOSE не открывает порт на хосте. Она просто информирует Docker и других пользователей о том, что контейнер будет слушать на этом порту
EXPOSE 443

# Start nginx with daemon off
CMD ["nginx", "-g", "daemon off;"]

# docker build -t nginx .
#docker run -it nginx //-it   позволяет открыть контейнерный терминал при его запуске. У МЕНЯ НЕ РАБОТАЕТ
# docker run -it nginx /bin/bash РАБОТАЕТ!
# docker run -it -p 443:443 nginx


# Копирование файлов в контейнер
#COPY . /app
# Установка рабочей директории
#WORKDIR /app
# Команда для запуска приложения
# CMD ["./myapp"]