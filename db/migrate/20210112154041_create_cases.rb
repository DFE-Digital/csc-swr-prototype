class CreateCases < ActiveRecord::Migration[6.1]
  def change
    create_table :cases do |t|
      t.references :child
      t.references :user
      t.timestamps
    end
  end
end
