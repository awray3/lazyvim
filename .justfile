build:
	docker build --tag neovim:dev .

launch:
	docker run \
    -n neodev \
		-v `pwd`:/edit \
    -v /tmp/nvimsocket:/tmp/nvimsocket \
		-w /edit \
    neovim:dev

attach:
  docker run -it neodev bash
