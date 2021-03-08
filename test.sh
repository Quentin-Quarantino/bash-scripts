#!/bin/bash

d=`date '+%H%M%S'`
p='/home/rick/testout/'
while true ;do d=`date '+%H%M%S'`; p='/home/rick/testout/' ; touch $p$d ;sleep 1m ;done

