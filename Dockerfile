FROM dweindl/amici:latest
LABEL description="Parameter Estimation Pipeline"

# Setup the Python environment.

COPY requirements.txt

RUN pip3 install -r requirements.txt
