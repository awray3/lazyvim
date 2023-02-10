FROM python:3.12.0a5-alpine as builder

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
    neovim-doc \
    ripgrep \
    stylua \
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
RUN nvim --headless -V +qall

CMD tail -f /dev/null
