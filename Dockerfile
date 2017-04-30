FROM buildpack-deps:jessie

RUN gpg --keyserver keys.gnupg.net --recv-keys \
    664C383A3566A3481B942F007A322AC6E84AFDD2

RUN set -x; \
    apt-get update \
    && apt-get install -y --no-install-recommends \
      apt-transport-https curl python-software-properties    

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -	
	
RUN echo "deb https://releases.wikimedia.org/debian jessie-mediawiki main" > /etc/apt/sources.list.d/parsoid.list

RUN set -x; \
    apt-get update \
    && apt-get install -y --force-yes --no-install-recommends \
      parsoid nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /etc/mediawiki/parsoid

VOLUME /data
EXPOSE 8000 8142

ENTRYPOINT ["/usr/bin/nodejs", "/usr/lib/parsoid/src/bin/server.js"]