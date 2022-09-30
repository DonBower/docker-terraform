#!/bin/bash
latestVersion=`curl --silent https://releases.hashicorp.com/terraform | grep terraform | grep -iv "alpha\|beta\|rc" | head -n 2 | tail -n 1 | cut -d "_" -f 2 | cut -d "<" -f 1`
echo -e "${latestVersion}-$(date +%Y-%m-%d)" > version.txt
