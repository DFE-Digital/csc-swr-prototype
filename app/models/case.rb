class Case < ApplicationRecord
  belongs_to :child
  has_many :documents
  has_many :forms
  has_many :notes
end
