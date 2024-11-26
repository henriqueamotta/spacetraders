class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  
  validates :status, presence: true
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
