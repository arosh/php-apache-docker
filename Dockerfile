FROM php:5.6.40-apache-stretch
COPY setup-user /usr/local/bin/
CMD ["setup-user"]
