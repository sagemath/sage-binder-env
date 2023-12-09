# Multi-stage Dockerfile for slim Sage
# https://docs.docker.com/build/building/multi-stage

FROM ghcr.io/sagemath/sage/sage-ubuntu-focal-standard-with-targets:10.3 AS target

# Resolve symbolic links to recreate them later
RUN readlink /sage/prefix >> /sage/prefix_link
RUN readlink /sage/venv >> /sage/venv_link

WORKDIR /sage

# Strip executables in /sage
RUN LC_ALL=C find local src pkgs -executable -type f -exec strip '{}' ';' 2>&1 | grep -v "file format not recognized" || true

# To exclude doc directory in the next stage
RUN rm -rf local/share/doc

FROM ghcr.io/sagemath/sage/sage-ubuntu-focal-standard-with-system-packages:10.3

USER root

# Remove warnings
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NOWARNINGS="yes"

# Install JupyterLab to the system
RUN apt-get update
RUN apt-get install -y python3-pip
RUN python3 -m pip install --no-warn-script-location notebook jupyterlab ipywidgets

# Disable annoying pupup for Jupyter news
RUN jupyter labextension disable "@jupyterlab/apputils-extension:announcements"

# Install /sage from target
COPY --from=target /sage/local /sage/local
COPY --from=target /sage/src/bin /sage/src/bin
COPY --from=target /sage/src/sage /sage/src/sage
COPY --from=target /sage/sage /sage/sage
COPY --from=target /sage/pkgs/sage-conf /sage/pkgs/sage-conf

# Recreate symbolic links
COPY --from=target /sage/prefix_link /sage/prefix_link
COPY --from=target /sage/venv_link /sage/venv_link
RUN ln -s $(cat /sage/prefix_link) /sage/prefix && rm /sage/prefix_link
RUN ln -s $(cat /sage/venv_link) /sage/venv && rm /sage/venv_link

# Configure Sage library
RUN /sage/sage -pip install --root-user-action=ignore /sage/pkgs/sage-conf

# Remove problematic lines!
RUN sed -i '/^__requires__/d' /sage/venv/bin/sage-venv-config
RUN sed -i '/^__import__/d' /sage/venv/bin/sage-venv-config
