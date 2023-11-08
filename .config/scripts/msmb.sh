#!/bin/sh

sudo mount -t cifs -o uid=1000,credentials=/home/tsousa/.smb-creds //192.168.1.56/smb-apollo /mnt/smb/
