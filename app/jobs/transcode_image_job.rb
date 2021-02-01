require "mini_magick"

class TranscodeImageJob < ApplicationJob
  include ActiveJob::Status
  queue_as :default

  def perform(case_document)
    sleep(10)
    img = MiniMagick::Image.read(case_document.document.download).format(case_document.document_type)
    case_document.document.attach(
      io: File.open(img.path),
      filename: case_document.title,
      content_type: case_document.document_type,
    )
  end
end
