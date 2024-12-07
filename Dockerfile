# Stage 1: Builder
FROM --platform=$TARGETPLATFORM ubuntu:24.04 AS builder
ENV DEBIAN_FRONTEND=noninteractive
ENV BLOGBENCH_URL=https://download.pureftpd.org/pub/blogbench
ENV BLOGBENCH_VERSION=1.2

# Install build dependencies
RUN apt-get update && apt-get -y dist-upgrade && \
    apt-get install -y build-essential curl

# Add architecture-specific handling
RUN case "$TARGETPLATFORM" in \
    "linux/amd64") ARCH="x86_64" ;; \
    "linux/arm64") ARCH="aarch64" ;; \
    *) echo "Unsupported platform: $TARGETPLATFORM" && exit 1 ;; \
    esac && \
    cd /tmp/ && \
    curl -L "$BLOGBENCH_URL/blogbench-$BLOGBENCH_VERSION.tar.gz" | tar -xz && \
    cd "blogbench-$BLOGBENCH_VERSION" && \
    ./configure --build="$ARCH-unknown-linux-gnu" && \
    make && \
    make install-strip

# Stage 2: Final
FROM --platform=$TARGETPLATFORM ubuntu:24.04
WORKDIR /root
COPY --from=builder /usr/local/bin/blogbench /usr/local/bin/blogbench
COPY ./run.sh /root/run.sh
CMD ["/bin/bash"]
ENTRYPOINT ["/root/run.sh"]
