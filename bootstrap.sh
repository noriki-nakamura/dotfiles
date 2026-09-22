#!/usr/bin/env bash
# Ansible 自体が入っていない鶏卵問題を解決するためのブートストラップスクリプト。
# Ansible をインストールしたら、あとは ansible-playbook に処理を引き継ぐ。
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v ansible-playbook >/dev/null 2>&1; then
  if ! command -v dnf >/dev/null 2>&1; then
    echo "dnf が見つかりません。このスクリプトは dnf 系ディストリビューション専用です。" >&2
    echo "Ansible を手動でインストールしてから ansible-playbook を実行してください。" >&2
    exit 1
  fi
  echo "Ansible が見つからないため、dnf でインストールします..."
  sudo dnf install -y ansible-core
fi

exec ansible-playbook -i "$DIR/ansible/inventory.ini" "$DIR/ansible/site.yml" "$@"
