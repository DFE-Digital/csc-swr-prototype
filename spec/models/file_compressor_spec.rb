require "rails_helper"

RSpec.describe FileCompressor do
  let(:original_file) { File.open("spec/fixtures/linux.jpg") }
  let(:subject) { FileCompressor.new }

  context('instantiation') do
    it { is_expected.to be_valid }
    it { is_expected.to be_a FileCompressor }
  end

  context('attachments') do
    it "has an attached file" do
      subject.file.attach(
        io: original_file,
        filename: File.basename(original_file.path),
        content_type: File.extname(original_file.path)
      )
      expect(subject.file).to be_attached
    end

    it "doesnt have an attached file by default" do
      expect(subject.file).to_not be_attached
    end
  end

  context('compressing files') do
    it "can compress a file" do
      subject.file.attach(
        io: File.open("spec/fixtures/linux.jpg"),
        filename: "linux.jpg",
        content_type: "image/jpeg",
      )
      subject.save!
      subject.compress_file
      expect(subject.file.attachment.byte_size).to be < original_file.size
    end
  
    it "can compress a file using GzipWriter" do
      zipped_file = "#{'spec/fixtures/linux.jpg'}.gz"
      compressed_file = Zlib::GzipWriter.open(zipped_file) do |gz|
        gz.write IO.binread("spec/fixtures/linux.jpg")
        gz.close
      end
      
      subject.file.attach(
        io: File.open(compressed_file.path),
        filename: zipped_file,
        content_type: "gz",
      )
      
      expect(subject.file.attachment.byte_size).to be < original_file.size
    end

    it 'will throw an error if compress is called when no file exists' do
      expect { subject.compress_file }.to raise_error('You need to attach a file first')
    end
  end
end
