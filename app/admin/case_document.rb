ActiveAdmin.register CaseDocument do
  menu parent: "Cases", priority: 1

  form title: "Document upload" do |f|
    f.inputs "document" do
      f.input :case
      f.input :title
      f.input :document_type
      f.input :document, as: :file
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end

  show title: "Case Document" do
    default_main_content
    attributes_table do
      row :document do |ad|
        if ad.document.attachment.content_type == "image/jpeg"
          image_tag ad.document
        else
          ad.document # need to check for other file types too
        end
      end
    end
  end
end
