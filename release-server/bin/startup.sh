#!/usr/bin/env bash
FILENAME=cascade-server
PID_FILENAME=cascade-server.pid
abs_path=$(cd `dirname $0` && pwd)
pid=${abs_path}/${PID_FILENAME}
opts="-Xms256m -Xmx256m"
  
if [ -f ${pid} ]; then
      echo "'${FILENAME}' application seems to be already running. Attempting shutdown..."
      sh ${abs_path}/shutdown.sh
fi
echo "Starting '${FILENAME}' application..."

cd ${abs_path}/..
java -jar ${abs_path}/${FILENAME}.jar ${opts} </dev/null >/dev/null 2>&1 & echo $! > ${pid}

pid_num=$(cat ${pid})
end=$((SECONDS+300))
check_interval=10
while [ $SECONDS -lt ${end} ]; do
    res=$(netstat -nlp 2>/dev/null | grep "${pid_num}/java");
    if [[ ! -z ${res} ]]; then
        echo "'${FILENAME}' application started successfully!";
        exit 0;
    fi
    sleep ${check_interval}
done
  
exit 1
