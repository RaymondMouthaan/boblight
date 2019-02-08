ARG S6_ARCH
FROM arm32v6/alpine:3.9

# Define ARGs again to make them available after FROM
ARG BUILD_DATE
ARG BUILD_VERSION
ARG BUILD_REF

# Basic build-time metadata as defined at http://label-schema.org
LABEL org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.docker.dockerfile="Dockerfile" \
    org.label-schema.license="GNU" \
    org.label-schema.name="boblightd" \
    org.label-schema.version=${BUILD_VERSION} \
    org.label-schema.description="" \
    org.label-schema.url="" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-url="" \
    maintainer="Raymond M Mouthaan <raymondmmouthaan@gmail.com>"

RUN apk add --no-cache git make g++ autoconf libtool libusb portaudio \
  && mkdir /boblightd

COPY . /boblightd

RUN cd /boblightd \
  && ./autogen.sh \
  && ./configure --without-x11 --prefix=/usr \
  && make \
  && make install

#WORKDIR /homebridge
#VOLUME /homebridge
