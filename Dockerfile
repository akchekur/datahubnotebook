# 1) choose base container
# generally use the most recent tag

# base notebook, contains Jupyter and relevant tools
# See https://github.com/ucsd-ets/datahub-docker-stack/wiki/Stable-Tag 
# for a list of the most current containers we maintain
ARG BASE_CONTAINER=ucsdets/datahub-base-notebook:2022.3-stable

FROM $BASE_CONTAINER

LABEL maintainer="UC San Diego ITS/ETS <ets-consult@ucsd.edu>"

# 2) change to root to install packages
USER root

RUN sudo apt-get build-dep python3

RUN apt-get -y install htop


# RUN apt-get install g++

RUN sudo apt-get install --reinstall g++

# RUN sudo apt-get install ninja-build

# RUN wget https://github.com/ninja-build/ninja/releases/download/v1.8.2/ninja-linux.zip
# RUN sudo unzip ninja-linux.zip -d /usr/local/bin/
# RUN sudo update-alternatives --install /usr/bin/ninja ninja /usr/local/bin/ninja 1 --force 

# 3) install packages using notebook user
USER jovyan

# RUN conda install -y scikit-learn

RUN pip install --no-cache-dir networkx scipy

RUN pip install torch
RUN pip install torchvision

# Override command to disable running jupyter notebook at launch
# CMD ["/bin/bash"]

