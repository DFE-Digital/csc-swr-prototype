class CreateChildren < ActiveRecord::Migration[6.1]
  def change
    create_table :children do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.text :address, null: false
      t.date :dob
      t.timestamps
    end
  end
end 
