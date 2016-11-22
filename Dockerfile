# Basic container needed for your repository to work
# with everware. Slimmed down version of jupyter/notebook
# Your analysis container should inherit this one with
# `FROM everware/base`

FROM ubuntu:14.04

MAINTAINER Project Everware

ENV DEBIAN_FRONTEND noninteractive

# Not essential, but wise to set the lang
# Note: Users with other languages should set this in their derivative image
RUN apt-get update && apt-get install -y language-pack-en
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

# Python binary dependencies, developer tools
RUN apt-get update && apt-get install -y -q \
    build-essential \
    make \
    wget \
    gcc \
    zlib1g-dev \
    git \
    libzmq3-dev \
    sqlite3 \
    libsqlite3-dev \
    pandoc \
    libcurl4-openssl-dev \
    nodejs \
    nodejs-legacy \
    npm

RUN apt-get update && apt-get install -y wget && \
    wget -q https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh && \
    bash Anaconda3-4.2.0-Linux-x86_64.sh -p /anaconda -b && \
    rm Anaconda3-4.2.0-Linux-x86_64.sh && \
    rm -rf /var/lib/apt/lists/*

# Install anaconda
ENV ANACONDA_DIR /opt/anaconda
RUN echo 'export PATH=$ANACONDA_DIR/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget -q https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh && \
    /bin/bash /Anaconda3-4.2.0-Linux-x86_64.sh -b -p $ANACONDA_DIR && \
    rm Anaconda3-4.2.0-Linux-x86_64.sh && \
    rm -rf /var/lib/apt/lists/*
ENV PATH $ANACONDA_DIR/bin:$PATH

RUN mkdir -p /srv/
WORKDIR /srv/

# fetch juptyerhub-singleuser entrypoint
ADD https://raw.githubusercontent.com/jupyterhub/jupyterhub/master/scripts/jupyterhub-singleuser /usr/local/bin/jupyterhub-singleuser
RUN chmod 755 /usr/local/bin/jupyterhub-singleuser

# jupyter is our user
RUN useradd -m -s /bin/bash jupyter

USER jupyter
ENV HOME /home/jupyter
ENV SHELL /bin/bash
ENV USER jupyter

WORKDIR /home/jupyter/

EXPOSE 8888

ADD singleuser.sh /srv/singleuser/singleuser.sh
CMD ["sh", "/srv/singleuser/singleuser.sh"]