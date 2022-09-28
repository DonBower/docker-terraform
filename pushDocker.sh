cat ~/.ssh/dockerpw | docker login --username donbower --password-stdin
cp ~/.terraformrc .
export thisTag=`cat version.txt`
docker build --tag donbower/terraform:${thisTag} .
errorLevel=$?
if [[ ${errorLevel} -gt 0 ]]; then
  echo docker build failed, exiting...
  exit ${errorLevel}
fi
docker push donbower/terraform:${thisTag}
rm .terraformrc

# curl https://releases.hashicorp.com/terraform-provider-aws/