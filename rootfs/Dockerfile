FROM quay.io/deis/base:0.3.0

COPY . /

RUN apt-get update \
	&& apt-get install -y redis-server \
	--no-install-recommends \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man /usr/share/doc \
	&& chown -R redis:redis /etc/redis /var/lib/redis /var/log/redis

USER redis
WORKDIR /var/lib/redis

CMD ["/bin/boot"]
EXPOSE 6379
