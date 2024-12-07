# Blogbench - A Filesystem Benchmark for Unix (Version 1.2)

Blogbench is a portable filesystem benchmark that tries to reproduce the load of a real-world busy file server.

It stresses the filesystem with multiple threads performing random reads, writes, and rewrites to get a realistic idea of the scalability and concurrency a system can handle.


## Docker Image
```bash
# Stage 1: Builde
FROM ubuntu:24.04 AS builder
ENV DEBIAN_FRONTEND=noninteractive
ENV BLOGBENCH_URL=https://download.pureftpd.org/pub/blogbench
ENV BLOGBENCH_VERSION=1.2
RUN apt-get update && apt-get -y dist-upgrade && apt-get install -y build-essential wget curl
RUN cd /tmp/ && curl -L $BLOGBENCH_URL/blogbench-$BLOGBENCH_VERSION.tar.gz | tar -xz
RUN cd /tmp/blogbench-$BLOGBENCH_VERSION && arch="$(uname -m)" && export arch && ./configure --build="${arch}" && make install-strip

# Stage 2: Final
FROM ubuntu:24.04
MAINTAINER lundberg88
WORKDIR /root
COPY --from=builder /usr/local/bin/blogbench /usr/local/bin/blogbench
COPY ./run.sh /root
CMD ["/bin/bash"]
ENTRYPOINT ["/root/run.sh"]
```

### Sample Usage

```bash
docker run --rm \
    -v `pwd`:/root/results \
    lundberg88/blogbench:1.2 \
    /tmp /root/results/output.prof
```

## Available Options
```bash
--commenters=<n> (-c <n>): number of comments posters
--help (-h): usage
--iterations=<n> (-i <n>): number of iterations
--readers=<n> (-r <n>): number of writers
--rewriters=<n> (-W <n>): number of rewriters
--sleep=<secs> (-s <secs>): delay after every iteration
--writers=<n> (-w <n>): number of writers
```
By default:
- **3 concurrent writers**  
- **1 rewriter**  
- **5 commenters**  
- **100 readers**  
- Runs for **30 iterations**.


## See Homepage

Visit the [Blogbench GitHub repository](https://github.com/jedisct1/Blogbench) for more details.
