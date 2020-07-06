FROM alpine

# Set metadata
LABEL maintainer="Hubert Gentenaar https://github.com/hgentenaar/"
LABEL version="0.0"
LABEL description="Alpine container serving CUPS"

#Localisation
ENV LANG en_US.UTF-8

#install packages
RUN apk add --no-cache cups


#Copy Files
COPY root/start_cups.sh /root/start_cups.sh
RUN chmod +x /root/start_cups.sh 

VOLUME /etc/cups/ /var/log/cups /var/spool/cups /var/cache/cups


ENV CUPS_ADMIN=print CUPS_ADMIN_PASSWORD=print


EXPOSE 631

CMD ["/root/start_cups.sh"]
