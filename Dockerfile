#Download base image ubuntu 20.04
FROM ubuntu:20.04

# LABEL about the custom image
LABEL maintainer="Don.Bower@outlook.com"
LABEL version="0.1.0"
LABEL description="This is custom Docker Image for Terraform Services."

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Update Ubuntu Software repository
RUN apt update

# Now install the Nginx, PHP-FPM, and supervisor packages. Once all installation is completed, remove all packages cache to reduce the size of the custom image.
# Install nginx, php-fpm and supervisord from ubuntu repository

RUN apt install -y \
  wget \
  unzip \
  && rm -rf /var/lib/apt/lists/* \
  && apt clean

ARG ARCH=amd64
ARG OS_NAME=`uname -s | tr '[:upper:]' '[:lower:]'`
ARG OS_NAME=linux


RUN wget https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_${OS_NAME}_${ARCH}.zip
RUN wget https://releases.hashicorp.com/terraform-provider-aws/4.29.0/terraform-provider-aws_4.29.0_${OS_NAME}_${ARCH}.zip
RUN unzip terraform_1.1.9_${OS_NAME}_${ARCH}.zip -d /usr/local/bin
RUN mkdir -p ~/.terraform.d/plugin-cache/registry.terraform.io/hashicorp/aws/4.29.0/${OS_NAME}_${ARCH}
RUN unzip terraform-provider-aws_4.29.0_${OS_NAME}_${ARCH}.zip -d ~/.terraform.d/plugin-cache/registry.terraform.io/hashicorp/aws/4.29.0/${OS_NAME}_${ARCH}