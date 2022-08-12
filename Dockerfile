FROM nvcr.io/nvidia/cuda:11.2.2-devel-ubuntu20.04

USER root
RUN apt-get update -y && \
    ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get -qq install -y --no-install-recommends \
    git \
    curl \
    rsync \
    unzip \
    less \
    nano \
    vim \
    openssh-client \
    openssh-server \
    netcat \
    cmake \
    tmux \
    screen \
    gnupg \
    htop \
    wget \
    p7zip \
    p7zip-full && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    chmod g-s /usr/bin/screen && \
    chmod 1777 /var/run/screen && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get -y install htop

RUN apt-get update && apt-get install -y python3.8 python3.8-dev python3.8-venv curl python3-tk

RUN python3.8 -m pip install -U pip setuptools

RUN apt-get update
RUN echo y|apt-get install build-essential manpages-dev -

RUN wget https://github.com/ninja-build/ninja/releases/download/v1.8.2/ninja-linux.zip
RUN unzip ninja-linux.zip -d /usr/local/bin/
RUN update-alternatives --install /usr/bin/ninja ninja /usr/local/bin/ninja 1 --force 

USER jovyan
WORKDIR /home/jovyan

# # 1) choose base container
# # generally use the most recent tag

# # base notebook, contains Jupyter and relevant tools
# # See https://github.com/ucsd-ets/datahub-docker-stack/wiki/Stable-Tag 
# # for a list of the most current containers we maintain
# ARG BASE_CONTAINER=ucsdets/scipy-ml-notebook:2022.3-stable
# #ucsdets/datahub-base-notebook:2022.3-stable

# FROM $BASE_CONTAINER

# LABEL maintainer="UC San Diego ITS/ETS <ets-consult@ucsd.edu>"

# # 2) change to root to install packages
# USER root


# RUN apt-get -y install htop

# RUN sudo apt-get update
# RUN sudo echo y|apt-get install build-essential manpages-dev -

# RUN wget https://github.com/ninja-build/ninja/releases/download/v1.8.2/ninja-linux.zip
# RUN sudo unzip ninja-linux.zip -d /usr/local/bin/
# RUN sudo update-alternatives --install /usr/bin/ninja ninja /usr/local/bin/ninja 1 --force 


# # 3) install packages using notebook user
# USER jovyan

# RUN pip install --no-cache-dir networkx scipy --user


# # Override command to disable running jupyter notebook at launch
# # CMD ["/bin/bash"]

