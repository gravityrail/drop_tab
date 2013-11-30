class ConvertUrlToOriginalUrl < ActiveRecord::Migration
  def change
    rename_column :entries, :url, :original_url
    add_column :entries, :processed_url, :string
  end
end
