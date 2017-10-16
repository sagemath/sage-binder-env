FROM sagemath/sagemath:8.0

# Inspired from https://mybinder.readthedocs.io/en/latest/dockerfile.html#preparing-your-dockerfile

ENV NB_USER sage
ENV HOME /home/${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
COPY jupyter /usr/bin/
RUN chown -R ${NB_USER}:${NB_USER} ${HOME}
USER ${NB_USER}

# Upgrade to jupyter 5.* as required by mybinder
sage -pip install --upgrade jupyter
