fetch:
ifndef url
	@echo "Error: url parameter is required. Usage: make fetch url=<URL>"
	@exit 1
else
	@hash=$$(nix-prefetch-url --unpack $(url)) && nix hash convert --to sri --hash-algo sha256 $$hash
endif
.PHONY: fetch

