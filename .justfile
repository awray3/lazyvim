build:
	docker build --build-arg N_CORES=8 --tag neovim:dev .

attach:
  docker exec -it neodev bash

stop:
  docker rm --force neodev

launch: stop build
    docker run -d \
        --name neodev \
        -v `pwd`:/edit \
        -v /tmp/nvimsocket:/tmp/nvimsocket \
        -w /edit \
        neovim:dev
