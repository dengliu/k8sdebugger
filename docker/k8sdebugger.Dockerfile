# match base image version with k8s host node image version for kernel
# tooling compatibility reasons
FROM ubuntu:22.04

WORKDIR /root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apache2-utils \
    bash \
    bird \
    bridge-utils \
    conntrack \
    dhcping \
    file \
    fping \
    iftop \
    iperf3 \
    ipset \
    iptables \
    iptraf-ng \
    ipvsadm \
    httpie \
    jq \
    ltrace \
    mtr \
    netcat-openbsd \
    nftables \
    ngrep \
    nmap \
    openssl \
    scapy \
    socat \
    speedtest-cli \
    strace \
    tcpdump \
    tcptraceroute \
    traceroute \
    util-linux \
    git \
    gh \
    swaks \
    binutils-dev \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    httping \
    man \
    man-db \
    vim \
    screen \
    curl \
    gnupg \
    atop \
    htop \
    dstat \
    dnsutils \
    net-tools \
    ncat \
    iproute2 \
    telnet \
    psmisc \
    dsniff \
    mysql-client \
    tree \
    less \
    unzip \
    pigz \
    inotify-tools \
    rclone \
    gdb

ENTRYPOINT ["sleep", "infinity"]
