As described in [Running as an arbitrary user](https://hub.docker.com/_/php), `--user` is All You Need.

```shell
docker run --rm -p 8080:80 -v $(pwd):/var/www/html --user 1234:2345 --sysctl net.ipv4.ip_unprivileged_port_start=0 php:5.6.40-apache-stretch
```

# php-apache-docker

~~Run PHP + Apache with the specified UID/GID at runtime~~

## Usage

```shell
# Create tmpdir
cd $(mktemp -d)

# Allow users to place files
chmod 777 .

# Place a toy page
cat > index.php <<"EOF"
<?php
$date = new DateTime("now", new DateTimeZone("UTC"));
$handle = fopen("datetime.txt", "w");
fwrite($handle, $date->format(DateTime::ATOM) . "\n");
fclose($handle);
EOF

# Run PHP + Apache server with UID of 1234 and GID of 2345
docker run --rm -p 8080:80 -v $(pwd):/var/www/html -e APACHE_UID=1234 -e APACHE_GID=2345 quay.io/arosh/php:5.6.40-apache-stretch

# From another shell
# Send a request
curl -i localhost:8080

# Return to an original shell
# List files with numeric UID/GID
ls -ln
```

You can see datetime.txt is created with the UID/GID you specified at runtime.

```text
/tmp/tmp.sGBXE3D3gu$ ls -ln
total 8
-rw-r--r-- 1 1234 2345  26 Apr 15 17:02 datetime.txt
-rw-rw-r-- 1 1000 1000 170 Apr 15 17:02 index.php
/tmp/tmp.sGBXE3D3gu$
```
