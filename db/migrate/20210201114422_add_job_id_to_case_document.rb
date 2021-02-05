class AddJobIdToCaseDocument < ActiveRecord::Migration[6.1]
  def change
    add_column :case_documents, :job_id, :string
  end
end
