require "mini_magick"

class TranscodeImageJob < ApplicationJob
  queue_as :default

  def perform(case_document, format_type)
    img = MiniMagick::Image.read(case_document.document.download)
    img = img.format(format_type)
    case_document.document.attach(
      io: File.open(img.path),
      filename: case_document.title,
      content_type: format_type,
    )
  end
end

