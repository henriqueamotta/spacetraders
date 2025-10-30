require "test_helper"

class UserTest < ActiveSupport::TestCase

  # 1. Testa a associação 'has_many :products'
  test "should have many products" do
    user = User.new
    # Testa se o método 'products' existe no usuário
    assert_respond_to user, :products
  end

  # 2. Testa a validação de presença do e-mail (do Devise)
  test "should not save user without email" do
    user = User.new(password: "123456", password_confirmation: "123456")
    assert_not user.valid?, "User was valid without an email"
    assert user.errors[:email].any?, "No validation error for email"
  end

  # 3. Testa a validação de presença da senha (do Devise)
  test "should not save user without password" do
    user = User.new(email: "test@example.com")
    assert_not user.valid?, "User was valid without a password"
    assert user.errors[:password].any?, "No validation error for password"
  end

  # 4. Testa a validação de unicidade do e-mail (do Devise)
  test "should not save user with duplicate email" do
    # O usuário 'one' já existe, vindo dos fixtures (users.yml)
    existing_user_email = users(:one).email

    # Tentativa de criar um novo usuário com o mesmo e-mail
    duplicate_user = User.new(
      email: existing_user_email,
      password: "password",
      password_confirmation: "password"
    )

    assert_not duplicate_user.valid?, "User was valid with a duplicate email"
    assert duplicate_user.errors[:email].any?, "No uniqueness validation error for email"
  end
end
