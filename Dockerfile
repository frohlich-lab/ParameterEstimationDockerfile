FROM dweindl/amici:latest
LABEL description="Parameter Estimation Pipeline"

# Setup the Python environment.

COPY requirements.txt /tmp

RUN pip3 install -r /tmp/requirements.txt

# Install BNG

RUN apt-get install wget -y

RUN wget -q -O /tmp/bionetgen.tar.gz https://github.com/RuleWorld/bionetgen/releases/download/BioNetGen-2.8.4/BioNetGen-2.8.4-linux.tar.gz

RUN mv /tmp/BioNetGen-2.8.4 /usr/local/share/BioNetGen
