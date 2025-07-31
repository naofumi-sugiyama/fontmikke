puts "=== Seed実行開始 ==="
puts "Rails環境: #{Rails.env}"
puts "現在のFont数: #{Font.count}"

begin
  fonts_data = [
  {
    name: "Noto Serif JP",
    style: "明朝体",
    genre: "上品",
    font_url: "https://fonts.googleapis.com/css2?family=Noto+Serif+JP:wght@200..900&display=swap",
    download_url: "https://fonts.google.com/noto/specimen/Noto+Serif+JP",
    commercial_use: true,
    license_type: "SIL Open Font License",
    license_url: "https://openfontlicense.org/"
  },

  {
    name: "さわらび明朝",
    style: "明朝体",
    genre: "上品",
    font_url: "https://fonts.googleapis.com/css2?family=Sawarabi+Mincho&display=swap",
    download_url: "https://fonts.google.com/specimen/Sawarabi+Mincho",
    commercial_use: true,
    license_type: "SIL Open Font License",
    license_url: "https://openfontlicense.org/"
  },

  {
    name: "Noto Sans JP",
    style: "ゴシック体",
    genre: "ビジネス",
    font_url: "https://fonts.googleapis.com/css2?family=Noto+Sans+JP&display=swap",
    download_url: "https://fonts.google.com/specimen/Noto+Sans+JP",
    commercial_use: true,
    license_type: "SIL Open Font License",
    license_url: "https://openfontlicense.org/"
  },

  {
    name: "M PLUS 1p",
    style: "ゴシック体",
    genre: "ビジネス",
    font_url: "https://fonts.googleapis.com/css2?family=M+PLUS+1p&display=swap",
    download_url: "https://fonts.google.com/specimen/M+PLUS+1p",
    commercial_use: true,
    license_type: "SIL Open Font License",
    license_url: "https://openfontlicense.org/"
  },

  {
    name: "Dela Gothic One",
    style: "ゴシック体",
    genre: "インパクト",
    font_url: "https://fonts.googleapis.com/css2?family=Dela+Gothic+One&display=swap",
    download_url: "https://fonts.google.com/specimen/Dela+Gothic+One",
    commercial_use: true,
    license_type: "SIL Open Font License",
    license_url: "https://openfontlicense.org/"
  },

  {
    name: "M PLUS Rounded 1c",
    style: "丸ゴシック体",
    genre: "かわいい",
    font_url: "https://fonts.googleapis.com/css2?family=M+PLUS+Rounded+1c&display=swap",
    download_url: "https://fonts.google.com/specimen/M+PLUS+Rounded+1c",
    commercial_use: true,
    license_type: "SIL Open Font License",
    license_url: "https://openfontlicense.org/"
  },

  {
    name: "Zen Maru Gothic",
    style: "丸ゴシック体",
    genre: "かわいい",
    font_url: "https://fonts.googleapis.com/css2?family=Zen+Maru+Gothic&display=swap",
    download_url: "https://fonts.google.com/specimen/Zen+Maru+Gothic",
    commercial_use: true,
    license_type: "SIL Open Font License",
    license_url: "https://openfontlicense.org/"
  },

  {
    name: "Yuji Boku",
    style: "筆書体",
    genre: "かっこいい",
    font_url: "https://fonts.googleapis.com/css2?family=Yuji+Boku&display=swap",
    download_url: "https://fonts.google.com/specimen/Yuji+Boku",
    commercial_use: true,
    license_type: "SIL Open Font License",
    license_url: "https://openfontlicense.org/"
  },

  {
    name: "Yuji Mai",
    style: "筆書体",
    genre: "かっこいい",
    font_url: "https://fonts.googleapis.com/css2?family=Yuji+Mai&display=swap",
    download_url: "https://fonts.google.com/specimen/Yuji+Mai",
    commercial_use: true,
    license_type: "SIL Open Font License",
    license_url: "https://openfontlicense.org/"
  },

  {
    name: "Yuji Syuku",
    style: "筆書体",
    genre: "かっこいい",
    font_url: "https://fonts.googleapis.com/css2?family=Yuji+Syuku&display=swap",
    download_url: "https://fonts.google.com/specimen/Yuji+Syuku",
    commercial_use: true,
    license_type: "SIL Open Font License",
    license_url: "https://openfontlicense.org/"
  },

  {
    name: "Kaisei Decol",
    style: "デザインフォント",
    genre: "かわいい",
    font_url: "https://fonts.googleapis.com/css2?family=Kaisei+Decol&display=swap",
    download_url: "https://fonts.google.com/specimen/Kaisei+Decol",
    commercial_use: true,
    license_type: "SIL Open Font License",
    license_url: "https://openfontlicense.org/"
  },

  {
    name: "Mochiy Pop One",
    style: "デザインフォント",
    genre: "かわいい",
    font_url: "https://fonts.googleapis.com/css2?family=Mochiy+Pop+One&display=swap",
    download_url: "https://fonts.google.com/specimen/Mochiy+Pop+One",
    commercial_use: true,
    license_type: "SIL Open Font License",
    license_url: "https://openfontlicense.org/"
  }

]

  # 冪等性を担保したデータ投入
  created_count = 0
  existing_count = 0

  fonts_data.each do |font_data|
    font = Font.find_or_initialize_by(name: font_data[:name])

    if font.persisted?
      existing_count += 1
    else
      font.assign_attributes(font_data.except(:name))
      if font.save
        created_count += 1
      else
        puts "エラー: #{font_data[:name]} - #{font.errors.full_messages.join(', ')}"
      end
    end
  end

  puts "=== Seed実行完了 ==="
  puts "新規作成: #{created_count}件"
  puts "最終Font数: #{Font.count}"

rescue => e
  puts "=== Seedエラー発生 ==="
  puts "エラー: #{e.message}"
  puts "バックトレース: #{e.backtrace.first(5)}"
  raise e
end