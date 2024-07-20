# FROM pytorch/pytorch:1.8.1-cuda10.2-cudnn7-runtime
FROM nvcr.io/nvidia/pytorch:21.02-py3
# https://docs.nvidia.com/deeplearning/frameworks/pytorch-release-notes/rel_18-01.html
EXPOSE 8887 3001
# 8887 : jupyterlab web interface
# 3001 : json-rpc server

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
# RUN add-apt-repository ppa:kelleyk/emacs
RUN apt-get update
RUN apt-get install -y emacs
# install spacemacs
RUN git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# install basic python tools
RUN pip install --upgrade pip
COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt
# RUN pip install --upgrade -r /tmp/requirements.txt

RUN jupyter lab clean
RUN jupyter lab build --dev-build=False --minimize=False

COPY server.yml /tmp
CMD ["node","usr/local/share/jupyter/lab/staging/node_modules/jsonrpc-ws-proxy/dist/server.js","--port 3001","--languageServers","/tmp/server.yml"]

# clean
RUN ldconfig && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

WORKDIR /home/{directory}
RUN jupyter server --generate-config
RUN echo "c.ServerApp.token=''">>/root/.jupyter/jupyter_server_config.py
RUN echo "c.ServerApp.open_browser = False">>/root/.jupyter/jupyter_server_config.py
RUN echo "c.ServerApp.password=u'ar'">>/root/.jupyter/jupyter_server_config.py
RUN echo "c.ServerApp.password=u'sha1:94511993b3f59:49abb592252abccdf02693b3bc2ad15526254d3a0'">>/root/.jupyter/jupyter_server_config.py
RUN echo "c.ServerApp.port = 8887">>/root/.jupyter/jupyter_server_config.py

WORKDIR /home
