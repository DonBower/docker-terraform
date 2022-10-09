#!/bin/bash


# latestVersion=`grep terraform-provider curl.xml | head -n 1 | cut -d "_" -f 2 | cut -d "<" -f 1`
# thisProvider=`grep terraform-provider  | cut -d "-" -f 3 | cut -d "/" -f 1`
echo -n > providers.tsv
while read thisProvider; do
  latestVersion=`curl --silent https://releases.hashicorp.com/terraform-provider-${thisProvider} | grep terraform-provider | head -n 1 | cut -d "_" -f 2 | cut -d "<" -f 1`
  echo -e "${thisProvider}\t${latestVersion}" >> providers.tsv
  sed -i .old  "s/^|${thisProvider}|.*/|${thisProvider}|${latestVersion}|/g" README.md
done < my-providers.txt