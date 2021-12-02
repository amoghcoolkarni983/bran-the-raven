FROM python


RUN yum install -y wget tar gzip gcc gcc-c++ make openssl-devel bzip2-devel libffi-devel mesa-libGL-devel vi
RUN yum groupinstall -y "Development Tools"
RUN cd /usr/lib && \
    wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz && \
    tar xzf Python-3.7.4.tgz && \
    cd Python-3.7.4 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    rm /usr/lib/Python-3.7.4.tgz

# Upgrade pip
RUN python3.7 -m pip install --upgrade pip


# Installing python module requirements
COPY requirements.txt /data/requirements.txt
RUN python3.7 -m pip install -r /data/requirements.txt



RUN mkdir -p /bran/models/
WORKDIR /bran/models/

WORKDIR /bran/
COPY src/*.py /bran/src/