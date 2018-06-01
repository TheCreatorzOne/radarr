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
    apt-get install -y systemd && \
    cd /opt && \
    wget https://github.com/Radarr/Radarr/releases/download/v0.2.0.1067/Radarr.develop.0.2.0.1067.linux.tar.gz && \
    tar -xf Radarr* -C /opt/ && \
    chown -R radarr /opt/Radarr && \
    chmod -R 0775 /opt/Radarr && \
    ln -s /opt/Radarr /config && \
    cd /opt/Radarr

USER radarr

EXPOSE 7878

VOLUME ["/config"]

CMD ["--debug /opt/Radarr/Radarr.exe -nobrowser"]
