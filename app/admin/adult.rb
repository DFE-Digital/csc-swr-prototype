ActiveAdmin.register Adult do
  menu parent: "Social Worker", priority: 1

  controller do
    def permitted_params
      params.permit!
    end
  end
end
