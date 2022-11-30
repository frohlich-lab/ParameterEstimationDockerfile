# TODO: revert to latest as soon as multiarch docker is released

FROM dweindl/amici:multiarch_docker
LABEL description="Parameter Estimation Pipeline"

# Install graphviz

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    chmod 1777 /tmp && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get clean && apt-get update -y && apt-get install graphviz wget tar -y 

# build jax from source (no aarch64 wheels)

ENV PATH="${PATH}:/usr/local/bin"

RUN mkdir /tmp/bazel && \
    cd /tmp/bazel && \
    wget https://github.com/bazelbuild/bazelisk/releases/download/v1.15.0/bazelisk-linux-$(dpkg --print-architecture) && \
    chmod +x bazelisk-linux-$(dpkg --print-architecture) && \
    mv bazelisk-linux-$(dpkg --print-architecture) /usr/local/bin/bazel && \
    wget -q -O /tmp/jax.tar.gz https://github.com/google/jax/archive/refs/tags/jaxlib-v0.3.25.tar.gz && \
    mkdir /tmp/jax && \
    tar xf /tmp/jax.tar.gz -C /tmp/jax  --strip-components=1 && \
    cd /tmp/jax && \
    python3 build/build.py && \
    pip install dist/*whl


# Setup the Python environment.

COPY requirements.txt /tmp

RUN pip3 install -r /tmp/requirements.txt && \
    wget -q -O /tmp/bionetgen.tar.gz https://github.com/RuleWorld/bionetgen/releases/download/BioNetGen-2.8.4/BioNetGen-2.8.4-linux.tar.gz && \
    mkdir /usr/local/share/BioNetGen && \
    tar xf /tmp/bionetgen.tar.gz -C /usr/local/share/BioNetGen --strip-components=1

