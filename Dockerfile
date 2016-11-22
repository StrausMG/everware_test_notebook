FROM ubuntu
MAINTAINER Yuriy Gorishniy

ARG DEBIAN_FRONTEND=noninteractive

# installing and updating anaconda
RUN apt-get update && apt-get install -y wget && \
    wget -q https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh && \
    bash Anaconda3-4.2.0-Linux-x86_64.sh -p /anaconda -b && \
    rm Anaconda3-4.2.0-Linux-x86_64.sh && \
    rm -rf /var/lib/apt/lists/*
ENV PATH /anaconda/bin:$PATH
RUN conda update -y conda