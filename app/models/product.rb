class Product < ApplicationRecord
  belongs_to :user
  has_many_attached :photos

  validates :name, :model, :price, :manufacturer, :overview, presence: true
  validates :photos, presence: true
  validates :price, numericality: { greater_than: 0 }
end
