FROM debian

MAINTAINER korevsky@mail.ru

RUN apt-get update && apt-get -y install && \
    apt-get -y install nginx && \
    apt-get clean && \
    rm -rf /var/www/* && \
    mkdir -p /var/www/company.com/img

COPY ./index.html /var/www/company.com
COPY ./img.jpg /var/www/company.com/img

RUN chmod 754 /var/www/company.com && \
    /usr/sbin/useradd max && \
    /usr/sbin/groupadd korevsky && \
    /usr/sbin/usermod -a -G korevsky max && \
    chown -R max:korevsky /var/www/company.com && \
    sed -i 's/var\/www\/html/var\/www\/company.com/g' /etc/nginx/sites-enabled/default && \
    sed -i 's/www-data;/max;/g' /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]