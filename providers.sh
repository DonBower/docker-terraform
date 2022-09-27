#!/bin/bash
ARCH=amd64
OS_NAME=linux
while read -r thisName thisVer; do
  thisFile=terraform-provider-${thisName}_${thisVer}_${OS_NAME}_${ARCH}.zip
  thisReg=registry.terraform.io/hashicorp/${thisName}/${thisVer}/${OS_NAME}_${ARCH}
  echo -e "\nGet Provider ${thisName} version ${thisVer} \n"
  wget https://releases.hashicorp.com/terraform-provider-${thisName}/${thisVer}/${thisFile}
  mkdir -p ~/.terraform.d/plugin-cache/${thisReg}
  unzip -u ${thisFile} -d ~/.terraform.d/plugin-cache/${thisReg} 
done < providers.tsv