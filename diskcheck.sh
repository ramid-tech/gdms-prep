#!/bin/bash

disk=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

if  [ $disk -gt 50 ]; then
	echo "WARNING: Disk at $disk%"
else
	echo "OK: Disk at $disk%"
fi

