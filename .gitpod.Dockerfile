FROM gitpod/workspace-full

USER root

RUN sh -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' &&\
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' &&\
    apt-get update &&\
    apt-get install -y \
        unzip \
        xvfb \
        libxi6 \
        libgconf-2-4 \
        fonts-ipafont-gothic \
        fonts-ipafont-mincho \
        google-chrome-stable &&\
    apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

COPY ./requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

USER gitpod
RUN cd /tmp &&\
    CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    wget http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip &&\
    unzip chromedriver_linux64.zip -d ~/bin/ &&\
    chmod -R 775 ~/bin/
