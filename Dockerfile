
FROM ubuntu:16.04
MAINTAINER Moe Adham <moe@bitaccess.co>

# Install base dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        libudev-dev \
        python \
        rsync \
        software-properties-common \
        git-core \
        wget \
        libzmq3-dev \
        vim \
    && rm -rf /var/lib/apt/lists/*

# Install geth

RUN add-apt-repository -y ppa:ethereum/ethereum && apt-get update && apt-get install -y -q ethereum && echo "VERSION 1.8.11"

# docker run --name=gethdata -v /gethdata busybox chown 1000:1000 /gethdata
RUN mkdir /gethdata
EXPOSE 30303 8541 8542
ENTRYPOINT ["geth", \
            "--port", "30303", \
            "--rpc", \
            "--rpcaddr", "0.0.0.0", \
            "--rpcport", "8541", \
            "--rpcapi", "eth,net,web3", \
            "--rpccorsdomain", "*", \
            "--ws", \
            "--wsaddr", "0.0.0.0", \
            "--wsport", "8542", \
            "--wsapi", "web3,eth,pubsub,net", \
            "--wsorigins", "*", \
            "--datadir", "/gethdata", \
            "--txpool.journal", "72h0m0s", \
            "--txpool.pricelimit", "0", \
            "--txpool.accountslots", "429496729",\
            "--txpool.globalslots", "4294967295",\
            "--txpool.accountqueue", "429496729", \
            "--txpool.globalqueue", "4294967295", \
            "--txpool.lifetime", "72h0m0s", \
            "--cache", "8000", \
            "--syncmode", "fast"]
