class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :planet, :address, presence: true
end
