#Download base image ubuntu 20.04
################################################################################
#                                    LAYER 1                                   #
################################################################################
FROM ubuntu:20.04

# LABEL about the custom image
LABEL maintainer="Don.Bower@outlook.com"
LABEL version="1.1.9-2022-08-27"
LABEL description="This is custom Docker Image for Terraform Services, with providers listed in providers.tsv"

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive
ARG ARCH=amd64
# ARG OS_NAME=`uname -s | tr '[:upper:]' '[:lower:]'`
ARG OS_NAME=linux
################################################################################
#                                    LAYER 2                                   #
################################################################################
# Update Ubuntu Software repository
RUN apt update --assume-yes \
    && apt install \
          --assume-yes \
          --no-install-recommends \
          ca-certificates \
          curl \
          wget \
          unzip \
          net-tools \
          netcat \
          python-is-python3 \
          python3-pip \
          jq \
    && rm -rf /var/lib/apt/lists/* \
    && apt clean
################################################################################
#                                    LAYER 3                                   #
################################################################################
RUN pip install yq
################################################################################
#                                    LAYER 4                                   #
################################################################################
RUN wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
    && unzip awscli-exe-linux-x86_64.zip \
    && ./aws/install
################################################################################
#                                    LAYER 5                                   #
################################################################################
RUN wget --no-check-certificate \
    https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_${OS_NAME}_${ARCH}.zip \
    && unzip terraform_1.1.9_${OS_NAME}_${ARCH}.zip -d /usr/local/bin
################################################################################
#                                    LAYER 6                                   #
################################################################################
COPY providers.* .
################################################################################
#                                    LAYER 7                                   #
################################################################################
RUN ./providers.sh
################################################################################
#                                    LAYER 8                                   #
################################################################################
COPY terraformrc /root/.terraformrc
