class Product < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
  has_and_belongs_to_many :orders

  CATEGORIES = ["Droids", "Vehicles", "Spaceships"]

  validates :name, :model, :price, :manufacturer, :overview, :category, presence: true
  validate :must_have_at_least_one_photo
  validates :price, numericality: { greater_than: 0 }
  validates :category, inclusion: { in: CATEGORIES }

  private

  def must_have_at_least_one_photo
    # O método 'attached?' verifica se há arquivos já salvos OU
    # se há novos arquivos aguardando para serem salvos nesta requisição.
    unless photos.attached?
      errors.add(:photos, "must have at least one image uploaded to publish.")
    end
  end
end
