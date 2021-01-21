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
end
