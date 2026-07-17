# Dockerfile for binder
# Reference: https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html

FROM ghcr.io/sagemath/sage-binder-env:dev

USER root

# Create user with uid 1000 if it doesn't exist, or rename sage if it exists
ARG NB_USER=user
ARG NB_UID=1000
ENV NB_USER=${NB_USER}
ENV NB_UID=${NB_UID}
ENV HOME=/home/${NB_USER}
ENV PATH="/home/sage/sage:/home/sage/sage/local/bin:/home/sage/sage/venv/bin:$PATH"

RUN if id -u ${NB_UID} >/dev/null 2>&1; then \
        EXISTING_USER=$(id -nu ${NB_UID}); \
        EXISTING_GROUP=$(id -gn ${NB_UID}); \
        if [ "$EXISTING_GROUP" != "$NB_USER" ]; then \
            groupmod -n ${NB_USER} ${EXISTING_GROUP} || true; \
        fi; \
        if [ "$EXISTING_USER" != "$NB_USER" ]; then \
            usermod -l ${NB_USER} -d ${HOME} ${EXISTING_USER}; \
            mkdir -p ${HOME}; \
            chown ${NB_USER}:${NB_USER} ${HOME}; \
        fi; \
    else \
        groupadd -g ${NB_UID} ${NB_USER} || true; \
        useradd -m -s /bin/bash -u ${NB_UID} -g ${NB_USER} ${NB_USER}; \
    fi

# Make sure the contents of the notebooks directory are in ${HOME}
COPY --chown=${NB_USER}:${NB_USER} notebooks/* ${HOME}/

# Switch to the user
USER ${NB_USER}

RUN mkdir -p $(/usr/bin/sage -sh -c 'jupyter --data-dir')/kernels && \
    ln -sf $(/usr/bin/sage -sh -c 'echo $SAGE_VENV')/share/jupyter/kernels/sagemath $(/usr/bin/sage -sh -c 'jupyter --data-dir')/kernels/sagemath

# Start in the home directory of the user
WORKDIR ${HOME}

# Create the jupyter_lab_config.py file with a custom logging filter to
# suppress the perpetual nodejs warning
RUN mkdir -p ${HOME}/.jupyter
RUN echo "\
import logging\n\
\n\
class NoNodeJSWarningFilter(logging.Filter):\n\
    def filter(self, record):\n\
        return 'Could not determine jupyterlab build status without nodejs' not in record.getMessage()\n\
\n\
logging.getLogger('LabApp').addFilter(NoNodeJSWarningFilter())\n\
" > ${HOME}/.jupyter/jupyter_lab_config.py
