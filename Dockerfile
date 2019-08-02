FROM ubuntu:18.04 as base
MAINTAINER sunil@bitcoinsfacil.com

WORKDIR /home/explorer
COPY package.json package.json

# installing mongo
RUN apt-get update -y
RUN apt-get upgrade -y
################## BEGIN INSTALLATION ######################
# Install MongoDB Following the Instructions at MongoDB Docs
# Ref: http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

# Add the package verification key
RUN apt install -y mongodb
RUN apt-get install gnupg -y
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

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
#ENTRYPOINT ["tail", "-f", "/dev/null"]
