set -o errexit

echo "=== ビルド開始 ==="
gem install bundler -v 2.4.22
echo "=== Bundler インストール完了 ==="

bundle install
echo "=== Bundle install 完了 ==="

bin/rails tailwindcss:build
echo "=== Tailwind CSS ビルド完了 ==="

bundle exec rake assets:precompile
echo "=== アセットプリコンパイル完了 ==="

bundle exec rake assets:clean
echo "=== アセットクリーン完了 ==="

echo "=== マイグレーション開始 ==="
RAILS_ENV=production bin/rails db:migrate
echo "=== マイグレーション完了 ==="

echo "=== Seed実行開始 ==="
RAILS_ENV=production bin/rails db:seed
echo "=== Seed実行完了 ==="

echo "=== ビルド全体完了 ==="