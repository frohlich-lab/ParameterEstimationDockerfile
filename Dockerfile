# TODO: revert to latest as soon as multiarch docker is released

FROM dweindl/amici:release_0.18.0
LABEL description="Parameter Estimation Pipeline"

# Install graphviz

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    chmod 1777 /tmp && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get clean && apt-get update -y && apt-get install graphviz wget tar -y 

# Setup the Python environment.

COPY requirements.txt /tmp

RUN pip3 install -r /tmp/requirements.txt && \
    wget -q -O /tmp/bionetgen.tar.gz https://github.com/RuleWorld/bionetgen/releases/download/BioNetGen-2.8.5/BioNetGen-2.8.5-linux.tar.gz && \
    mkdir /usr/local/share/BioNetGen && \
    tar xf /tmp/bionetgen.tar.gz -C /usr/local/share/BioNetGen --strip-components=1

