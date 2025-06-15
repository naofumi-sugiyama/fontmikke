# ベースイメージ
FROM ruby:3.1.2

# 作業ディレクトリを作成
WORKDIR /myapp

# Gemfile だけを先にコピーして bundle install（キャッシュ活用）
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

# アプリケーションの全コードをコピー
COPY . .

# 静的ファイルをプリコンパイル（Importmap 用）
RUN RAILS_ENV=production bundle exec rails assets:precompile

# Puma を起動
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
