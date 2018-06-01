FROM ubuntu:18.04
MAINTAINER TheCreatorzOne

ENV DEBIAN_FRONTEND noninteractive

RUN useradd -m radarr && \
    apt-get update -y && \
    apt-get install -y libmono-cil-dev && \
    apt-get install -y curl && \
    apt-get install -y wget gnupg && \
    apt-get install -y mediainfo && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb http://download.mono-project.com/repo/debian jessie main" | tee /etc/apt/sources.list.d/mono-xamarin.list && \
    apt-get update -y && \
    apt-get install -y mono-devel && \
    apt-get install -y sqlite3 && \
    cd /opt && \
    curl -L -O $( curl -s https://api.github.com/repos/Radarr/Radarr/releases | grep linux.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 ) && \
    tar -xvzf Radarr.develop.*.linux.tar.gz && \
    chown -R radarr /opt/Radarr && \
    chmod -R 0775 /opt/Radarr && \
    ln -s /opt/Radarr /config && \
    mkdir -p /etc/systemd/system

ADD radarr.service /etc/systemd/system/radarr.service

RUN chown -R radarr /etc/systemd/system/radarr.service && \
    chmod -R 0775 /etc/systemd/system/radarr.service && \
    systemctl enable radarr.service && \

USER radarr

EXPOSE 7878

VOLUME ["/config"]

CMD ["systemctl start radarr.service"]
