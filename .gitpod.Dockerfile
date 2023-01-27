FROM gitpod/workspace-python-3.11:2023-01-16-03-31-28

# install brew
USER gitpod
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
    && echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /home/gitpod/.profile \
    && echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/gitpod/.profile \
    && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install brew deps
RUN curl -LO https://gist.github.com/awray3/f668074ab7f74b2fe3285eed00ca2ffc -o ~/Brewfile \
    && brew bundle install --file=~/Brewfile

RUN git config --global init.defaultBranch main

# Install zsh
RUN rm -f ~/.zshrc
RUN vcsh clone https://github.com/awray3/dotfiles-zsh zsh

RUN vcsh clone https://github.com/awray3/dotfiles-vscodevim vscodevim

RUN vcsh clone https://github.com/awray3/dotfiles-starship starship

ENV SHELL=/home/linuxbrew/.linuxbrew/bin/zsh