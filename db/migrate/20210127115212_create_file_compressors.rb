class CreateFileCompressors < ActiveRecord::Migration[6.1]
  def change
    create_table :file_compressors do |t|
      t.timestamps
    end
  end
end
