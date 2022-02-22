while true
do
 x=0
  while [ $x -le 100 ]
   do
   date=`date`
   msg=$date" app_state="$RANDOM
   echo $msg | tee -a /logs/log.txt
   x=$(( $x+1 ))
   sleep 1
  done
 echo "rotating file"
cat /dev/null > /logs/log.txt
done

