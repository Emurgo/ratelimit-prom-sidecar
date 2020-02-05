FROM emurgornd/bashttpd-prom-sidecar:latest

ENV REDIS_URI redis://localhost:6379

RUN apt-get update -qq && \
    apt-get install -y redis-tools && \
    apt-get clean

ADD ./assets /assets
RUN chown -R nobody: /assets
