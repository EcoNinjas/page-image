# FROM alpine
FROM anapsix/alpine-java:8_jdk

COPY update-page.sh /econinja/update-page.sh

RUN apk update
RUN apk add ruby ruby-dev ruby-bundler ruby-json make gcc libc-dev g++ git libffi-dev zlib-dev rsync
RUN gem install --no-document jekyll
ADD https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein /usr/bin/lein
RUN chmod +x /usr/bin/lein
RUN sh /econinja/update-page.sh
RUN cd /econinja/server; lein deps
CMD sh /econinja/update-page.sh; cd /econinja/server; lein run
