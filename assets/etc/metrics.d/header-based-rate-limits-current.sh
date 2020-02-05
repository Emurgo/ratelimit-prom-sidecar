#!/bin/bash

REDIS_URI=${REDIS_URI:-redis://localhost:6379/}
redis-cli -u $REDIS_URI KEYS "ratelimit:*" | while read key; do echo "$(redis-cli -u ${REDIS_URI} GET "$key") - $key" ; done | while read ratelimit
do
  HIT_COUNT=$( if [ -n $(echo ${ratelimit} | awk '{print $1}') ]; then echo 0; fi ) 
  RATE_LIMIT=$(echo ${ratelimit} | sed -e 's|.*ratelimit:\(.*\)|\1|g' -e 's|[()/\.,; ]|_|g')
  echo ratelimit_${RATE_LIMIT} ${HIT_COUNT}
done
