class User < ApplicationRecord
  #devise :database_authenticatable,
  #       :recoverable, :rememberable, :validatable

  has_many :users_cases
  has_many :cases, through: :users_cases
end
