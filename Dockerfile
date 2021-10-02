# Stabila Quickstart

#FROM sullof/ubu18jdk8node10redis
LABEL maintainer="Vincenzo Gotti <vingotti@gmail.com>"

# Prepare the work directory
RUN mkdir -p stabila/conf
WORKDIR /stabila

# Install proxy dependencies
RUN mkdir /stabila/app
ADD app/package.json /stabila/app/package.json
RUN cd app && npm install

# Configures full node
RUN mkdir FullNode
ADD conf/full.conf FullNode/fullnode.conf
ADD conf/FullNode.jar FullNode/FullNode.jar

RUN mkdir BlockParser
ADD conf/run.sh BlockParser/run.sh
ADD conf/BlockParser.jar BlockParser/BlockParser.jar

RUN mkdir evenstabila
ADD conf/process.json evenstabila/process.json
ADD conf/evenstabila evenstabila/evenstabila

# Separating install from src speeds up the rebuilding
# if the node app is changed, but has the ADD app/version

ADD app/index.js app/index.js
ADD app/version.js app/version.js
ADD app/src app/src
ADD scripts scripts
RUN chmod +x scripts/accounts-generation.sh

ADD stabilaWeb stabilaWeb
RUN chmod +x stabilaWeb

ADD pre-approve.sh pre-approve.sh
ADD quickstart.sh quickstart
RUN chmod +x quickstart

CMD ["./quickstart", "v2.1.1"]