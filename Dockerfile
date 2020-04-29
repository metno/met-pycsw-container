# =================================================================
#
# Authors: Ricardo Garcia Silva <ricardo.garcia.silva@gmail.com>
# Copyright (c) 2017 Ricardo Garcia Silva
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# =================================================================
#
# Adapted from pycsw official Dockerfile
# Contributors: Massimo Di Stefano
# 
#
FROM alpine:latest


RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.11/main' >> /etc/apk/repositories \
  && apk add --no-cache \
    ca-certificates \
    python3 \
    libpq \
    libxml2 \
    libxml2-dev \
    libxslt-dev \
    wget \
    postgresql-dev \
    sqlite \
  && apk add --no-cache \
    --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
    --allow-untrusted \
    geos \
    proj \
    proj-util \
    geos-dev \
    proj-dev \
    git

#  Separate instruction so that can be asly removed after the build

RUN apk add --no-cache --virtual .build-deps \
    build-base \
    python3-dev

# optional for an easy/friendly interactive docker session
RUN apk add --update bash

RUN adduser -D -u 1000 pycsw

WORKDIR /tmp/pycsw

RUN pip3 install --upgrade pip setuptools \
    && pip3 install wheel \
    && pip3 install parmap \
    && pip3 install lxml \
    && pip3 install xmltodict \
    && pip3 install gunicorn \
    && pip3 install sqlalchemy \
    && pip3 install psycopg2 \
    && pip3 install pycsw

# We are installing pycsw from pip
# I leave the lines below commented
# for when we want to build from a pycsw repo (or fork)
#
# RUN git clone https://github.com/geopython/pycsw.git \
#     && cd pycsw \
#     && pip3 install -r requirements.txt \
#     && pip3 install -r requirements-standalone.txt \
#     && pip3 install -r requirements-pg.txt \
#     && python3 setup.py build \
#     && python3 setup.py install \
#     && cp default-sample.cfg default.cfg \
#     && cp docker/entrypoint.py /usr/local/bin/entrypoint.py \
#     && chmod a+x /usr/local/bin/entrypoint.py


# Note in the instruction above I added some extra packages:
# git - to clone pycsw repo or install with pip directly form github
# bash - for interactive docker session
# postgresql-dev, psycopg2 - for postgres backend
# parmap - to easy parallelize routines like mmd2iso
# xmltodict - pythonic way to work on xml 

ENV PYCSW_CONFIG=/etc/pycsw/pycsw.cfg

ADD volumes/conf/pycsw.cfg ${PYCSW_CONFIG}
ADD volumes/commands/entrypoint.py /usr/local/bin/entrypoint.py

RUN mkdir -p /etc/pycsw \
  && mkdir /var/lib/pycsw \
  && chown pycsw:pycsw /var/lib/pycsw

RUN apk add sqlite --no-cache
RUN apk del .build-deps

WORKDIR /home/pycsw

USER pycsw

EXPOSE 8000

ENTRYPOINT [\
  "python3", \
  "/usr/local/bin/entrypoint.py" \
]
