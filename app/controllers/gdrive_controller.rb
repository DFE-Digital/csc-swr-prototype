class GdriveController < ApplicationController
  protect_from_forgery

  def show
    @files = Services::GoogleDriverLoader.files
  end

  def form
    @content = Services::GoogleDriverLoader.content(params[:filename])
  end
end
