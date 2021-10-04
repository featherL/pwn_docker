FROM ubuntu:20.04
MAINTAINER fe4ther <featherm@126.com>

    
ENV LANG     zh_CN.UTF-8
ENV LANGUAGE zh_CN.UTF-8
ENV LC_ALL   zh_CN.UTF-8

# mirrors
ARG DEBIAN_FRONTEND=noninteractive
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    dpkg --add-architecture i386 && \
    apt-get -y update && \
    apt install -y build-essential \
    libc6:i386 libc6-dbg:i386 libc6-dbg lib32stdc++6 \
    g++-multilib cmake vim net-tools python-dev python3-dev python3-pip tmux \
    ruby ruby-dev \
    strace ltrace \
    gdb gdb-multiarch \
    wget zstd locales \
    netcat \
    git \
    zsh \
    musl-tools \
    automake autoconf libtool \
    pkg-config libglib2.0-dev libpixman-1-dev bison flex && \
    rm -rf /var/lib/apt/list/* && \
    locale-gen zh_CN zh_CN.UTF-8 && \
    ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# ninja
RUN git clone --depth 1 git://github.com/ninja-build/ninja.git && \
    cd ninja && \
    ./configure.py --bootstrap && \
    cp ninja /bin/ && \
    cd / && \
    rm -rf ninja


# qemu
RUN wget -q https://download.qemu.org/qemu-6.0.0.tar.xz && \
    tar xf qemu-6.0.0.tar.xz && \
    cd qemu-6.0.0 && \
    mkdir build && \
    cd build && \
    ../configure --enable-debug && \
    make -j$(nproc) && \
    make install && \
    cd / && \
    rm -rf qemu-6.0.0*


# zsh
RUN chsh -s /bin/zsh && \
    sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
COPY .zshrc /root/.zshrc

# pwntools
RUN pip install pip -U -i https://pypi.tuna.tsinghua.edu.cn/simple && \
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
    pip install pwntools ropper 

RUN gem install one_gadget seccomp-tools && rm -rf /var/lib/gems/2.*/cache/*

# pwndbg
RUN git clone --depth 1 https://github.com/pwndbg/pwndbg && \
    cd pwndbg && chmod +x setup.sh && ./setup.sh

# pwngdb
RUN git clone --depth 1 https://github.com/scwuaptx/Pwngdb.git /root/Pwngdb && \
    cat /root/Pwngdb/.gdbinit  >> /root/.gdbinit && \
    sed -i "s?source ~/peda/peda.py?# source ~/peda/peda.py?g" /root/.gdbinit

# libcdb
RUN git clone --depth 1 https://github.com/niklasb/libc-database.git libc-database && \
    cd libc-database && ./get ubuntu debian || echo "/libc-database/" > ~/.libcdb_path

# patchelf
RUN git clone --depth 1 https://github.com/NixOS/patchelf.git && \
    cd patchelf && \
    ./bootstrap.sh && \
    ./configure && \
    make && \
    make install && \
    cd / && \
    rm -rf patchelf

# glibc all in one
RUN git clone --depth 1 https://github.com/matrix1001/glibc-all-in-one.git && \
    cd glibc-all-in-one && \
    python3 ./update_list && \
    for id in $(cat list); do ./download $id; done;

# linux_server
COPY ./linux_server32v76 ./linux_server32v76
COPY ./linux_server64v76 ./linux_server64v76


CMD /bin/zsh


