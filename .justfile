build tag:
	#!/usr/bin/env /bin/bash
	set -euo pipefail

	docker build \
		--build-arg DOTFILE_REPO_URL \
		--tag neovim:{{tag}} .

launch dir="." tag="stable":
	#!/usr/bin/env /bin/bash
	set -euo pipefail

	launch_path=$(grealpath {{dir}})
	name=$(basename ${launch_path})
	
	docker run \
		-v $(grealpath .):/edit \
		-w /edit \
		--name neovim-${name}-{{tag}} \
		-it --rm \
		neovim:{{tag}}

exp: 
	just build latest
	just launch . latest

run-locally:
	nvim --cmd "set runtimepath+=${PWD}" -u init.lua
