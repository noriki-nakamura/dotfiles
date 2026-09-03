.DEFAULT_GOAL := install

DOTFILES_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: install
install:
	mkdir -p $(HOME)/.claude
	ln -sf $(DOTFILES_DIR)tmux/tmux.conf $(HOME)/.tmux.conf
	ln -sf $(DOTFILES_DIR)claude/CLAUDE.md $(HOME)/.claude/CLAUDE.md
