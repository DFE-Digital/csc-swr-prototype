class User < ApplicationRecord
  has_many :users_cases
  has_many :cases, through: :users_cases
end
