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
    # 1. Verifica no BANCO se já existe algo gravado (Caso de Edição)
    if persisted? && ActiveStorage::Attachment.where(record: self, name: 'photos').exists?
      return # Tudo certo, já tem foto no banco.
    end

    # 2. Verifica na MEMÓRIA se tem uploads novos válidos (Caso de Criação ou Adição)
    # O 'any?' verifica especificamente se há anexos novos pendentes de salvamento
    if photos.any? { |photo| photo.new_record? }
      return # Tudo certo, tem foto nova chegando.
    end

    # Se chegou aqui, não tem no banco E não tem upload novo. Erro.
    errors.add(:photos, "must have at least one image uploaded to publish.")
  end
end
