# docker-terraform
Docker Repo for Terraform image

[![Repo](https://img.shields.io/static/v1?style=for-the-badge&logo=github&logoColor=white&label=tag&message=1.3.0-2022-10-09&color=blue)](https://github.com/DonBower/docker-terraform)
[![Terraform](https://img.shields.io/static/v1?style=for-the-badge&logo=terraform&logoColor=white&label=version&message=1.3.0&color=blue)](https://www.terraform.io/)
[![Providers](https://img.shields.io/static/v1?style=for-the-badge&logo=terraform&logoColor=white&label=terraform-providers&message=21&color=blue)](https://releases.hashicopr.com)
[![Ubuntu](https://img.shields.io/static/v1?style=for-the-badge&logo=ubuntu&logoColor=white&label=ubuntu&message=20.04_LTS&color=blue)](https://ubuntu.com/download/server)

# Changelog
- 1.3.0-2022-10-09 Fix Secret Value
- 1.3.0-2022-10-08 Add azurerm provider, cli, ignore README.md.old
- 1.3.0-2022-10-07 fix token, AWS_PAGER='' to fix aws cli v2
- 1.3.0-2022-10-04 Add git, vim.

# Pacakages
## APT
ca-certificates, curl, wget, unzip, net-tools, netcat (nc), python-is-python3 python3-pip, jq, vim, git

## PIP
yq

# Providers
| Provider    | Ver      |
| ----------- | -------- |
|aws|4.34.0|
|azure|0.1.1|
|azurerm|3.26.0|
|consul|2.16.2|
|docker|2.7.2|
|github|5.3.0|
|google|4.39.0|
|grafana|1.29.0|
|hcloud|1.35.2|
|hcp|0.45.0|
|helm|2.7.0|
|http|3.1.0|
|kubernetes|2.14.0|
|local|2.2.3|
|nomad|1.4.18|
|postgresql|1.7.2|
|random|3.4.3|
|template|2.2.0|
|terraform|1.0.2|
|tfe|0.37.0|
|vault|3.9.1|
|vsphere|2.2.0|
