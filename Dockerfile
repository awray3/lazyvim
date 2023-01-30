FROM python:3.11.1-bullseye

RUN set -eux; apt-get update && apt-get install -y \
    autoconf \
    automake \
    cmake \
    curl \
    doxygen \
    g++ \
    gettext \
    git \
    libtool \
    libtool-bin \
    ninja-build \
    npm \
    pkg-config \
    ripgrep \
    tar \
    unzip \
    gzip

WORKDIR /build

# install Lazygit
ARG LG_BIN="https://github.com/jesseduffield/lazygit/releases/download/v0.36.0/lazygit_0.36.0_Linux_arm64.tar.gz"
RUN curl -Lo lazygit.tar.gz $LG_BIN
# ARG LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
# RUN curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_arm64.tar.gz"
RUN tar xf lazygit.tar.gz lazygit && mv lazygit /usr/local/bin && rm lazygit.tar.gz
# end install lazygit

# Install neovim
# # dependencies
RUN pip3 install pynvim
RUN npm i -g neovim

# Install Neovim from source.
ARG NVIM_TAG="v0.8.2"
ARG N_CORES=1
ENV RELEASE_URL="https://github.com/neovim/neovim/archive/refs/tags/${NVIM_TAG}.tar.gz"
RUN curl -Lo neovim.tar.gz $RELEASE_URL
RUN tar xf neovim.tar.gz && mv neovim-* neovim

WORKDIR /build/neovim
RUN make -j${N_CORES} && make install
WORKDIR /build
RUN rm -rf neovim
# End neovim install

# Copy over configuration
COPY . /root/.config/nvim
RUN cd /root/.config/nvim

# RUN nvim +Lazy update +qall

CMD tail -f /dev/null
