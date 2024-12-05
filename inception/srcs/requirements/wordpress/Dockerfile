FROM alpine:3.19.4

RUN apk update && \
    apk add \
    php \
    php-fpm \
    php-phar \
    php-cli \
    php-mysqli \
    php-mbstring \
    curl 

RUN adduser -D -G www-data www-data
    
COPY ./conf/www.conf /etc/php82/php-fpm.d/.

COPY ./tools/script.sh .
RUN chmod +x script.sh

EXPOSE 9000

ENTRYPOINT ["./script.sh", "php-fpm82", "-F"]


# docker build -t wordpress .
# docker run -it wordpress

#CMD ./usr/sbin/php-fpm7.3 -F
# запускаем php-fpm и -F
# принудительно оставаться на переднем плане и игнорировать параметр 
# демонизации из файла конфигурации

