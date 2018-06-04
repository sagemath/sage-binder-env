# Dockerfile for binder
# Reference: https://mybinder.readthedocs.io/en/latest/dockerfile.html#preparing-your-dockerfile

FROM sagemath/sagemath:8.1

# Copy the contents of the repo in ${HOME}
COPY --chown=sage:sage . ${HOME}
