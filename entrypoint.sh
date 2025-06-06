#!/bin/bash
set -e

echo "=== Rails Entrypoint Script ==="

# データベースが存在しない場合は作成
if [ ! -f /app/db/development.sqlite3 ]; then
  echo "データベースが見つかりません。作成中..."
  bundle exec rails db:create
fi

# マイグレーションを実行
echo "マイグレーションを実行中..."
bundle exec rails db:migrate

# シードデータがあれば実行（オプション）
# bundle exec rails db:seed

echo "=== アプリケーションを起動中 ==="

# メインプロセスを実行
exec "$@" 