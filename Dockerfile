FROM alpine
# FROM anapsix/alpine-java:8_jdk

RUN apk --update add --no-cache ruby ruby-dev ruby-bundler ruby-json make gcc libc-dev g++ git libffi-dev zlib-dev rsync openjdk8-jre; rm -fr /var/cache/apk/*
RUN gem install --no-document jekyll

ADD ./update-page.sh /econinja/update-page.sh
RUN sh /econinja/update-page.sh --firstrun

RUN mkdir -p /econinja/server
ADD ./econinja-rolling-standalone.jar /econinja/server/econinja-rolling-standalone.jar
RUN chmod -R 777 /econinja

ADD ./start.sh /econinja/start.sh
CMD PAGE_ROOT=/econinja/page/_site UPDATE_SCRIPT=/econinja/update-page.sh sh /econinja/start.sh
