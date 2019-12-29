FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y -q install \
        apt-utils \
        build-essential \
        curl \
        debhelper \
        devscripts \
        dh-exec \
        dh-python \
        equivs \
        git \
        python-dev \
        python-mock \
        python-pip \
        python-setuptools \
        python-sphinx \
        python-sphinx-rtd-theme \
        python-virtualenv \
        unzip \
        virtualenv \
        && rm -rf /var/lib/apt/lists/*

COPY dh-virtualenv /tmp/dh-virtualenv
RUN cd /tmp/dh-virtualenv && \
	debuild -us -uc -b && \
	dpkg -i /tmp/dh-virtualenv*.deb

RUN pip install setuptools-scm==3.1.0 pipenv==2018.11.26
COPY docker-debuild /usr/local/bin/docker-debuild
CMD ["/bin/bash"]
