class CreateCases < ActiveRecord::Migration[6.1]
  def change
    create_table :cases do |t|
      t.string :name, null: false
      t.text :overview
      t.integer :team_leader
      t.references :referral

      t.timestamps
    end 
  end
end
