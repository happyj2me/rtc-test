#!/bin/bash

if [ $# != 2 ]
then
    echo "Usage: $0 devname {rate|off|list} ex: ./rate-limit.sh eth0 500Kbit  or ./rate-limit.sh eth0 off"
    exit 1
fi

if [ $2 == 'off' ]
then
    echo "clear rate limit for dev $1"
    sudo tc qdisc del dev $1 root
elif [ $2 == 'list' ]
then
    echo "list rate limit for dev $1"
    sudo tc class show dev $1
else
    echo "add rate limit for dev $1,rate $2"
    sudo tc qdisc add dev $1 root handle 1: htb default 11
    sudo tc class add dev $1 parent 1: classid 1:11 htb rate $2 ceil $2
fi
