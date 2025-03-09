fetch:
ifndef url
	@echo "Error: url parameter is required. Usage: make fetch url=<URL>"
	@exit 1
else
	@hash=$$(nix-prefetch-url --unpack $(url)) && nix hash convert --to sri --hash-algo sha256 $$hash
endif

fmt:
	nix fmt .

switch:
	nix run nix-darwin -- switch --flake ~/dotfile/config/nix-darwin --impure

.PHONY: fetch switch fmt
