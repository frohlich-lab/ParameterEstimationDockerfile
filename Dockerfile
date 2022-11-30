# TODO: revert to latest as soon as multiarch docker is released

FROM dweindl/amici:multiarch_docker
LABEL description="Parameter Estimation Pipeline"

# Install graphviz

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN chmod 1777 /tmp

RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get clean && apt-get update -y && apt-get install graphviz wget tar -y 

# Install bazel(isk) (required for building jax)

RUN mkdir /tmp/bazel && \
    cd /tmp/bazel && \
    wget https://github.com/bazelbuild/bazelisk/releases/download/v1.15.0/bazelisk-linux-$(dpkg --print-architecture) && \
    chmod +x bazelisk-linux-$(dpkg --print-architecture) && \
    mv bazelisk-linux-$(dpkg --print-architecture) /usr/local/bin/bazel

# Install jax from source (no aarch64 wheels)

RUN wget -q -O /tmp/jax.tar.gz https://github.com/google/jax/archive/refs/tags/jaxlib-v0.3.25.tar.gz 

RUN mkdir /tmp/jax

RUN tar xf /tmp/jax.tar.gz -C /tmp/jax  --strip-components=1

RUN cd /tmp/jax && python3 build/build.py && pip install dist/*whl


# Setup the Python environment.

COPY requirements.txt /tmp

RUN pip3 install -r /tmp/requirements.txt

# Install BNG

RUN wget -q -O /tmp/bionetgen.tar.gz https://github.com/RuleWorld/bionetgen/releases/download/BioNetGen-2.8.4/BioNetGen-2.8.4-linux.tar.gz

RUN mkdir /usr/local/share/BioNetGen

RUN tar xf /tmp/bionetgen.tar.gz -C /usr/local/share/BioNetGen --strip-components=1

