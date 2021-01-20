class CreateChildrenCases < ActiveRecord::Migration[6.1]
  def change
    create_table :children_cases do |t|
      t.references :child, null: false, foreign_key: true
      t.references :case, null: false, foreign_key: true

      t.timestamps
    end
  end
end
