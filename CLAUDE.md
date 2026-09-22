# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This repository manages configuration files ("dotfiles") for middleware in a Linux
environment — for example Vim, tmux, and Claude Code.

## Layout

One directory per tool, mirroring the file's role at the destination:

- `tmux/tmux.conf`, `tmux/tmux-sysinfo.sh` — deployed to `~/.tmux.conf`
- `claude/CLAUDE.md` — deployed to `~/.claude/CLAUDE.md` (global, cross-project
  Claude Code instructions; distinct from per-project `CLAUDE.md` files like
  this one, which live in their own repos)
- `ansible/` — Ansible playbook and roles that provision the machine (install
  Claude Code, NeoVim, AWS CLI) and deploy the dotfiles above via symlinks

## Install / deploy

Run `./bootstrap.sh` from the repo root. It installs Ansible itself if missing
(via `dnf`, solving the chicken-and-egg problem), then runs
`ansible-playbook ansible/site.yml`, which symlinks the dotfiles above into
place (overwriting whatever is already at the destination, no backup made)
and installs Claude Code / NeoVim / AWS CLI if not already present.
Re-running is safe (idempotent). Only `dnf`-based distros are supported today.

If Ansible is already installed, you can skip `bootstrap.sh` and run
`ansible-playbook -i ansible/inventory.ini ansible/site.yml` directly.

## Machine-specific variations

None yet. If a config needs to differ per machine or OS, prefer conditionals
inside the config file itself, or `when:` conditions inside the relevant
Ansible role/task, over branching in `bootstrap.sh`.

## Working style

This repo manages the local development environment directly (dotfiles are
symlinked into `$HOME`). Do not isolate work in a `git worktree` here — edit
files directly in this checkout instead. A worktree is a separate copy, and
edits there don't affect the real local config until merged back, which
defeats the point of quick, direct edits. (`.claude/settings.json` sets
`worktree.bgIsolation` to `"none"` so background sessions aren't forced into
a worktree either.)
