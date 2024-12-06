1. Делаем вирт. машину (Virtualbox) -все как в born2beRoot, только на диски делить не нужно и из софта надо поставить GNOME и SSH server. 10 гиг - норм
2. В готовой ВМ ставим пакеты:
   - apt update
   - apt upgrade
   - apt install -y sudo ufw docker docker-compose make vim
3. Настраиваем ssh
   - логинимся под суперпользователем (su root) и открываем файл /etc/ssh/sshd_config
   - меняем порт: Port 42 и разрешаем логиниться под суперпользователем: PermitRoot Login yes
   - перезапускаем сервисы ssh и sshd (service ssh restart или sudo systemctl restart ssh) проверка sudo systemctl status ssh
4. Открываем в файерволе порт 42 для ssh, 80 для админера (у меня)  и 443 для веб-сайта.
   - запускаем файервол командой ufw enable
   - разрешаем каждый порт: ufw allow 42 ufw allow 80 ufw allow 443, проверка ufw status или sudo systemctl status ufw
5. закрыть ВМ: sudo shutdown now, перегрузить sudo reboot
6. Проброс портов в Virtualbox: настройки -> сеть -> дополнительно -> проброс портов, и прописываем SSH-TCP-42-42, HTTP-TCP-80-80, HTTPS-TCP-443-443
7. Заходим в ВМ через терминал на маке (или терминал VSCode) ssh root@localhost -p 42 или ssh adelaloy@localhost -p 42
8. Расшарить папку на маке с ВМ:
   - VB-settings-shared folders жмем плюс справа, добавляем путь к папке
   - in the terminal of VB:  
        mkdir ~/shared  
        sudo mount -t vboxsf -o rw SharedFolder ~/shared.  (!!  SharedFolder=inception)  
        sudo mount -t vboxsf -o rw inception ~/shared  
        ls ~/shared  
  После этого есть два варианта:  
   - все делать из VSCode через ssh соединение  
   - все делать внутри ВМ из папки shared  
9. Настраиваем права пользователя в ВМ и добавляем имя сервера в список разрешённых хостов
   - vim /etc/sudoers -> adelaloy ALL=(ALL:ALL) ALL
   - sudo adduser login (или sudo usermod -aG sudo login)
   - sudo usermod -aG docker adelaloy
   - sudo usermod -aG vboxsf adelaloy (if you use shared folders on your vm)
   - sudo vim /etc/hosts -> добавляем 127.0.0.1 adelaloy.42.fr
  
10. КОМАНДЫ docker compose (или docker-compose, зависит от версии)  
    простая для сборки всех контейнеров: docker compose up --build  
    полная с именем: docker compose -p inception up --build -d (сначала полезно запускать без -d, видны все логи)    
         -p : name of the project  
         up : create and start the containers  
         --build : build the images if they don't exist or if they have been modified  
         -d : run the containers in the background  
    остановить все контейнеры: docker compose -p inception down  
    список запущенных контейнеров: docker-compose -p inception ps (если у проекта есть имя, то просто docker-compose ps не работает)  
    остановить все контейнеры: docker stop $(docker ps -a -q)  
    удалить все контейнеры: docker rm $(docker ps -a -q)  
    удаляет все неиспользуемые контейнеры, образы, тома и сети: docker system prune  
  
11. КОМАНДЫ для доступа к отдельным контейнерам (когда уже все запущено)  
      
    NGINX. Эта команда позволяет подключиться к контейнеру с Nginx, который обычно используется как веб-сервер и обратный прокси.  
    docker exec -it nginx bash  
    Проверка конфигурационных файлов: cat /etc/nginx/nginx.conf cat /etc/nginx/conf.d/default.conf  
    Проверка доступных логов: tail -f /var/log/nginx/access.log tail -f /var/log/nginx/error.log  
    Проверка состояния Nginx: Вы можете проверить, запущен ли процесс Nginx: ps aux | grep nginx  
    Проверка портов: Вы можете проверить, слушает ли Nginx на нужных портах: netstat -tuln  
  
    WORDPRESS  
    docker exec -it wordpress sh  
    Проверка конфигурации WordPress: cat /var/www/html/wp-config.php  
    Проверка установленных плагинов: ls /var/www/html/wp-content/plugins  
    Проверка прав доступа и владельцев файлов: ls -l /var/www/html  
    Проверка доступности базы данных: ping mariadb  
  
    MARIADB  
    docker exec -it mariadb bash  
    проверка переменных окружения: env  
    проверка конфигурации: cat /etc/mysql/mariadb.conf.d/50-server.cnf  
    Проверка логов: tail -f /var/log/mysql/error.log  
  
    Заходим в базу данных без логина: mysql  
    заходим под рутом: mysql -u root -p  
    залогиниться: mysql -u DBUSER -p (или сразу: docker exec -it mariadb mysql -u dbuser -p)  
  
    Мы внутри БД. Здесь работают запросы SQL  
    SHOW DATABASES;  
    SHOW VARIABLES;  
    SELECT user, host, password FROM mysql.user;  
    USE inception_db;  
    SELECT * FROM wp_users;  
    SHOW tables from inception_db;  



    
