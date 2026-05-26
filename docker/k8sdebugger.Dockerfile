# ---- Stage 1: build Go-based tooling ----
# Uses the official Go image (multi-arch aware) so we don't need to manage the
# Go toolchain ourselves. Only the compiled binaries are copied into the final
# image, keeping module/build caches and the Go SDK out of the runtime layer.
# natscli >= v0.4.0 requires Go >= 1.25, so use a 1.25.x builder image.
FROM golang:1.25 AS go-tools

RUN go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest && \
    go install github.com/nats-io/natscli/nats@latest && \
    go install github.com/nats-io/nsc/v2@latest && \
    go install github.com/nats-io/nkeys/nk@latest && \
    go install github.com/nats-io/nats-top@latest && \
    go install github.com/solidpulse/natsdash@latest

# ---- Stage 2: final debugger image ----
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
    wget \
    && rm -rf /var/lib/apt/lists/*

# Copy Go-built tools from the builder stage. Binaries live in /go/bin in the
# official golang image.
# - grpcurl: gRPC over HTTP/2 CLI (https://github.com/fullstorydev/grpcurl)
# - NATS tools (https://docs.nats.io/using-nats/nats-tools):
#     nats     - primary NATS CLI (pub/sub, request/reply, JetStream, KV, bench)
#     nsc      - NATS account/user/JWT configuration
#     nk       - NKey (Ed25519) key generation/signing
#     nats-top - top-style monitoring view for a NATS server
#     natsdash - tview-based TUI dashboard for NATS/JetStream
#                (https://github.com/solidpulse/natsdash)
COPY --from=go-tools /go/bin/grpcurl  /usr/local/bin/grpcurl
COPY --from=go-tools /go/bin/nats     /usr/local/bin/nats
COPY --from=go-tools /go/bin/nsc      /usr/local/bin/nsc
COPY --from=go-tools /go/bin/nk       /usr/local/bin/nk
COPY --from=go-tools /go/bin/nats-top /usr/local/bin/nats-top
COPY --from=go-tools /go/bin/natsdash /usr/local/bin/natsdash

# Keep the container alive by default so it can be `kubectl exec`'d into.
# Using CMD (not ENTRYPOINT) so it's trivially overridable:
#   docker run --rm -it k8sdebugger bash
#   kubectl run dbg --image=k8sdebugger -it -- bash
# or via a pod-spec `command:`/`args:`.
CMD ["sleep", "infinity"]
