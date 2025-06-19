# syntax=docker/dockerfile:1
FROM ruby:3.1.2

# Linux環境でも source install にする
ENV BUNDLE_FORCE_RUBY_PLATFORM=true

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Tailwind CSS の Linux バイナリをインストール
RUN curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64 \
    && chmod +x tailwindcss-linux-x64 \
    && mv tailwindcss-linux-x64 /usr/local/bin/tailwindcss

# 作業ディレクトリの設定
WORKDIR /myapp

# Gemfile を先にコピーし、bundle install
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# アプリ全体をコピー
COPY . /myapp

# Entrypoint スクリプトの設定
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# ポート開放
EXPOSE 3000

# メインプロセスの設定
CMD ["bin/rails", "server", "-b", "0.0.0.0"]