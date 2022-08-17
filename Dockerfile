FROM dweindl/amici:latest
LABEL description="Parameter Estimation Pipeline"

# Install graphviz

RUN apt-get clean && apt-get update && apt-get install graphviz -y 

# Setup the Python environment.

COPY requirements.txt /tmp

RUN pip3 install -r /tmp/requirements.txt

# Install BNG

RUN apt-get install wget tar -y

RUN wget -q -O /tmp/bionetgen.tar.gz https://github.com/RuleWorld/bionetgen/releases/download/BioNetGen-2.8.4/BioNetGen-2.8.4-linux.tar.gz

RUN mkdir /usr/local/share/BioNetGen

RUN tar xf /tmp/bionetgen.tar.gz -C /usr/local/share/BioNetGen --strip-components=1
