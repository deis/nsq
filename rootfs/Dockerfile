FROM quay.io/deis/base:0.3.0

RUN adduser --system \
      --shell /bin/bash \
      --disabled-password \
      --home /opt/nsq \
      --group \
      nsq \
    && curl -Ls https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 > /usr/bin/jq \
    && chmod +x /usr/bin/jq \
    && curl -s https://s3.amazonaws.com/bitly-downloads/nsq/nsq-0.3.8.linux-amd64.go1.6.2.tar.gz | tar xz \
    && mv /nsq-0.3.8.linux-amd64.go1.6.2/bin/* /bin \
    && rm -r /nsq-0.3.8.linux-amd64.go1.6.2 \
    && mkdir /opt/nsq/data

COPY . /
RUN chown -R nsq:nsq /opt/nsq
USER nsq
