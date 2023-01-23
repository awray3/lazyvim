FROM gitpod/workspace-full:latest

RUN brew install neovim just rg fzf tldr sk vcsh starship zsh lsd bat

RUN git config --global init.defaultBranch main

# Install zsh
RUN rm ~/.zshrc
RUN vcsh clone https://github.com/awray3/dotfiles-zsh zsh && vcsh zsh fetch origin try-zellij && vcsh zsh checkout try-zellij

RUN vcsh clone https://github.com/awray3/dotfiles-vscodevim vscodevim

RUN vcsh clone https://github.com/awray3/dotfiles-starship starship

# Install nerd font
RUN wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.0/CascadiaCode.zip && unzip CascadiaCode.zip -d ~/.fonts && fc-cache -fv

ENTRYPOINT $(brew --prefix)/bin/zsh