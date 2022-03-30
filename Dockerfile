FROM python:3.9.12-bullseye

RUN apt-get update

RUN pip install pipenv

RUN curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer \
    | bash
ENV PATH=/root/.pyenv/bin:$PATH
RUN git clone https://github.com/pyenv/pyenv.git /tmp/pyenv && \
    cd /tmp/pyenv/plugins/python-build && \
    ./install.sh && \
    rm -rf /tmp/pyenv



RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt-get install apt-transport-https ca-certificates gnupg -y
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update
RUN  apt-get install google-cloud-sdk -y
RUN  apt-get install google-cloud-sdk-app-engine-python -y
RUN  apt-get install google-cloud-sdk-app-engine-python-extras -y
RUN  apt-get install google-cloud-sdk-datastore-emulator -y

#RUN gcloud init --no-launch-browser
#RUN gcloud auth application-default login --no-launch-browser
#RUN  apt-get install python3.8-venv -y

RUN apt install nodejs -y
RUN apt install npm -y
RUN npm install -g n
RUN n stable


VOLUME ["/projects"]

EXPOSE 8080 8081 8090 8091 8092 27017 27018

ENTRYPOINT /bin/bash

CMD bash