# =============================================================================
#
# Multipurpose PHP Server
# 
# =============================================================================
FROM quay.io/centos/centos:centos8
MAINTAINER JB <john@globaldyne.co.uk>

ARG PHP_VER=7.4

RUN dnf -y install epel-release
RUN dnf -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm

RUN  dnf -y update 

RUN dnf -y module enable php:remi-${PHP_VER}
RUN dnf --setopt=tsflags=nodocs -y install \
	php \
	php-cli \
	php-common \
	php-xml \
	php-mysql \
	php-gd \
	php-pdo \
	php-fpm \
	php-json \
	php-mbstring \
	php-mysqlnd \
	php-pecl-zip \
	&& dnf clean all

RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
	&& echo "NETWORKING=yes" > /etc/sysconfig/network

RUN sed -i \
	-e 's~^;date.timezone =$~date.timezone = UTC~g' \
	-e 's~^upload_max_filesize.*$~upload_max_filesize = 80M~g' \
	-e 's~^post_max_size.*$~post_max_size = 120M~g' \
	-e 's~^session.auto_start.*$~session.auto_start = 1~g' \
	/etc/php.ini

ENV LANG en_GB.UTF-8


ADD start.sh /
ADD VERSION.md /

USER 10001
EXPOSE 8000
VOLUME ["/www"]
CMD ["/bin/bash", "/start.sh"]
