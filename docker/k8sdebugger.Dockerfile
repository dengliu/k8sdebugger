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
    gdb \
    wget

# Install Go 1.23 (newer version required for grpcurl dependencies)
# Use TARGETARCH to download the correct architecture
ARG TARGETARCH
RUN GOARCH=${TARGETARCH} && \
    wget -q https://go.dev/dl/go1.23.4.linux-${GOARCH}.tar.gz && \
    tar -C /usr/local -xzf go1.23.4.linux-${GOARCH}.tar.gz && \
    rm go1.23.4.linux-${GOARCH}.tar.gz

ENV GOPATH=/root/go
ENV PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

RUN go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest

ENTRYPOINT ["sleep", "infinity"]
