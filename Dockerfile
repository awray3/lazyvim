FROM python:3.11.1-alpine as builder

RUN apk add git lazygit neovim neovim-doc fzf alpine-sdk --update

COPY . /root/.config/nvim
RUN cd /root/.config/nvim

RUN nvim --headless +Lazy sync +qall
RUN nvim --headless +TSInstall +qall
RUN nvim --headless +TSUpdate +qall

CMD nvim