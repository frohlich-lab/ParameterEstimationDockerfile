FROM python:3.13-slim

LABEL description="Parameter Estimation Pipeline"

# Install graphviz

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    chmod 1777 /tmp && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get clean && apt-get update -y && apt-get install graphviz wget tar -y 

# Setup AMICI

RUN apt-get update && apt-get install -y \
    g++ \
    libopenblas-dev \
    libboost-serialization-dev \
    libboost-chrono-dev \
    libhdf5-serial-dev \
    python-is-python3 \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    swig \
    cmake \
    git && \
    pip3 install ninja numpy

# Setup the Python environment.

COPY requirements.txt /tmp

RUN pip3 install --no-cache-dir -r /tmp/requirements.txt && \
    wget -q -O /tmp/bionetgen.tar.gz https://github.com/RuleWorld/bionetgen/releases/download/BioNetGen-2.9.3/BioNetGen-2.9.3-linux.tar.gz && \
    mkdir /usr/local/share/BioNetGen && \
    tar xf /tmp/bionetgen.tar.gz -C /usr/local/share/BioNetGen --strip-components=1

RUN git config --global --add safe.directory '*'

