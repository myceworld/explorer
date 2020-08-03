FROM ubuntu:18.04 as base
MAINTAINER sunil@bitcoinsfacil.com

WORKDIR /home/explorer
COPY package.json package.json

# installing mongo
RUN apt-get update -y
RUN apt-get upgrade -y

# Create the default data directory
RUN mkdir -p /data/db

RUN apt-get install -y nodejs
RUN apt install -y npm

# eliminar
RUN apt-get install -y curl

RUN npm install --production

COPY . .
RUN ["chmod", "+x", "scripts/commands.sh"]

RUN echo "*/1 * * * * cd /path/to/explorer && /usr/bin/nodejs scripts/sync.js index update > /dev/null 2>&1"  >> /etc/crontabs/root
RUN echo "*/2 * * * * cd /path/to/explorer && /usr/bin/nodejs scripts/sync.js market > /dev/null 2>&1"  >> /etc/crontabs/root
RUN echo "*/5 * * * * cd /path/to/explorer && /usr/bin/nodejs scripts/peers.js > /dev/null 2>&1"  >> /etc/crontabs/root

ENTRYPOINT ["scripts/commands.sh"]
