cat ~/.ssh/dockerpw | docker login --username donbower --password-stdin
#
# Retreive the HCP Team Token from vault
#
hcpTeamToken=`vault kv get -format=json kv/HCP/teamToken | jq .data.data.value`
#
# build the terraformrc file
#
cat > terraformrc <<TFLOGIN
plugin_cache_dir   = "/root/.terraform.d/plugin-cache"
disable_checkpoint = true

credentials "app.terraform.io" {
  token = ${hcpTeamToken}
}
TFLOGIN

export thisTag=`cat version.txt`
export tfVersion=`echo ${thisTag} | cut -d "-" -f 1`

docker build \
  --build-arg DOCKER_TF_VERSION=${tfVersion} \
  --build-arg DOCKER_TAG=${thisTag} \
  --tag donbower/terraform:${thisTag} \
  .
errorLevel=$?
if [[ ${errorLevel} -gt 0 ]]; then
  echo docker build failed, exiting...
  exit ${errorLevel}
fi
docker push donbower/terraform:${thisTag}
#
# Delete the terraformrc file
# rm terraformrc
#
# Update Vault with the latest Bundle
#
vault kv put concourse/common/terraformBundle value=`cat version.txt`

rm terraformrc