#!/bin/bash

echo "STARTING redis-server"
redis-server /etc/onetime/redis.conf

echo "STARTING onetimesecret"
cd /var/lib/onetime && bundle exec thin -e dev -R config.ru -p 7143 start
