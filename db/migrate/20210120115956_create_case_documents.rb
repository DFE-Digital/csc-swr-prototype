class CreateCaseDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :case_documents do |t|
      t.string :title, null: false
      t.string :document_type, null: false
      t.references :case

      t.timestamps
    end
  end
end
