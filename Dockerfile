# Stage 1: Builde
FROM ubuntu:24.04 AS builder
ENV DEBIAN_FRONTEND=noninteractive
ENV BLOGBENCH_URL=https://download.pureftpd.org/pub/blogbench
ENV BLOGBENCH_VERSION=1.2
RUN apt-get update && apt-get -y dist-upgrade && apt-get install -y build-essential curl
RUN cd /tmp/ && curl -L $BLOGBENCH_URL/blogbench-$BLOGBENCH_VERSION.tar.gz | tar -xz -C /tmp && \
    cd /tmp/blogbench-$BLOGBENCH_VERSION && arch="$(dpkg --print-architecture)" && \
    export arch && ./configure --build="${arch}" && make install-strip

# Stage 2: Final
FROM ubuntu:24.04
MAINTAINER lundberg88
WORKDIR /root
COPY --from=builder /usr/local/bin/blogbench /usr/local/bin/blogbench
COPY ./run.sh /root/run.sh
CMD ["/bin/bash"]
ENTRYPOINT ["/root/run.sh"]
