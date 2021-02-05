class CreateAdultsChildren < ActiveRecord::Migration[6.1]
  def change
    create_table :adults_children do |t|
      t.references :adult, null: false, foreign_key: true
      t.references :child, null: false, foreign_key: true
      t.string :relationship_type

      t.timestamps
    end
  end
end
 
