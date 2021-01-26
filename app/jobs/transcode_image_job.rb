require "mini_magick"

class TranscodeImageJob < ApplicationJob
  queue_as :default

  def perform(case_document)
    img = MiniMagick::Image.read(case_document.document.download)
    img = img.format(case_document.document_type)
    case_document.document.attach(
      io: File.open(img.path),
      filename: case_document.title,
      content_type: case_document.document_type,
    )
  end
end
