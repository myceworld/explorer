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

ENTRYPOINT ["scripts/commands.sh"]
