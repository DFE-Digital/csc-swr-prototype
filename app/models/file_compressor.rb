require "zlib"

class FileCompressor < ApplicationRecord
  has_one_attached :file

  def compress_file
    original_file = file
    compressed_file = Zlib::Deflate.deflate(original_file.attachment.download, Zlib::BEST_COMPRESSION)
    file.attach(
      io: StringIO.new(compressed_file),
      filename: original_file.filename.to_s,
      content_type: original_file.content_type,
    )
  end
end
