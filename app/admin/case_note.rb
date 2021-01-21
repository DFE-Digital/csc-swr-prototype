ActiveAdmin.register CaseNote do
  menu parent: "Cases", priority: 2

  form do |f|
    f.inputs "Case Note" do
      f.input :case, input_html: { class: "select2" }
      f.input :title
      f.input :body, as: :string
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end
