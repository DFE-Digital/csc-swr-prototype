ActiveAdmin.register Child do
  menu parent: "Social Worker", priority: 2

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :address
    column :dob
    actions
  end

  form do |f|
    f.inputs "Child" do
      f.input :first_name
      f.input :last_name
      f.input :address, as: :string
      f.input :dob, as: :string, input_html: { class: "datepicker hasDatePicker" }
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end
