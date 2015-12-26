# docker-onetimesecret

Docker container for [One-Time Secret](http://onetimesecret.com)

## Build

build and run it as a user with docker priveleges.

```bash
$ docker build -t onetimesecret .
```


```bash
$ docker run --name=ots -p 7143:7143 -t onetimesecret
```

Access it through your browser at `http://dockerhost.domain.com:7143`

## Configuration

By default it is pointed to localhost and any links will show this.
If you run a public server, you should setup `/etc/onetime` as a host directory volume, update your configuration, and restart the container.

```bash
$ docker run -d --name=ots -p 7143:7143 -v /data/etc-onetime:/etc/onetime onetimesecret
```

## WIP - Persistent Data

If you want the data to remain consistant between upgrades, you should also add data volume container.

```bash
$ docker run -d --name=ots-data -v /data/somepath onetimesecret /bin/true
$ docker run -d --volumes-from=ots-data -v /data/etc-onetime:/etc/onetime --name=ots -p 7143:7143 -t onetimesecret
```
