FROM shippableimages/ubuntu1404_base:latest

RUN apt-get update && apt-get install -y \
    binutils \
    bison \
    curl \
    gcc \
    make \
    mercurial;

RUN export HOME=/root && curl -s -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash;

RUN /bin/bash -c ". /root/.gvm/scripts/gvm && gvm install go1.1 --prefer-binary";
RUN /bin/bash -c ". /root/.gvm/scripts/gvm && gvm install go1.2 --prefer-binary";
RUN /bin/bash -c ". /root/.gvm/scripts/gvm && gvm install go1.3 --prefer-binary";
RUN /bin/bash -c ". /root/.gvm/scripts/gvm && gvm install go1.4 --prefer-binary";
RUN /bin/bash -c ". /root/.gvm/scripts/gvm && (gvm install release --prefer-binary || true)";
RUN /bin/bash -c ". /root/.gvm/scripts/gvm && (gvm install tip --prefer-binary || true)";

env GVM_ROOT /root/.gvm
env PATH $PATH:/root/.gvm/bin

CMD ["/bin/bash"]
