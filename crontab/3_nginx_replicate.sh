#!/bin/bash
if [ -z "$1" ]
  then
    echo "Example: bash 0_script_standard.sh 20170701 20170715."
    echo "-Lack of Parameter #1 is YYYYMMDD(20170725)."
    echo "-Lack of Parameter #2 is YYYYMMDD(20170726)."
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

# Check day of year.
curDate=$(date +'%j')
startDate=$(date -d $startDateTmp +'%j')
endDate=$(date -d $endDateTmp +'%j')

# Check day of loop.
subDateBegin=$(( $curDate-$startDate ))
subDateEnd=$(( $curDate-$endDate ))

echo "Time StartDate $startDate($subDateBegin) to EndDate $endDate($subDateEnd)"
echo "Begin"
for ((i = "$subDateBegin"; i >= "$subDateEnd"; i--))
{
  next="$(date --date="$i days ago" +'%Y.%m.%d')"
  printf "Day : %s (%s)\n" "$next" "$i"
  curl -XPUT localhost:9200/log-nginx-$next/_settings -d '{ "index" : { "number_of_replicas" : 0 }}'
}

echo "End"

    fi
  fi
fi
