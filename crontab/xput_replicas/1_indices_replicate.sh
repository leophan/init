#!/bin/bash
if [ -z "$1" ]
  then
    echo "Example: bash 0_script_standard.sh 20170701 20170715."
    echo "-Lack of Parameter #1 is YYYYMMDD(20170701)."
    echo "-Lack of Parameter #2 is YYYYMMDD(20170715)."
    echo "-Lack of Parameter #3 is log-nginx, vmx, streamsession, radosgw, mbfha, log-nginx, haproxy, errorhandling, drmtoday, app-fa."
else
  if [ -z "$2" ]
    then
      echo "-Lack of Parameter #2 is YYYYMMDD(20170726)."
  else
    if [ "$1" -gt "$2" ]
      then
        echo "-Parameter #2 more than Parameter #1."
    else
# Args
startDateTmp=$1
endDateTmp=$2
indices=$3

# Check day of year.
curDate=$(date +'%j')
startDate=$( expr $(date -d $startDateTmp +'%j') + 0 )
endDate=$( expr $(date -d $endDateTmp +'%j') + 0 )

# Check day of loop.
subDateBegin=$(( $curDate-$startDate ))
subDateEnd=$(( $curDate-$endDate ))

echo "Time StartDate $startDate($subDateBegin) to EndDate $endDate($subDateEnd)"
echo "Begin"
for ((i = "$subDateBegin"; i >= "$subDateEnd"; i--))
{
  next="$(date --date="$i days ago" +'%Y.%m.%d')"
  printf "Day : %s (%s)\n" "$next" "$i"
  curl -XPUT localhost:9200/$indices-$next/_settings -d '{ "index" : { "number_of_replicas" : 0 }}'
}

echo "End"

    fi
  fi
fi
