build:
	docker build --tag neovim:dev .

launch: build
  docker run -d \
    --name neodev \
    -v `pwd`:/edit \
    -v /tmp/nvimsocket:/tmp/nvimsocket \
    -w /edit \
    neovim:dev

attach:
  docker exec -it neodev bash
