#!/bin/sh

    nohup ./run_jmetertestscripts.sh 2>&1 > ./run_logs/run_$(date '+%Y%m%d_%H%M%S').log &
