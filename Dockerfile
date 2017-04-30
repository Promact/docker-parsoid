FROM node:latest

# Install Git
RUN set -x; \
    apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

RUN git clone -b https://gerrit.wikimedia.org/r/p/mediawiki/services/parsoid \
  /usr/src/parsoid \
  && (cd /usr/src/parsoid && npm install)

WORKDIR /usr/src/parsoid/api

# generate localsettings.js
RUN sed "s|'http://localhost/w|process.env.MW_URL + '|" < localsettings.example.js > localsettings.js

EXPOSE 8000
CMD ["node","/usr/src/parsoid/api/server.js"]