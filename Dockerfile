FROM everware/base
MAINTAINER Yuriy Gorishniy

USER root

RUN conda install --yes pandas

USER jupyter
WORKDIR /home/jupyter/

EXPOSE 8888
