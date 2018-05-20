#!/usr/bin/env sh

sh /econinja/update-page.sh &
java -jar /econinja/server/econinja-rolling-standalone.jar
