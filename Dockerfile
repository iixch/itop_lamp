FROM centos:7.6.1810 
MAINTAINER SANGFOR_ITop_lamp_v3
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-*
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm 
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
RUN yum install -y \
    php56w php56w-opcache \
    php56w-xml php56w-mcrypt \
    php56w-gd php56w-devel \
    php56w-mysql php56w-intl \
    php56w-mbstring php56w-fpm \
    &>/dev/null 

RUN yum install  -y \
    php56w-mysql php56w-gd \
    libjpeg* php56w-ldap \
    php56w-odbc php56w-pear \
    php56w-xml php56w-xmlrpc \
    php56w-mbstring \
    php56w-bcmath php56w-soap \
    php56w-mhash \
    &>/dev/null

RUN yum install -y \
    gcc httpd  graphviz iproute \
    &>/dev/null


RUN sed -i "s/Options Indexes FollowSymLinks/Options Includes ExecCGI FollowSymLinks/g"  /etc/httpd/conf/httpd.conf 
RUN sed -i "s/#AddHandler cgi-script .cgi/AddHandler cgi-script .cgi .pl/g" /etc/httpd/conf/httpd.conf 
RUN sed -i "s/AllowOverride None/AllowOverride All/g" /etc/httpd/conf/httpd.conf
RUN sed -i "s/#ServerName www.example.com:80/ServerName localhost:80/g"  /etc/httpd/conf/httpd.conf
RUN /usr/sbin/httpd 

ADD httpd.sh /httpd.sh
RUN chmod +x /httpd.sh

EXPOSE 80
CMD ["/httpd.sh"]
