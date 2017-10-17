FROM sagemath/sagemath:8.0

# Inspired from https://mybinder.readthedocs.io/en/latest/dockerfile.html#preparing-your-dockerfile

ENV NB_USER sage
ENV HOME /home/${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
COPY jupyter jupyter-notebook /usr/bin/
RUN chown -R ${NB_USER}:${NB_USER} ${HOME}
USER ${NB_USER}

# Upgrade to jupyter 5.* as required by mybinder
RUN sage -pip install "notebook>=5" "ipykernel>=4.6"

# Install additional kernels
RUN sage -i gap_jupyter
RUN sage -i singular_jupyter
RUN sage -i pari_jupyter
