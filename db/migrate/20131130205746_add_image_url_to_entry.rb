class AddImageUrlToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :image_url, :string
  end
end
