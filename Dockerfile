FROM pointcloudlibrary/env:18.04

ARG USER=docker
ARG PASSWORD=${USER}
ARG HOME_PATH=/home/${USER}
ENV LC_CTYPE C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential libssl-dev libffi-dev python3-dev python3-pip cmake \
    wget curl unzip git sudo ssh libhdf5-dev g++ graphviz vim \
    libblosc-dev libbrotli-dev libbz2-dev libgif-dev libopenjp2-7-dev liblcms2-dev libjxr-dev liblz4-dev liblzma-dev \
    libpng-dev libsnappy-dev libz-dev libzstd-dev libwebp-dev libcharls-dev libaec-dev libzopfli-dev libtiff-dev net-tools iputils-ping libpcl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:sweptlaser/python3-pcl && \
    apt update && \
    apt install --no-install-recommends -y python3-pcl && \
    rm -rf /var/lib/apt/lists/*
    
RUN pip3 install -U pip setuptools && \
    pip3 install matplotlib pyyaml

RUN useradd -m -s /bin/bash -N ${USER} && \
    echo "${USER}:${PASSWORD}" |chpasswd && \
    echo "${USER}    ALL=(ALL)       ALL" >> /etc/sudoers

USER ${USER}
WORKDIR ${HOME_PATH}

