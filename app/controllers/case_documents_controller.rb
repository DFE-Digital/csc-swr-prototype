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
    job_id = TranscodeImageJob.perform_later(@case_document).job_id
    # redirect has not been built yet by the UX team.
    @case_document.update(job_id: job_id)
    redirect_to :new_media_show
  end

  def show
    @case_document = CaseDocument.last
    @status = ActiveJob::Status.get(@case_document.job_id)
  end

  def status 
    status = ActiveJob::Status.get(params[:job])
    case_document = CaseDocument.where(job_id: params[:job])[0]
    response = { status: status.status, image_type: case_document.document.attachment.content_type, case_document_url: rails_blob_path(case_document.document) }
    render json: response.to_json
  end

  def permit_params
    params.permit(:title, :document)
  end
end
