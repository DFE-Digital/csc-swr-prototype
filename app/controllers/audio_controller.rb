class AudioController < ApplicationController
  protect_from_forgery

  def new
  end

  def show
    @case_document = CaseDocument.find(params[:id])
  end

  def upload
    if params[:document].nil?
      render :new
      return
    end

    @case_document = CaseDocument.new(
      title: params[:document].original_filename,
      case_id: Case.first.id,
      document_type: "audio",
    )
    @case_document.document.attach(params[:document])
    @case_document.save!

    object = TranscodeAudioJob.perform_later(@case_document)
    status = ActiveJob::Status.get(object)
    @case_document.update(job_id: object.job_id)

    redirect_to root_path
  end

  def update
    @case_document = CaseDocument.find(params[:id])
    @case_document.update(transcoded_text: params[:body])

    redirect_to root_path
  end

  def status
    status = ActiveJob::Status.get(params[:job])
    render json: status.to_json
  end

  def permit_params
    params.permit(:title, :document)
  end
end
