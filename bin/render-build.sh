set -o errexit

echo "=== ビルド開始 ==="

# Bundlerのクリーンアップ
echo "=== Bundle clean 実行 ==="
bundle clean --force

# 特定のgemの個別アップデート
echo "=== cgi gem 個別アップデート ==="
bundle update cgi erb

# gem環境のクリーンアップ
echo "=== Gem clean 実行 ==="
gem cleanup

# 依存関係の再インストール
echo "=== Bundle install 実行 ==="
bundle install --verbose

echo "=== Bundler インストール完了 ==="

# アセットプリコンパイル
bundle exec rake assets:precompile
echo "=== アセットプリコンパイル完了 ==="

# データベースマイグレーション
bundle exec rake db:migrate
echo "=== データベースマイグレーション完了 ==="