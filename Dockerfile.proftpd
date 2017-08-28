FROM debian:9

RUN \
	apt-get update -y && \
	apt-get install -y proftpd proftpd-mod-mysql && \
	apt-get clean autoclean && \
	apt-get autoremove --yes && \
	pwd

RUN \
	ln -sf /dev/stdout /var/log/proftpd/xferlog; \
	ln -sf /dev/stderr /var/log/proftpd/proftpd.log 
	

COPY proftpd.conf /etc/proftpd/proftpd.conf
EXPOSE 20 21 20020-20080
ENV PROFTPD_VISIBLE_HOSTNAME='proftpd-in-a-box' \
    PROFTPD_SHOW_ADDRESS=127.0.0.1 \
    PROFTPD_MYSQL_DB=proftp \
    PROFTPD_MYSQL_HOST=mysql \
    PROFTPD_MYSQL_USER=proftp \
    PROFTPD_MYSQL_PASSWORD=proftp \
    PROFTPD_USER_ID=800 \
    PROFTPD_GROUP_ID=800 

CMD ["/usr/sbin/proftpd", "--nodaemon"]
