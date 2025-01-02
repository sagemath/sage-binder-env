# Dockerfile for binder
# Reference: https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html

FROM ghcr.io/sagemath/sage-binder-env:10.6

USER root

# Create user with uid 1000
ARG NB_USER=user
ARG NB_UID=1000
ENV NB_USER user
ENV NB_UID 1000
ENV HOME /home/${NB_USER}
RUN adduser --disabled-password --gecos "Default user" --uid ${NB_UID} ${NB_USER}

# Make sure the contents of the notebooks directory are in ${HOME}
COPY notebooks/* ${HOME}/
RUN chown -R ${NB_USER}:${NB_USER} ${HOME}

# Switch to the user
USER ${NB_USER}

# Install Sage kernel to Jupyter
RUN mkdir -p $(jupyter --data-dir)/kernels
RUN ln -s /sage/venv/share/jupyter/kernels/sagemath $(jupyter --data-dir)/kernels

# Make Sage accessible from anywhere
ENV PATH="/sage:$PATH"

# Start in the home directory of the user
WORKDIR /home/${NB_USER}

# Create the jupyter_lab_config.py file with a custom logging filter to
# suppress the perpetual nodejs warning
RUN mkdir -p /home/${NB_USER}/.jupyter
RUN echo "\
import logging\n\
\n\
class NoNodeJSWarningFilter(logging.Filter):\n\
    def filter(self, record):\n\
        return 'Could not determine jupyterlab build status without nodejs' not in record.getMessage()\n\
\n\
logging.getLogger('LabApp').addFilter(NoNodeJSWarningFilter())\n\
" > /home/${NB_USER}/.jupyter/jupyter_lab_config.py
