#!/bin/sh
#
# chkconfig: 2345 55 25
# Description: ng-backend
#
### BEGIN INIT INFO
# Provides:          ng-backend
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: ng-backend init.d script
# Description:       ng-backend
### END INIT INFO
#

PATH=/usr/local/go/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DESC="ng-backend Daemon"
NAME=ng_backend
LOCATION={{ apps.backend.location }}
PID=/var/run/ng_backend.pid
SCRIPT=/etc/init.d/$NAME
export GOPATH=/srv/go

do_start() {
    if [ -f $PID ]; then
        echo -e "\033[33m $PID already exists. \033[0m"
        echo -e "\033[33m $DESC is already running or crashed. \033[0m"
    else
        echo -e "\033[32m $DESC Starting $CONF ... \033[0m"
        if [ -f /var/log/ng_backend.log ]; then
        	mv /var/log/ng_backend.log /var/log/ng_backend.`date +%s`.log
        fi
        cd $LOCATION
        nohup go run main.go 2>&1 > /var/log/ng_backend.log &
        echo $! > $PID
        sleep 1
        echo -e "\033[36m $DESC started. \033[0m"
    fi
}

do_stop() {
    if [ ! -f $PID ]; then
        echo -e "\033[33m $PID doesn't exist. \033[0m"
        echo -e "\033[33m $DESC isn't running. \033[0m"
    else
        echo -e "\033[32m $DESC Stopping $CONF ... \033[0m"
        kill $(cat $PID)
        rm $PID
        sleep 1
        echo -e "\033[36m $DESC stopped. \033[0m"
    fi
}

case "$1" in
 start)
 do_start
 ;;
 stop)
 do_stop
 ;;
 restart)
 do_stop
 do_start
 ;;
 *)
 echo "Usage: $SCRIPT {start|stop|restart}"
 exit 2
 ;;
esac

exit 0