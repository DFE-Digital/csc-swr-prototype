require "rails_helper"

RSpec.describe FileCompressor do
  it "can make an instance of itself" do
    @file_compressor = FileCompressor.new
    expect(@file_compressor).to be_a FileCompressor
  end

  it "attach a file to itself" do
    @file_compressor = FileCompressor.new
    @file_compressor.file.attach(
      io: File.open(Rails.root.join("spec/fixtures/linux.jpg")),
      filename: "linux.jpg",
      content_type: "image/jpeg",
    )
    expect(@file_compressor.file).to be_attached
  end

  it "can compress a file" do
    @file_compressor = FileCompressor.first_or_create!
    @file_compressor.file.attach(
      io: File.open(Rails.root.join("spec/fixtures/linux.jpg")),
      filename: "linux.jpg",
      content_type: "image/jpeg",
    )
    previous_size_in_bytes = @file_compressor.file.attachment.byte_size
    @file_compressor.save!
    @file_compressor.compress_file
    expect(@file_compressor.file.attachment.byte_size).to be < previous_size_in_bytes
  end

  it "can compress a file using GzipWriter" do
    @file_compressor = FileCompressor.first_or_create!
    zipped_file = "#{Rails.root.join('spec/fixtures/linux.jpg')}.gz"

    compressed_file = Zlib::GzipWriter.open(zipped_file) do |gz|
      gz.write IO.binread(Rails.root.join("spec/fixtures/linux.jpg"))
      gz.close
    end
    previous_size_in_bytes = File.open(Rails.root.join("spec/fixtures/linux.jpg")).size
    @file_compressor.file.attach(
      io: File.open(compressed_file.path),
      filename: zipped_file,
      content_type: "gz",
    )
    expect(@file_compressor.file.attachment.byte_size).to be < previous_size_in_bytes
  end
end
