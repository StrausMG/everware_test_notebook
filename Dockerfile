FROM everware/base
MAINTAINER Yuriy Gorishniy

USER root

RUN conda install --yes numpy scipy scikit-learn matplotlib pandas

USER jupyter
WORKDIR /home/jupyter/

EXPOSE 8888