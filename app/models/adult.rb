class Adult < ApplicationRecord
  has_many :adults_children
  has_many :children, through: :adults_children
end
