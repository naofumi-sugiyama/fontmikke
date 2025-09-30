set -o errexit

echo "=== ビルド開始 ==="

# 環境情報の表示
echo "Ruby version: $(ruby -v)"
echo "Bundler version: $(bundle -v)"

# frozen mode を一時的に無効化
echo "=== Frozen mode 無効化 ==="
bundle config set --local frozen false

# Gemfile.lockを完全削除
echo "=== Gemfile.lock 削除 ==="
rm -f Gemfile.lock

# 問題のあるgemを完全削除
echo "=== 問題のあるgem削除 ==="
gem uninstall cgi erb --force --all || true

# Bundlerのクリーンアップ
echo "=== Bundle clean 実行 ==="
bundle clean --force

# gem環境のクリーンアップ
echo "=== Gem clean 実行 ==="
gem cleanup

# 依存関係の完全な再構築
echo "=== 依存関係の完全再構築 ==="
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