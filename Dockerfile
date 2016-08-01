FROM vektory79/i386-baseimage-apache
MAINTAINER smdion <me@seandion.com>

ENV APTLIST="wget inotify-tools"

# install main packages
RUN apt-get update -q && \
apt-get install $APTLIST -qy && \

# cleanup 
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add some files 
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/service/*/finish /etc/my_init.d/*.sh

# Update apache configuration with this one
RUN a2enmod proxy proxy_http proxy_ajp rewrite deflate substitute headers proxy_balancer proxy_connect proxy_html xml2enc authnz_ldap authz_groupfile authz_host authz_user
  
# ports and volumes
EXPOSE 80 443
VOLUME /config
