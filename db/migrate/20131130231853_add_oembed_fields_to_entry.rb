class AddOembedFieldsToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :html, :text
    add_column :entries, :author_url, :string
    add_column :entries, :thumb_width, :integer
    add_column :entries, :thumb_height, :integer
    add_column :entries, :author_name, :string
    add_column :entries, :oembed_type, :string
  end
end
