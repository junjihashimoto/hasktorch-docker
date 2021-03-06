FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
MAINTAINER Junji Hashimoto "junji.hashimoto@gree.net"
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN apt-get update -qq && apt-get -y --force-yes install software-properties-common python-software-properties apt-transport-https
RUN add-apt-repository ppa:hvr/ghc
RUN apt-get update -qq && apt-get -y --force-yes install curl  git build-essential libtinfo-dev libssl-dev  ghc-8.4.4 cabal-install-head
ENV PATH /opt/ghc/bin:$PATH
RUN cabal update
RUN git clone --recursive https://github.com/hasktorch/hasktorch.git
RUN apt-get install -y --force-yes cmake python3-pip python3-yaml
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
RUN cd hasktorch/ffi/deps && ./build-aten.sh && cd ../../..
RUN cd hasktorch && make init && cd ..
RUN cd hasktorch && cabal new-build all && cd ..
