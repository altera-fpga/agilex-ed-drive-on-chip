#!/bin/bash
echo 4 > /proc/irq/37/smp_affinity
taskset -c 2 /opt/hpssafechannel/hpssafechannel
