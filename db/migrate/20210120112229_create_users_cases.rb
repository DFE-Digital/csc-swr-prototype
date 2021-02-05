class CreateUsersCases < ActiveRecord::Migration[6.1]
  def change
    create_table :users_cases do |t|
      t.references :user
      t.references :case
      t.date :assignment_date

      t.timestamps
    end 
  end
end
