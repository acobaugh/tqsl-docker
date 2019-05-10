FROM centos:7

ENV URL http://www.arrl.org/files/file/LoTW%20Instructions/tqsl-latest.tar.gz

RUN yum install -y cmake openssl-devel libcurl-devel make gcc gcc-c++ 
RUN yum install libdb-devel -y
RUN mkdir /build \
 && curl $URL > /build/tqsl.tar.gz \
 && cd /build \
 && tar -xzvf tqsl.tar.gz \
 && cd tqsl-*
RUN yum install -y epel-release
RUN yum install expat-devel -y \
 && yum install wxGTK-devel -y
RUN cd /build/tqsl-* && cmake . \
 && make \
 && make install

ENTRYPOINT /usr/local/bin/tqsl
