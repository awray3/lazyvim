FROM python:3.11.1-alpine as builder

RUN apk add \
    alpine-sdk \
    bash \
    build-base \
    lazygit \
    coreutils \
    curl \
    git \
    fzf \
    ripgrep \
    npm \
    neovim \
    ripgrep \
    tar \
    unzip \
    gzip \
    --update

RUN pip3 install pynvim
RUN npm i -g neovim

# Copy over configuration
COPY . /root/.config/nvim
RUN cd /root/.config/nvim

# Install Lazy plugins
RUN nvim --headless -V2 +qall

# Container waits for user to log in and launch neovim currently.
CMD tail -f /dev/null
