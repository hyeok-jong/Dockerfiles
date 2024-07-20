FROM nvcr.io/nvidia/pytorch:23.10-py3

# expose the VSCode server port
EXPOSE 8887

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
ARG DEBIAN_FRONTEND=noninteractive

# install basic ubuntu tools
RUN apt-get update && apt-get install -y --no-install-recommends \
         apt-transport-https \
         build-essential \
         ca-certificates \
         libssl-dev \
         git \
         curl \
         zip \
         unzip \
         bzip2 \
         htop \
         fonts-powerline \
         software-properties-common \
         tmux \
         cloc \
         nodejs \
         npm \
     && rm -rf /var/lib/apt/lists/*

# install latest nodejs
RUN npm install -g n
RUN n lts

# ---------
# MULTIVERSE
# ---------
RUN apt-get update
RUN apt-get install -y --no-install-recommends software-properties-common
RUN apt-add-repository multiverse
RUN apt-get update

# msttcorefonts
RUN echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections
RUN apt-get install -y --no-install-recommends fontconfig ttf-mscorefonts-installer
RUN fc-cache -f -v

# Hack as basic font
WORKDIR /tmp
RUN curl -LO https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip && \
        unzip ./Hack-v3.003-ttf.zip && \
        cp -r ./ttf /usr/share/fonts/truetype/Hack-font && \
        chmod 644 /usr/share/fonts/truetype/Hack-font/* && \
        fc-cache -f

# oh-my-zsh
RUN apt-get install -y zsh
RUN curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
RUN chsh -s $(which zsh)
CMD [ "/bin/zsh" ]

# install emacs 27
RUN apt-get update
# RUN apt-get install -y emacs

# install spacemacs
# RUN git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# install basic python tools
RUN pip install --upgrade pip
COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

# clean up
RUN ldconfig && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# set up code-server
RUN mkdir -p /root/.config/code-server
RUN echo "bind-addr: 0.0.0.0:8887" > /root/.config/code-server/config.yaml
RUN echo "auth: password" >> /root/.config/code-server/config.yaml
RUN echo "password: PASSWORD_HERE" >> /root/.config/code-server/config.yaml
RUN echo "cert: true" >> /root/.config/code-server/config.yaml

WORKDIR /home/test

CMD ["code-server"]
