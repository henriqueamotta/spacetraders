class Order < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :products

  validates :planet, :address, presence: true
  validates :total, numericality: { greater_than_or_equal_to: 0 }, presence: true
end
