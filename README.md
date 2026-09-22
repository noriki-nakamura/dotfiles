# dotfiles

Linux 環境のミドルウェア向け設定ファイル(dotfiles)を管理するリポジトリ。

## レイアウト

配置先での役割ごとに、ツールごとのディレクトリで管理する。

- `tmux/tmux.conf`, `tmux/tmux-sysinfo.sh` — `~/.tmux.conf` へ配置
- `claude/CLAUDE.md` — `~/.claude/CLAUDE.md` へ配置(全プロジェクト共通の
  Claude Code 用グローバル指示。各リポジトリ固有の `CLAUDE.md` とは別物)
- `ansible/` — マシンのプロビジョニング用 Ansible playbook / role 一式
  (Claude Code, NeoVim, AWS CLI のインストールと、上記 dotfiles のシンボリック
  リンク配置を担当)

## インストール

リポジトリのルートで `./bootstrap.sh` を実行する。

```sh
./bootstrap.sh
```

`bootstrap.sh` は Ansible 自体が入っていない場合にまず `dnf` で
`ansible-core` をインストールし(鶏卵問題の解決)、続けて
`ansible-playbook ansible/site.yml` を実行する。これにより上記の dotfiles が
シンボリックリンクとして配置され(配置先に既存のファイルがあっても上書き、
バックアップは取らない)、Claude Code / NeoVim / AWS CLI が未導入であれば
インストールされる。再実行しても安全(冪等)。対応しているのは現時点で
`dnf` 系ディストリビューションのみ。

すでに Ansible が入っている場合は `bootstrap.sh` を使わず、直接
`ansible-playbook -i ansible/inventory.ini ansible/site.yml` を実行してもよい。

## マシンごとの差分

現時点ではなし。設定がマシンや OS によって異なる必要が生じた場合は、
`bootstrap.sh` 側で分岐するのではなく、各設定ファイル内の条件分岐や
Ansible の role/task 内の `when:` 条件分岐(多くのツールがサポートしている)
を優先する。
