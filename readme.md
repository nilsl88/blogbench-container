# Blogbench - A Filesystem Benchmark for Unix (Version 1.2)

Blogbench is a portable filesystem benchmark that tries to reproduce the load of a real-world busy file server.

It stresses the filesystem with multiple threads performing random reads, writes, and rewrites to get a realistic idea of the scalability and concurrency a system can handle.

[![DockerHub](https://img.shields.io/badge/DockerHub-blue?logo=docker)](https://hub.docker.com/)
![Docker Image Size](https://img.shields.io/docker/image-size/lundberg88/blogbench/1.2?logo=docker&label=image%20size)

The architectures supported by this image are:

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| x86-64 | ✅ | \<version tag\> |
| arm64 | ✅ | \<version tag\> |
| armhf | ❌ | |


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
- **3** concurrent writers
- **1** rewriter 
- **5** commenters  
- **100** readers  
- Runs for **30 iterations**


## See Homepage

Visit the [Blogbench GitHub repository](https://github.com/jedisct1/Blogbench) for more details.
