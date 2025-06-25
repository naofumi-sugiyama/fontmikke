class CreateFonts < ActiveRecord::Migration[7.1]
  def change
    create_table :fonts do |t|
      t.string :name, null: false
      t.string :style, null: false
      t.string :genre, null: false
      t.string :font_url
      t.string :download_url

      t.timestamps
    end
  end
end
