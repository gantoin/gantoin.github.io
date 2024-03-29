title=How to run 'landoop/fast-data-dev' on Mac M1?
date=2023-01-19T16:20:55Z
type=post
tags=blog, docker, arm
status=published
~~~~~~

Hey guys!

I was following a lecture about Kafka Schema Registry when I suddenly had to run Landoop and a bunch of tools with Docker on my Mac.

I met this error after running this [Dockerfile](https://github.com/lensesio/fast-data-dev/blob/fdd/main/Dockerfile):

```
Setting advertised host to 127.0.0.1.
runtime: failed to create new OS thread (have 2 already; errno=22)
fatal error: newosproc
```

After a few minutes of searching, I understood that's because I ran it on my M1 arm chip. So, I'll have to find an ARM version of these programs.

This it! I found this [Dockerfile](https://github.com/lensesio/fast-data-dev/pull/185) which can help you to run easily on your fabulous Mac M1:

```
FROM golang:bullseye as compile-lkd
MAINTAINER Marios Andreopoulos <marios@landoop.com>

RUN apt-get update \
    && apt-get install -y \
         unzip \
         wget \
	 file \
    && rm -rf /var/lib/apt/lists/* \
    && echo "progress = dot:giga" | tee /etc/wgetrc \
    && mkdir -p /mnt /opt /data \
    && go install github.com/andmarios/duphard@latest \
    && go install gitlab.com/andmarios/checkport@latest \
    && go install github.com/andmarios/quickcert@latest \
    && ln -s  /go/bin/duphard /bin/duphard
...
```

So, the easiest to do is to go on your `Docker for Mac` software and click on `Search` & search `dougdonohoe/fast-data-dev` :

![https://raw.githubusercontent.com/gantoin/gantoin.github.io/master/assets/images/blog_content/screenshot-docker.png](https://raw.githubusercontent.com/gantoin/gantoin.github.io/master/assets/images/blog_content/screenshot-docker.png)

After the image is pulled, get on the `Images` tab and run it with exposed port `-p 3030:3030`, something like:

```bash
docker run --hostname=912d813335a8 --env=PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin --env=LANG=en_US.UTF-8 --env=LANGUAGE=en_US.UTF-8 --env=LC_ALL=en_US.UTF-8 --volume=/data --workdir=/ --runtime=runc -d --add-host host.docker.internal:host-gateway -p 3030:3030 --name=web dougdonohoe/fast-data-dev:latest
```

And it's done, enjoy Kafka Schema Registry!

P.S: the tool `kafka-avro-console-producer` will be able to use in the container.
