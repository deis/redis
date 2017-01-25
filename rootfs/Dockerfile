FROM quay.io/deis/base:v0.3.6

COPY . /

RUN apt-get update && \
    apt-get install -y --no-install-recommends redis-server && \
    # cleanup
    apt-get clean -y && \
    # package up license files if any by appending to existing tar
    COPYRIGHT_TAR='/usr/share/copyrights.tar'; \
    gunzip $COPYRIGHT_TAR.gz; tar -rf $COPYRIGHT_TAR /usr/share/doc/*/copyright; gzip $COPYRIGHT_TAR && \
    rm -rf \
        /usr/share/doc \
        /usr/share/man \
        /usr/share/info \
        /usr/share/locale \
        /var/lib/apt/lists/* \
        /var/cache/debconf/* \
        /usr/lib/x86_64-linux-gnu/gconv/IBM* \
        /usr/lib/x86_64-linux-gnu/gconv/EBC* && \
    bash -c "mkdir -p /usr/share/man/man{1..8}" && \
    chown -R redis:redis /etc/redis /var/lib/redis /var/log/redis

USER redis
WORKDIR /var/lib/redis

CMD ["/bin/boot"]
EXPOSE 6379
