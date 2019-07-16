FROM alpine:3.10 as yaml

RUN set -ex \
  ; apk add --no-cache --virtual .build-deps \
        gcc \
        g++ \
        make \
        cmake \
        git \
        wget \
        unzip \
		bison \
		coreutils \
		dpkg-dev dpkg \
		flex

RUN set -ex \
  ; git clone --depth=1 git://github.com/lloyd/yajl \
  ; cd yajl \
  ; ./configure \
  ; make \
  ; make install

RUN set -ex \
  ; wget -O yaml.tar.gz http://pyyaml.org/download/libyaml/yaml-0.2.2.tar.gz \
  ; tar zxvf yaml.tar.gz \
  ; cd yaml-0.2.2 \
  ; ./configure \
  ; make \
  ; make install

RUN set -ex \
  ; git clone --depth=1 https://github.com/sjmulder/json-yaml.git \
  ; cd json-yaml \
  ; make \
  ; make check \
  ; make install

FROM nnurphy/jsonnet
ENV PATH=/usr/local/bin:$PATH
RUN apk add --no-cache jq
ENTRYPOINT [  ]
COPY --from=yaml /usr/local/lib /usr/local/lib
COPY --from=yaml /usr/local/bin/json-yaml /usr/local/bin
COPY ys /usr/local/bin