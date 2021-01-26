class CaseDocumentsController < ApplicationController
  def new; end

  def create
    @case_document = CaseDocument.new(
      title: params[:document].original_filename,
      case_id: Case.first.id,
      document_type: "png",
    )
    @case_document.document.attach(params[:document])

    @case_document.save!
    # Assuming an image is uploaded, not any other file type
    TranscodeImageJob.perform_later(@case_document)

    # redirect has not been built yet by the UX team.
  end

  def permit_params
    params.permit(:title, :document)
  end
end
