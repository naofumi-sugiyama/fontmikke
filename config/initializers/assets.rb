# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# app/assets/builds をアセットパスに追加
Rails.application.config.assets.paths << Rails.root.join("app/assets/builds")

# tailwind.css をプリコンパイル対象に追加
Rails.application.config.assets.precompile += %w( tailwind.css )