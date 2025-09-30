set -o errexit

echo "=== ビルド開始 ==="

# 環境情報の表示
echo "Ruby version: $(ruby -v)"
echo "Bundler version: $(bundle -v)"

# frozen mode を一時的に無効化
echo "=== Frozen mode 無効化 ==="
bundle config set --local frozen false

# Bundlerのクリーンアップ
echo "=== Bundle clean 実行 ==="
bundle clean --force

# 完全な依存関係更新
echo "=== 依存関係の完全更新 ==="
bundle update

# gem環境のクリーンアップ
echo "=== Gem clean 実行 ==="
gem cleanup

# 依存関係の再インストール
echo "=== Bundle install 実行 ==="
bundle install --verbose

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