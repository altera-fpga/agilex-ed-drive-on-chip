#!/bin/bash
echo 4 > /proc/irq/53/smp_affinity
taskset -c 2 /opt/hpssafechannel/hpssafechannel
