FROM dweindl/amici:latest
LABEL description="Parameter Estimation Pipeline"

# Setup the Python environment.

COPY requirements.txt /tmp

RUN pip3 install -r /tmp/requirements.txt
