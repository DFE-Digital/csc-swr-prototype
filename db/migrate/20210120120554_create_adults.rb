class CreateAdults < ActiveRecord::Migration[6.1]
  def change
    create_table :adults do |t|
      t.string :first_name
      t.string :last_name
      t.text :address

      t.timestamps
    end
  end
end
 
