ActiveAdmin.register Case do
  menu parent: "Cases", priority: 1

  controller do
    def permitted_params
      params.permit!
    end
  end
end
