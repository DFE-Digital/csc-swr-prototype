class CreateCaseNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :case_notes do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.references :case

      t.timestamps
    end
  end
end 
