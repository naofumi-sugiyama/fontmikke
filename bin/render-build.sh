set -o errexit

echo "=== vendor/bundle削除 ==="
rm -rf vendor/bundle

echo "=== ビルド開始 ==="

# Gemfile.lockの存在確認
ls -l Gemfile.lock

# 環境情報の表示
echo "Ruby version: $(ruby -v)"
echo "Bundler version: $(bundle -v)"

# bundle config
bundle config set --local path 'vendor/bundle'

# 依存関係インストール
echo "=== Bundle install 実行 ==="
bundle install --verbose --retry=3

echo "=== Bundler インストール完了 ==="

# TailwindCSS ビルド
echo "=== Tailwind CSS ビルド ==="
bin/rails tailwindcss:build

# アセットプリコンパイル
bundle exec rake assets:precompile
echo "=== アセットプリコンパイル完了 ==="

# データベースマイグレーション
bundle exec rake db:migrate
echo "=== データベースマイグレーション完了 ==="

echo "=== ビルド完了 ==="