class CaseDocument < ApplicationRecord
  belongs_to :case
  has_one_attached :document
end
