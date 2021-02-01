require "zlib"

class FileCompressor < ApplicationRecord
  has_one_attached :file

  def compress_file
    raise 'You need to attach a file first' if file.attachment == nil
    compressed_file = Zlib::Deflate.deflate(file.attachment.download, Zlib::BEST_COMPRESSION)
    file.attach(
      io: StringIO.new(compressed_file),
      filename: file.filename.to_s,
      content_type: file.content_type,
    )
  end
end
