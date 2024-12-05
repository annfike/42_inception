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
RUN apt install mariadb-server -y 


RUN chown -R mysql:mysql /var/lib/mysql
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld && chmod 777 /run/mysqld
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/mariadb.sh /
RUN chmod +x /mariadb.sh

EXPOSE 3306

ENTRYPOINT ["./mariadb.sh" ]

CMD ["mysqld_safe"]


# docker build -t mariadb .
# docker run -it mariadb /bin/bash
#мы в терминале внутри контейнера
#env
#cat /etc/mysql/mariadb.conf.d/50-server.cnf
#mysql
#mysql –u root –p =зайти под рутом
#мы внутри ДБ
#SELECT user, host, password FROM mysql.user;
#SHOW databases;
#USE inception_db;
#SELECT * FROM wp_users;
#SHOW tables from inception_db;


#залогиниться:
#mysql -u DBUSER -p
#или сразу: docker exec -it mariadb mysql -u dbuser -p
#mysqladmin -u root -p status

