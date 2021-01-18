require 'rails_helper'

RSpec.describe Case, type: :model do
  it 'it can instantiate itself' do
    @case = Case.new(name: 'Example case')
    expect(@case).to be_a Case
  end

  it 'attaches the uploaded file' do
    @case = Case.new(name: 'Example case')
    @case.image.attach(
      io: File.open(Rails.root.join('spec', 'fixtures', 'example.png')),
      filename: 'example.png',
      content_type: 'png'
    )
    expect(@case.image).to be_attached
  end
end
