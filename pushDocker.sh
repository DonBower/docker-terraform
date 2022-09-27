cat ~/.ssh/dockerpw | docker login --username donbower --password-stdin
export thisTag=`cat version.txt`
docker build --tag donbower/terraform:${thisTag} . 
docker push donbower/terraform:${thisTag}