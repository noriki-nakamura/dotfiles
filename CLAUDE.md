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

## Install / deploy

Run `make` (or `make install`) from the repo root. It symlinks each file above
into place, overwriting whatever is already at the destination (no backup is
made). Re-running is safe (idempotent).

## Machine-specific variations

None yet. If a config needs to differ per machine or OS, prefer conditionals
inside the config file itself (most tools support this) over branching in
`bootstrap.sh`.
