#!/bin/bash

echo "Begin"

for i in {1..6}
do
   yes="$(date  --date="$i days ago" +'%Y.%m.%d')"
   printf "Yesterday for yyyy.mm.dd format: %s\n" "$yes"

   curl -XPUT localhost:9200/radosgw-$yes/_settings -d '{ "index" : { "number_of_replicas" : 0 }}'
  
done

yes7="$(date  --date="7 days ago" +'%Y.%m.%d')"
printf "Yesterday for yyyy.mm.dd format: %s\n" "$yes7"

curl -XDELETE localhost:9200/radosgw-$yes7

echo "End"
