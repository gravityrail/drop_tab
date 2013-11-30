class AddZencoderFieldsToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :zencoder_output_id, :integer
    add_column :entries, :zencoder_processed, :boolean, default: false
    add_column :entries, :thumbnail_url, :string
    add_column :entries, :width, :integer
    add_column :entries, :height, :integer
    add_column :entries, :duration, :integer
    add_column :entries, :original_file_name, :string
  end
end
