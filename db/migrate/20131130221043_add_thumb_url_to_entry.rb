class AddThumbUrlToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :thumb_url, :string
  end
end
