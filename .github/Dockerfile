# Multi-stage Dockerfile for slim Sage based on official Docker Hub images
ARG TAG=latest
FROM sagemath/sagemath:${TAG} AS target

USER root

# Install JupyterLab, notebook, and ipywidgets inside Sage's virtual environment
RUN sage -pip install --no-cache-dir jupyterlab notebook ipywidgets


# Strip executables to shrink image size
RUN LC_ALL=C find /home/sage/sage/local /home/sage/sage/src -type f -exec strip '{}' ';' 2>/dev/null || true

# Remove all __pycache__ directories
RUN find /home/sage/sage -type d -name "__pycache__" -exec rm -rf {} +
# Remove docs, examples, and other non-runtime files to save space
RUN rm -rf /home/sage/sage/local/share/doc /home/sage/sage/local/share/*/doc /home/sage/sage/local/share/*/examples

# We use ubuntu:jammy as the runner base to match sagemath/sagemath's OS
FROM ubuntu:noble

USER root

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS="yes"

# Install Sage run-time dependencies
RUN apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends \
       gfortran gcc g++ libstdc++-13-dev sudo openssl pkg-config patch \
       libz-dev libbz2-dev bzip2 ca-certificates perl libboost-dev python3 \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/*

# Create user 'sage' with uid 1000
RUN (userdel -r ubuntu || true) \
    && useradd -m -s /bin/bash -c "Sage user" -u 1000 sage \
    && echo "sage ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/01-sage \
    && chmod 0440 /etc/sudoers.d/01-sage

# Copy ONLY necessary Sage directories from target
WORKDIR /home/sage/sage
COPY --chown=sage:sage --from=target /home/sage/sage/local ./local
COPY --chown=sage:sage --from=target /home/sage/sage/src/bin ./src/bin
COPY --chown=sage:sage --from=target /home/sage/sage/src/sage ./src/sage
COPY --chown=sage:sage --from=target /home/sage/sage/sage ./sage
# Recreate prefix and venv symlinks
RUN ln -s local /home/sage/sage/prefix && \
    ln -s local/var/lib/sage/venv-python3.* /home/sage/sage/venv

# Set up global wrapper symlinks
RUN ln -sf /home/sage/sage/sage /usr/bin/sage && \
    ln -sf /home/sage/sage/sage /usr/bin/sagemath

USER sage
WORKDIR /home/sage
