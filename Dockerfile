FROM everware/base
MAINTAINER Yuriy Gorishniy

USER root

USER jupyter
WORKDIR /home/jupyter/

EXPOSE 8888
