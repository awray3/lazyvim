# docker build --build-arg N_CORES=8 --tag neovim:dev .
build:
    docker build --tag neovim:dev .

stop:
  docker rm --force neodev

launch: stop build
    docker run -d \
        --name neodev \
        -v {{invocation_directory()}}:/edit \
        -w /edit \
        neovim:dev

attach: launch
  docker exec -it neodev bash

nvim: launch
    docker exec -it neodev nvim

update: launch
  docker exec -it neodev nvim -c ":Lazy update"

health: launch
  docker exec -it neodev nvim -c ":checkhealth"

l: launch
a: attach
u: update
h: health
n: nvim
