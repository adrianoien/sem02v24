FROM ubuntu:24.04
RUN apt-get update \
&& apt-get dist-upgrade -y \
&& apt-get autoremove -y \
&& apt-get autoclean -y \
&& apt-get install -y \
sudo \
nano \
wget \
curl \
git
RUN useradd -G sudo -m -d /home/adrianoien -s /bin/bash -p "$(openssl 123 -1 123)" adrianoien
USER adrianoien
WORKDIR /home/adrianoien
RUN mkdir hacking \
&& cd hacking \
&& curl -SL https://raw.githubusercontent.com/uia-worker/is105misc/master/sem01v24/pawned.sh > pawned.sh \
&& chmod 764 pawned.sh \
&& cd ..
RUN git config --global user.email "adrian.oien@live.no" \
&& git config --global user.name "adrianoien" \
&& git config --global url."https://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:@github.com/".insteadOf "https://github.com" \
&& mkdir -p github.com/adrianoien/sem02v24
USER root
RUN curl -SL https://go.dev/dl/go1.21.7.linux-amd64.tar.gz \
| tar xvz -C /usr/local
USER adrianoien
SHELL ["/bin/bash", "-c"]
RUN mkdir -p $HOME/go/{src,bin}
ENV GOPATH="/home/adrianoien/go"
ENV PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"