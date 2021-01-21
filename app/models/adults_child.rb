class AdultsChild < ApplicationRecord
  belongs_to :adult
  belongs_to :child
end
