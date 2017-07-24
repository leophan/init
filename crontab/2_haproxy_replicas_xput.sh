#!/bin/bash

echo "Begin"

for i in {1..29}
do
   yes="$(date  --date="$i days ago" +'%Y.%m.%d')"
   printf "Yesterday for yyyy.mm.dd format: %s\n" "$yes"

   curl -XPUT localhost:9200/haproxy-$yes/_settings -d '{ "index" : { "number_of_replicas" : 0 }}'
  
done

yes30="$(date  --date="30 days ago" +'%Y.%m.%d')"
printf "Yesterday for yyyy.mm.dd format: %s\n" "$yes30"

curl -XDELETE localhost:9200/haproxy-$yes30

echo "End"
