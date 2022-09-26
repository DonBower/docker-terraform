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

Now install the Nginx, PHP-FPM, and supervisor packages. Once all installation is completed, remove all packages cache to reduce the size of the custom image.
# Install nginx, php-fpm and supervisord from ubuntu repository

RUN apt install -y \
  wget \
  && rm -rf /var/lib/apt/lists/* \
  && apt clean

ARG ARCH_MACH=`uname -m`
ARG OS_NAME=`uname -s | tr '[:upper:]' '[:lower:]'`


RUN wget https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_darwin_amd64.zip
RUN wget https://releases.hashicorp.com/terraform-provider-aws/4.29.0/terraform-provider-aws_4.29.0_darwin_amd64.zip
