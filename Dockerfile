FROM sagemath/sagemath:8.0

# Inspired from https://mybinder.readthedocs.io/en/latest/dockerfile.html#preparing-your-dockerfile

ENV NB_USER=sage
ENV HOME /home/sage

# Upgrade to jupyter 5.* as required by mybinder and install additional kernels
# This will eventually be lifted upstream to sagemath/sagemath
RUN sage -pip install "notebook>=5" "ipykernel>=4.6"
RUN sage -i gap_jupyter
RUN sage -i singular_jupyter
RUN sage -i pari_jupyter

USER root
# This will eventually be lifted upstream to sagemath/sagemath
COPY jupyter jupyter-notebook /usr/bin/

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
RUN chown -R ${NB_USER}:${NB_USER} ${HOME}
USER ${NB_USER}
