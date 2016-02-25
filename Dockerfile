# Copyright (c) 2016, Alexandre Hamelin <alexandre.hamelin gmail.com>

FROM debian-small
MAINTAINER Alexandre Hamelin <alexandre.hamelin gmail.com>
LABEL description="Base system to run Trac in a Gentoo environment" \
      copyright="(c) 2016, Alexandre Hamelin <alexandre.hamelin gmail.com>" \
      license="MIT"

ARG TRAC_ROOT=/trac

RUN apt-get update && apt-get install -y python python-pip && \
    rm -fr /var/cache/apt/lists
RUN pip install trac
COPY run.sh /usr/local/bin/

ENV TRAC_ROOT ${TRAC_ROOT}
EXPOSE 80 443
VOLUME ${TRAC_ROOT}/db
CMD ["run.sh"]
