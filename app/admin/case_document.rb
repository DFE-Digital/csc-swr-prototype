ActiveAdmin.register CaseDocument do
  menu parent: "Cases", priority: 1

  form title: "Document upload" do |f|
    f.inputs "document" do
      f.input :case
      f.input :title
      f.input :document, as: :file
      f.label "convert to: "
      f.select :document_type, %w[png jpg tiff]
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit!
    end

    def create
      case_document = CaseDocument.new(permitted_params[:case_document])
      case_document.document.attach(permitted_params[:case_document][:document])
      case_document.save!
      # Assuming an image is uploaded, not any other file type
      TranscodeImageJob.perform_later(case_document, case_document.document_type)
    end
  end

  show title: "Case Document" do
    attributes_table do
      default_attribute_table_rows.each do |field|
        row field
      end
      row :document do |ad|
        if ad.document.attachment.content_type.include?("image")
          image_tag ad.document
        else
          ad.document # need to check for other file types too
        end
      end
      row :document_type do |ad|
        h3 "content type: #{ad.document.content_type}"
      end
    end
  end
end
