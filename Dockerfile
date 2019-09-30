FROM jupyter/datascience-notebook:latest

COPY requirements.txt /tmp/
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

USER jovyan

RUN conda update -n base conda
RUN conda install -c conda-forge ipyleaflet
RUN conda install -c anaconda postgresql
RUN conda install -c conda-forge gdal
RUN conda install -c conda-forge geopandas
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-leaflet\
    jupyter labextension install jupyterlab-tutorial\
    jupyter labextension install jupyterlab-spreadsheet