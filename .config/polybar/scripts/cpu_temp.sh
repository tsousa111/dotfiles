#! /usr/bin/bash

sensors | grep "Package id 0" | awk '{print $4}' | cut -d "." -f 1 | sed -e 's/+//'
