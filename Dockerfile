# syntax=docker/dockerfile:1
FROM ruby:3.1.2

# Node.js + npm + Yarn をインストール
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get update -qq \
  && apt-get install -y nodejs postgresql-client \
  && npm install -g yarn

# Tailwind CSS CLI (Linux x64) をインストール
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