FROM ubuntu:xenial
MAINTAINER TheCreatorzOne

RUN apt-get update -y && \
    apt-get install -y libmono-cil-dev && \
    apt-get install -y curl && \
    apt-get install -y mediainfo && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb http://download.mono-project.com/repo/debian jessie main" | tee /etc/apt/sources.list.d/mono-xamarin.list && \
    apt-get update -y && \
    apt-get install -y mono-devel && \
    apt-get install -y sqlite3 && \
    cd /opt && \
    curl -L -O $( curl -s https://api.github.com/repos/Radarr/Radarr/releases | grep linux.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 ) && \
    tar -xvzf Radarr.develop.*.linux.tar.gz && \
    addgroup --gid 1000 radarr && \
    adduser --uid 1000 --gid 1000 radarr && \
    chmod 4777 -R /opt/Radarr && \
    chown -R radarr /opt/Radarr && \
    ln -s /opt/Radarr /config

ADD radarr.conf /default/radarr.conf
ADD entrypoint.sh /entrypoint.sh

RUN chown -R radarr /entrypoint.sh && \
    chmod 4777 -R /entrypoint.sh

USER radarr

EXPOSE 7878

VOLUME ["/config"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["start radarr"]
