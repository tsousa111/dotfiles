#! /usr/bin/bash

nvidia-smi -q -d TEMPERATURE | grep "GPU Current Temp" | awk '{print $5}'
