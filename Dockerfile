#Download base image ubuntu 20.04
################################################################################
#                                    LAYER 1                                   #
################################################################################
FROM ubuntu:20.04

# LABEL about the custom image
# ARG BUNDLE_DATE="2022-09-29"
ARG DOCKER_TF_VERSION
ARG DOCKER_TAG
ARG ARM_CLIENT_ID
ARG ARM_TENANT_ID
ARG ARM_CLIENT_SECRET
ENV DOCKER_TF_VERSION=${DOCKER_TF_VERSION}
ENV DOCKER_TF_BUNDLE="${DOCKER_TAG}"
ENV AWS_PAGER=''
ENV ARM_CLIENT_ID=${ARM_CLIENT_ID}
ENV ARM_TENANT_ID=${ARM_TENANT_ID}
ENV ARM_CLIENT_SECRET=${ARM_CLIENT_SECRET}
LABEL maintainer="Don.Bower@outlook.com"
LABEL version="${DOCKER_TF_BUNDLE}"
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
          vim \
          git \
    && curl -sL https://aka.ms/InstallAzureCLIDeb | bash \
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
    && ./aws/install \
    && rm awscli-exe-linux-x86_64.zip
################################################################################
#                                    LAYER 5                                   #
################################################################################
RUN wget --no-check-certificate \
    https://releases.hashicorp.com/terraform/${DOCKER_TF_VERSION}/terraform_${DOCKER_TF_VERSION}_${OS_NAME}_${ARCH}.zip \
    && unzip terraform_${DOCKER_TF_VERSION}_${OS_NAME}_${ARCH}.zip -d /usr/local/bin
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
