class CreateChildNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :child_notes do |t|
      t.references :child, null: false, foreign_key: true
      t.text :content
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
 
