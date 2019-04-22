#ARG IMAGE
#FROM ${IMAGE}

#ARG GO_TAGS
#ENV GO_TAGS=${GO_TAGS}

#RUN apt-get update && apt-get install -y --no-install-recommends \
#  git build-essential \
#  debhelper devscripts fakeroot git-buildpackage dh-make dh-systemd dh-golang \
#  libcairo2-dev \
#  libgtk-3-dev

# We cache go get gtk, to speed up builds.
#RUN go get -tags ${GO_TAGS} -v github.com/gotk3/gotk3/gtk/...

#ADD . ${GOPATH}/src/github.com/mcuadros/OctoPrint-TFT/
#RUN go get -tags ${GO_TAGS} -v ./...

#WORKDIR ${GOPATH}/src/github.com/mcuadros/OctoPrint-TFT/

ARG IMAGE
FROM ${IMAGE}

ARG GO_TAGS
ENV GO_TAGS=${GO_TAGS}

RUN echo "deb [check-valid-until=no] http://cdn-fastly.deb.debian.org/debian jessie main" > /etc/apt/sources.list.d/jessie.list
RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list
RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list
RUN apt-get -o Acquire::Check-Valid-Until=false update

RUN apt-get -o Acquire::Check-Valid-Until=false update && apt-get -o Acquire::Check-Valid-Until=false install -y --no-install-recommends \
  git build-essential \
  debhelper devscripts fakeroot git-buildpackage dh-make dh-systemd dh-golang \
  libcairo2-dev \
  libgtk-3-dev

# We cache go get gtk, to speed up builds.
#RUN go get -tags ${GO_TAGS} -v github.com/gotk3/gotk3/gtk/...

ADD . ${GOPATH}/src/github.com/mcuadros/OctoPrint-TFT/
#RUN go get -tags ${GO_TAGS} -v ./...

WORKDIR ${GOPATH}/src/github.com/mcuadros/OctoPrint-TFT/
