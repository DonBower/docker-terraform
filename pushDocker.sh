cat ~/.ssh/dockerpw | docker login --username donbower --password-stdin
#
# Retreive the HCP Team Token from vault
#
hcpTeamToken=`vault kv get -format=json kv/HCP/teamToken | jq .data.data.value`
#
# build the terraformrc file
#
echo 'plugin_cache_dir   = "/root/.terraform.d/plugin-cache"' > terraformrc
echo 'disable_checkpoint = true' >> terraformrc
echo '' >> terraformrc
echo 'credentials "app.terraform.io" {' >> terraformrc
echo -e "  token = ${hcpTeamToken}" >> terraformrc
echo '}' >> terraformrc


export thisTag=`cat version.txt`
docker build --tag donbower/terraform:${thisTag} .
errorLevel=$?
if [[ ${errorLevel} -gt 0 ]]; then
  echo docker build failed, exiting...
  exit ${errorLevel}
fi
docker push donbower/terraform:${thisTag}
#
# Delete the terraformrc file
rm terraformrc
#
# Update Vault with the latest Bundle
#
vault kv put concourse/common/terraformBundle value=`cat version.txt`
