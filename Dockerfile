# Copyright (c) 2016, Alexandre Hamelin <alexandre.hamelin gmail.com>

FROM debian-small
MAINTAINER Alexandre Hamelin <alexandre.hamelin gmail.com>
LABEL description="Base system to run Trac in a Gentoo environment" \
      copyright="(c) 2016, Alexandre Hamelin <alexandre.hamelin gmail.com>" \
      license="MIT"

ARG TRAC_ROOT=/trac

RUN apt-get update && apt-get install -y python python-pip && \
    rm -fr /var/lib/apt/lists
RUN pip install trac

RUN (echo; echo) | trac-admin ${TRAC_ROOT} initenv
RUN trac-admin ${TRAC_ROOT} component remove component1 && \
    trac-admin ${TRAC_ROOT} component remove component2 && \
    trac-admin ${TRAC_ROOT} version remove 1.0 && \
    trac-admin ${TRAC_ROOT} version remove 2.0 && \
    trac-admin ${TRAC_ROOT} milestone remove milestone1 && \
    trac-admin ${TRAC_ROOT} milestone remove milestone2 && \
    trac-admin ${TRAC_ROOT} milestone remove milestone3 && \
    trac-admin ${TRAC_ROOT} milestone remove milestone4
RUN trac-admin ${TRAC_ROOT} permission add anonymous TRAC_ADMIN
RUN mkdir -p ${TRAC_ROOT}/files

ENV TRAC_ROOT ${TRAC_ROOT}
EXPOSE 80 443
VOLUME ${TRAC_ROOT}/db
CMD exec tracd -s ${TRAC_ROOT}
