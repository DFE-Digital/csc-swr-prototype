class VideoController < ApplicationController
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
      document_type: "video",
    )
    @case_document.document.attach(params[:document])
    @case_document.save!

    redirect_to root_path
  end
end
