/** @type {import('tailwindcss').Config} */
module.exports = {
    content: [
      "./app/views/**/*.html.erb",       // .html.erb
      "./app/helpers/**/*.rb",           // ヘルパー
      "./app/javascript/**/*.js",        // JSファイル全般
    ],
    theme: {
      extend: {},
    },
    plugins: [],
  }