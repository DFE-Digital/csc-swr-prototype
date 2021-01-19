require 'mini_magick'

class ConvertImageExtensionJob < ApplicationJob
  queue_as :default

  def perform(caseImage)
    convertedImage = MiniMagick::Image.read(caseImage.image.download)
      .resize('100x100')
      .format('png')
    caseImage.image.attach(
      io: File.open(convertedImage.path),
      filename: caseImage.image.record.name,
      content_type: 'png'
    )
  end
end
