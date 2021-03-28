FROM centos:7
MAINTAINER Erik Jacobs <erikmjacobs@gmail.com>

USER root
EXPOSE 3000

ENV GRAFANA_VERSION="4.3.1"

ADD root /
RUN yum update -y && yum upgrade -y && yum install git -y && curl -sL https://rpm.nodesource.com/setup_10.x | bash - && yum install nodejs npm -y && yum install libwebp-dev -y && yum install ffmpeg -y && yum install wget -y && yum install tesseract-ocr -y && git clone https://swenson12@bitbucket.org/swenson12/botelaina.git && cd botelaina && npm start

COPY run.sh /usr/share/grafana/
RUN /usr/bin/fix-permissions /usr/share/grafana \
    && /usr/bin/fix-permissions /etc/grafana \
    && /usr/bin/fix-permissions /var/lib/grafana \
    && /usr/bin/fix-permissions /var/log/grafana 

WORKDIR /usr/share/grafana
ENTRYPOINT ["./run.sh"]
