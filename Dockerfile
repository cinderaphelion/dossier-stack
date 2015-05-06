FROM ubuntu:14.04
MAINTAINER Diffeo <support@diffeo.com>

RUN apt-get update -y && apt-get install -y python python-pip

RUN apt-get install -y \
      make libz-dev libxslt1-dev libxml2-dev python-dev \
      python-virtualenv g++ xz-utils gfortran liblzma-dev \
      libpq-dev libfreetype6-dev libblas-dev liblapack-dev \
      libboost-python-dev libsnappy1 libsnappy-dev \
      libjpeg-dev zlib1g-dev libpng12-dev

# We could install these with `pip`, but this is so much faster.
RUN apt-get install -y \
      python-numpy python-scipy python-sklearn python-matplotlib \
      python-gevent uwsgi

# Download and install the NLTK corpus.
RUN pip install nltk \
 && python -m nltk.downloader -d /usr/share/nltk_data all

# Upgrade pip.
RUN pip install --upgrade pip

# Now install dossier.models.
RUN pip install --pre 'dossier.models>=0.6.4'

ADD config.yaml /config.yaml
ADD background-50000.tfidf.gz /
RUN gunzip /background-50000.tfidf.gz

# Finally, run the dossier.models web server.
ENV PROCESSES 4
EXPOSE 57312
CMD uwsgi \
      --http-socket 0.0.0.0:57312 \
      --wsgi dossier.models.web.wsgi \
      --pyargv "-c /config.yaml" \
      --master \
      --processes $PROCESSES \
      --vacuum \
      --max-requests 5000
