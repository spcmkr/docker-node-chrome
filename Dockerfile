FROM ubuntu:16.04

RUN apt-get -y update \
      && apt-get -y install curl wget bzip2 unzip

# Node.js

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - \
	&& apt-get install -y nodejs \
	&& rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Xvfb

RUN apt-get update -qqy \
	&& apt-get -qqy install xvfb \
	&& rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Google Chrome

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
	&& apt-get update -qqy \
	&& apt-get -qqy install google-chrome-stable \
	&& rm /etc/apt/sources.list.d/google-chrome.list \
	&& rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
	&& sed -i 's/"$HERE\/chrome"/xvfb-run "$HERE\/chrome" --no-sandbox/g' /opt/google/chrome/google-chrome

# Netcat

RUN apt-get -y update \
    && apt-get -y install netcat

# Firefox

RUN apt-get -y update \
    && apt-get -y install firefox

# Angular webdriver-manager
RUN npm install -g webdriver-manager \
    && webdriver-manager update

# MongoDB Client
RUN apt-get -y update \
  && apt-get -y install mongodb-clients

