#! /usr/bin/bash

sensors | grep "edge" | awk '{print $2}' | cut -d "." -f 1 | sed -e 's/+//'
