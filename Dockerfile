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

# ChromeDriver
ENV CHROME_DRIVER_VERSION 2.37
RUN wget http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
  && unzip chromedriver_linux64.zip \
  && mv chromedriver /usr/local/bin/ \
  && rm chromedriver_linux64.zip

# GeckoDriver
ENV GECKO_DRIVER_VERSION 0.20.0
RUN wget https://github.com/mozilla/geckodriver/releases/download/v$GECKO_DRIVER_VERSION/geckodriver-v$GECKO_DRIVER_VERSION-linux64.tar.gz \
  && tar -xvzf geckodriver-v$GECKO_DRIVER_VERSION-linux64.tar.gz \
  && rm geckodriver-v$GECKO_DRIVER_VERSION-linux64.tar.gz \
  && chmod +x geckodriver \
  && mv geckodriver /usr/local/bin/
