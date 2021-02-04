class Case < ApplicationRecord
  has_many :users_cases
  has_many :users, through: :users_cases
  has_many :children_cases
  has_many :children, through: :children_cases
  has_many :case_notes
  has_many :case_documents
end
 
