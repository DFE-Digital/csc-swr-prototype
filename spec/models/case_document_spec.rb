require "rails_helper"

RSpec.describe CaseDocument, type: :model do
  it "can make a new instance of Case Document" do
    @case_document = CaseDocument.new(
      title: "Example Case",
      case_id: Case.first.id,
      document_type: "png",
    )
    expect(@case_document).to be_a CaseDocument
  end

  it "will not be valid if it is not assigned to a case" do
    @case_document = CaseDocument.new(
      title: "Example case",
      document_type: "png",
    )
    expect(@case_document).to_not be_valid
  end

  it "has the ability to upload a file" do
    @case_document = CaseDocument.new(
      title: "Example case",
      case_id: Case.first.id,
      document_type: "png",
    )
    @case_document.document.attach(
      io: File.open(Rails.root.join("spec/fixtures/linux.jpg")),
      filename: "linux.jpg",
      content_type: "png",
    )
    expect(@case_document.document).to be_attached
  end
end
