class Child < ApplicationRecord
  has_many :adults_children
  has_many :adults, through: :adults_children
  has_many :children_cases
  has_many :cases, through: :children_cases
  has_many :child_notes
end
