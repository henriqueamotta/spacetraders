class User < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false } # Garante que o username é único, sem diferenciar maiúsculas de minúsculas

  def full_name
    "#{first_name} #{last_name}"
  end

end
