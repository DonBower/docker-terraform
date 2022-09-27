#Download base image ubuntu 20.04
FROM ubuntu:20.04

# LABEL about the custom image
LABEL maintainer="Don.Bower@outlook.com"
LABEL version="1.1.9-2022-08-27"
LABEL description="This is custom Docker Image for Terraform Services, with providers listed in providers.tsv"

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive
ARG ARCH=amd64
ARG OS_NAME=`uname -s | tr '[:upper:]' '[:lower:]'`
ARG OS_NAME=linux
ARG thesePlugins=("aws:4.29.0" "random:3.4.3")

# Update Ubuntu Software repository
RUN apt update --assume-yes \
    && apt install \
          --assume-yes \
          --no-install-recommends \
          wget \
          unzip \
    && rm -rf /var/lib/apt/lists/* \
    && apt clean

RUN wget https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_${OS_NAME}_${ARCH}.zip \
    && unzip terraform_1.1.9_${OS_NAME}_${ARCH}.zip -d /usr/local/bin

COPY providers.* .
RUN ./providers.sh
