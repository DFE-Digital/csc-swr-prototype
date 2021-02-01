require "rails_helper"

RSpec.describe CaseDocument, type: :model do
  let(:subject) { CaseDocument.new(
    title: "Example Case",
    case_id: Case.first.id,
    document_type: "png",
  ) }

  context('valid instantiation') do
    it { is_expected.to be_a CaseDocument }
    it { is_expected.to be_valid }
  end

  context('invalid instantiation') do
    it "will not be valid if it is not assigned to a case" do
      @case_document = CaseDocument.new(
        title: "Example case",
        document_type: "png",
      )
      expect(@case_document).to_not be_valid
    end
  end

  context('file attachments') do
    it "has the ability to upload a file" do
      subject.document.attach(
        io: File.open(Rails.root.join("spec/fixtures/linux.jpg")),
        filename: "linux.jpg",
        content_type: "png",
      )
      expect(subject.document).to be_attached
    end
  end
end
