class GdriveController < ApplicationController
  protect_from_forgery

  def index
    @files = Services::GoogleDriverLoader.files
  end

  def show
    @case_note = CaseNote.find(params[:id])
  end

  def form
    @content = Services::GoogleDriverLoader.content(params[:filename])
    @case_note = CaseNote.new
  end

  def save
    @case_note = CaseNote.new(
      title: params[:body][0..25],
      body: params[:body],
      case: Case.first)
    @case_note.save!

    redirect_to root_path
  end

  def update
    @case_note = CaseNote.find(params[:id])
    @case_note.update(body: params[:body], title: params[:body][0..25])

    redirect_to root_path
  end
end
