FROM ubuntu:latest

MAINTAINER Chuyen Pham <pkchuyen@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y pdns-server pdns-backend-mysql && \
# Clean up APT when done.
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


EXPOSE 53/tcp
EXPOSE 53/udp
EXPOSE 8081/tcp

ADD db/pdns.sql /

ADD script/start.sh /
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
