.PHONY: setup-gitignore

GITIGNORE_FILE = ~/.config/.gitignore

# Register global gitignore file
setup-gitignore:
	@if [ -f $(GITIGNORE_FILE) ]; then \
		echo "Setting up global gitignore..."; \
		git config --global core.excludesFile '$(GITIGNORE_FILE)'; \
	else \
		echo "File '$(GITIGNORE_FILE)' does not exist"; \
	fi \
