FROM python:3.11.1-bullseye

RUN set -eux; apt-get update && apt-get install -y \
    curl \
    git \
    ripgrep \
    tar

WORKDIR /build

ARG LG_BIN="https://github.com/jesseduffield/lazygit/releases/download/v0.36.0/lazygit_0.36.0_Linux_arm64.tar.gz"
RUN curl -Lo lazygit.tar.gz $LG_BIN
# ARG LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
# RUN curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_arm64.tar.gz"
RUN tar xf lazygit.tar.gz lazygit

COPY . /root/.config/nvim
RUN cd /root/.config/nvim

# RUN nvim +Lazy update +qall

CMD tail -f /dev/null
