FROM debian:stable-slim

ENV DEBIAN_FRONTEND noninteractive

ARG CLOUD_SDK_VERSION=275.0.0
ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION

RUN apt-get update \
    && apt-get -y install --no-install-recommends \
    curl jq ca-certificates python python3 python-dev \
    && rm -rf /var/lib/apt/lists/*

# Install gcloud
ENV PATH /google-cloud-sdk/bin:$PATH
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz
RUN tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz
RUN  rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz
RUN ln -s /lib /lib64
RUN gcloud config set core/disable_usage_reporting true
RUN gcloud config set component_manager/disable_update_check true
RUN gcloud config set metrics/environment github_docker_image
RUN gcloud --version