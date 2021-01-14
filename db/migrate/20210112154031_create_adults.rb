class CreateAdults < ActiveRecord::Migration[6.1]
  def change
    create_table :adults do |t|
      t.references :child
      t.timestamps
    end
  end
end
