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

  show title: 'Case' do 
    default_main_content
    attributes_table do 
      row :documents do |ad|
        ad.case_documents.each do |case_document|
          link_to case_document
        end
      end
    end
    # attributes_table do 
    #   row :chidlren do |ad|
    #     ad.children.each do |children|
    #       link_to children
    #     end
    #   end
    # end
  end
end
