#!/usr/bin/env bash
FILENAME=cascade-server
PID_FILENAME=cascade-server.pid
sleep_time=10
abs_path=$(cd `dirname $0` && pwd)
pid=${abs_path}/${PID_FILENAME}
pid_num=$(cat ${pid})

echo "Shutting down '${FILENAME}' application using '${pid_num}' PID number..."
kill -15 ${pid_num}
sleep ${sleep_time}

if ps -p ${pid_num} > /dev/null 2>&1; then
kill -9 ${pid_num} && rm -f ${pid}

if ps -p ${pid_num} > /dev/null 2>&1; then
echo "ERROR: Unable to stop '${FILENAME}' application using '${pid_num}' PID number, check/kill manually and remove PID file ${pid}"
exit 1
fi
else
rm -f ${pid}
echo "'${FILENAME}' application stopped successfully!"
fi
