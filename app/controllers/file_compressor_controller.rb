class FileCompressorsController < ApplicationController
  def new; end

  def create
    @file_compressor = FileCompressor.new
    @file_compressor.file.attach(params[:file])
    @file_compressor.compress_file
  end

  def permit_params
    params.permit(:file)
  end
end
