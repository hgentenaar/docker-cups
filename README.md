# docker-cups
Docker image in alpine serving cups printserver 

## Docker
You need docker to run this container:
[install Docker](https://docs.docker.com/engine/installation/) 

## running the container:
```
docker run \
        --name cups -p 631:631 \
        -v /opt/cups/config:/etc/cups \
        -v /opt/cups/log:/var/log/cups \
        -v /opt/cups/spool:/var/spool/cups \
        -v /opt/cups/cache:/var/cache/cups \
        --privileged -v /dev/bus/usb:/dev/bus/usb \
        -e "CUPS_ADMIN=print" -e "CUPS_ADMIN_PASS=print" \
        -d --restart unless-stopped \
        cups
```
