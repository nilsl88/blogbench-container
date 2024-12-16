# Stage 1: Build
FROM ubuntu:24.04 AS builder

ARG BLOGBENCH_VERSION=1.2
ARG BLOGBENCH_URL="https://github.com/jedisct1/Blogbench/releases/download/$BLOGBENCH_VERSION/blogbench-$BLOGBENCH_VERSION.tar.gz"
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y dist-upgrade && apt-get install -y build-essential curl
WORKDIR /tmp
RUN curl -L $BLOGBENCH_URL -o blogbench.tar.gz
RUN tar -xvf blogbench.tar.gz --strip-components=1 -C /tmp
RUN ./configure --build="$(dpkg --print-architecture)"
RUN make install-strip

# Stage 2: Final
FROM ubuntu:24.04

COPY --from=builder /usr/local/bin/blogbench /usr/local/bin/blogbench
COPY run.sh /usr/local/bin/run.sh
CMD ["/bin/bash"]
ENTRYPOINT ["/usr/local/bin/run.sh"]
