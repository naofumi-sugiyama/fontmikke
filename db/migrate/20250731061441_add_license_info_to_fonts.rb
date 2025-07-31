class AddLicenseInfoToFonts < ActiveRecord::Migration[7.1]
  def change
    add_column :fonts, :commercial_use, :boolean, default: true, null: false
    add_column :fonts, :license_type, :string, null: false, default: 'SIL Open Font License'
    add_column :fonts, :license_url, :string
  end
end
