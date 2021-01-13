ActiveAdmin.register Child do
  index do
    selectable_column
    id_column
    column :name
    column :address
    column :dob
    actions
  end

  form do |f|
    f.inputs "Child" do
      f.input :name
      f.input :address
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
