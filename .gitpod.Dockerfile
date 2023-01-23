FROM gitpod/workspace-full:latest

RUN brew install neovim just rg fzf tldr
RUN brew install sk vcsh starship zsh lsd bat

RUN git config --global init.defaultBranch main

# Install zsh
RUN rm ~/.zshrc
RUN vcsh clone https://github.com/awray3/dotfiles-zsh zsh

RUN vcsh clone https://github.com/awray3/dotfiles-vscodevim vscodevim

RUN vcsh clone https://github.com/awray3/dotfiles-starship starship

ENV SHELL=/home/linuxbrew/.linuxbrew/bin/zsh
# ENTRYPOINT $(brew --prefix)/bin/zsh