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
startDate=$( expr $(date -d $startDateTmp +'%j') + 0 )
endDate=$( expr $(date -d $endDateTmp +'%j') + 0 )

# Check day of loop.
subDateBegin=$(( $curDate-$startDate ))
subDateEnd=$(( $curDate-$endDate ))

echo "Time StartDate $startDate($subDateBegin) to EndDate $endDate($subDateEnd)"
echo "Begin"
# Directory stores data.
cd /mnt/data/data_elastic/data_1x/fimplus-log-center2/nodes/0/indices/
for ((i = "$subDateBegin"; i >= "$subDateEnd"; i--))
{
  next="$(date --date="$i days ago" +'%Y.%m.%d')"
  printf "Day : %s (%s)\n" "$next" "$i"
  tar -czf /mnt/data/backup_data_elastic/app-fa-$next.tgz app-fa-$next
}

echo "End"

    fi
  fi
fi
