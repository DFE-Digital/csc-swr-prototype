class ChildNote < ApplicationRecord
  belongs_to :child
  belongs_to :author, class_name: "User"
end
 
