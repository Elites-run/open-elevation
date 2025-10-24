FROM ghcr.io/osgeo/gdal:ubuntu-small-latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    libspatialindex-dev \
    unar \
    bc \
    python3-pip \
    python3-venv \
    wget

# Create a virtual environment
RUN python3 -m venv /venv

# Upgrade pip and install requirements in the virtual environment
RUN /venv/bin/pip install --upgrade pip
ADD ./requirements.txt .
RUN /venv/bin/pip install -r requirements.txt

# Create application directory and add application code
RUN mkdir /code
ADD . /code/

# Set the working directory
WORKDIR /code

# Use the virtual environment to run the application
CMD ["/venv/bin/python", "server.py"]

# Expose the necessary ports
EXPOSE 8080
EXPOSE 8443