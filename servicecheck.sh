#!/bin/bash

services=("sshd" "firewalld" "chronyd")

for service in "${services[@]}"
do
	if systemctl is-active --quiet $service; then
		echo "OK: $service is running"
	else
		echo "WARNING: $serice is NOT running"
	fi
done



