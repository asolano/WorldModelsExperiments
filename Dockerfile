FROM tensorflow/tensorflow:1.8.0-gpu-py3

# gym-doom requirements
RUN apt-get update && apt-get install -y --no-install-recommends \
        cmake \
        zlib1g-dev \
        libjpeg-dev \
        libboost-all-dev \
        gcc \
        libsdl2-dev \
        wget \
        unzip \
        python3-tk \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# make python3 the default
RUN update-alternatives --remove python /usr/bin/python2 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 10

RUN pip install --upgrade pip && \
    pip install --no-cache-dir --user --upgrade \
        gym==0.9.4 \
        ppaquette-gym-doom \
        cma==2.2.0 
        
ENTRYPOINT ["/bin/bash"]
