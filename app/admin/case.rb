ActiveAdmin.register Case do
  menu parent: "Cases", priority: 1

  form do |f|
    f.inputs "Case" do
      f.input :name
      f.input :overview
      f.input :team_leader
      f.input :children
      f.input :case_notes
      f.input :case_documents
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end

  show title: "Case" do
    attributes_table do
      default_attribute_table_rows.each do |field|
        row field
      end
      row :documents do |ad|
        ad.case_documents.each_with_index do |case_document, index|
          link_to :case_document
        end
      end
    end
  end
end
