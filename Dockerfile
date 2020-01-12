FROM jupyter/datascience-notebook:latest

COPY requirements.txt /tmp/
COPY install-docker.sh /tmp/

RUN /bin/bash -c "source activate base"

RUN pip install --requirement /tmp/requirements.txt && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER root

RUN apt update\
	&& apt install -y curl\
    htop\
    git\
    unzip\
    openssh-server\
    openssh-client

RUN sh /tmp/install-docker.sh

RUN groupadd -g 999 docker\ 
    && usermod -aG docker jovyan

USER jovyan

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-leaflet
RUN conda install -c conda-forge ipyleaflet
RUN conda install -c anaconda postgresql
RUN conda install -c conda-forge gdal