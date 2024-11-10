#!/bin/bash
MONITOR=$(polybar -m|tail -1|sed -e 's/:.*$//g')
pkill polybar
polybar -r main &
