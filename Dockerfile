# FROM alpine
FROM anapsix/alpine-java:8_jdk

ADD https://github.com/EcoNinjas/page-image/raw/master/update-page.sh /econinja/update-page.sh
ADD https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein /usr/bin/lein

RUN apk update
RUN apk add ruby ruby-dev ruby-bundler ruby-json make gcc libc-dev g++ git libffi-dev zlib-dev rsync
RUN gem install --no-document jekyll
RUN chmod +x /usr/bin/lein
RUN sh /econinja/update-page.sh
RUN cd /econinja/server; lein uberjar
RUN chmod -R 777 /econinja
CMD cd /econinja/server; PAGE_ROOT=/econinja/page/_site lein ring server-headless
