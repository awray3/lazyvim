FROM python:3.11.1-alpine as builder

RUN apk add \
    alpine-sdk \
    autoconf \
    automake \
    bash \
    build-base \
    lazygit \
    cmake \
    coreutils \
    curl \
    doxygen \
    g++ \
    git \
    gettext-tiny-dev \
    libtool \
    fzf \
    npm \
    ninja \
    pkgconf \
    ripgrep \
    tar \
    unzip \
    gzip \
    --update


WORKDIR /build

# install Lazygit
# ARG LG_BIN="https://github.com/jesseduffield/lazygit/releases/download/v0.36.0/lazygit_0.36.0_Linux_arm64.tar.gz"
# RUN curl -Lo lazygit.tar.gz $LG_BIN
# # ARG LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
# # RUN curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_arm64.tar.gz"
# RUN tar xf lazygit.tar.gz lazygit && mv lazygit /usr/local/bin && rm lazygit.tar.gz
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

### build
WORKDIR /build/neovim
RUN make -j${N_CORES} && make install

### cleanup
WORKDIR /build
RUN rm -rf neovim
# End neovim install

# Copy over configuration
COPY . /root/.config/nvim
RUN cd /root/.config/nvim

# Container waits for user to log in and launch neovim currently.
CMD tail -f /dev/null

# RUN nvim --headless +Lazy sync +qall

