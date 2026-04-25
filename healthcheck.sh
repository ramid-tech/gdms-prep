#!/bin/bash

LOGFILE="$HOME/scripts/healthcheck.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')
echo "The date is $DATE"


check_disk() {
	disk=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
	if [ $disk -gt 50 ]; then
		echo "[$DATE] Warning: Disk at $disk%" | tee -a $LOGFILE
	else
		echo "[$DATE] Ok: Disk at $disk%" | tee -a $LOGFILE
	fi
}


check_services() {
	services=("sshd" "firewalld" "chronyd")
	for service in "${services[@]}"
	do
		if systemctl is-active --quiet $service; then
			echo "[$DATE] Ok: $service is running" | tee -a $LOGFILE
		else
			echo "[$DATE] Warning: $service is not running" | tee -a $LOGFILE
		fi
	done
}

echo "===== Health Check ====="
check_disk
check_services
echo "===== Complete ====="


