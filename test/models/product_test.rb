require "test_helper"

class ProductTest < ActiveSupport::TestCase

  # Testa a associação 'belongs_to :user'
  test "should belong to a user" do
    product = Product.new
    # Testa se o método 'user' existe no produto
    assert_respond_to product, :user
  end

  # Testa as validações de presença
  test "should not save product without required fields" do
    product = Product.new

    assert_not product.valid?, "Product was valid without required fields"

    assert product.errors[:name].any?, "No validation error for name"
    assert product.errors[:model].any?, "No validation error for model"
    assert product.errors[:manufacturer].any?, "No validation error for manufacturer"
    assert product.errors[:price].any?, "No validation error for price"
    assert product.errors[:overview].any?, "No validation error for overview"
    assert product.errors[:category].any?, "No validation error for category"
    assert product.errors[:photos].any?, "No validation error for photos"
  end

  # Testa se um produto válido é salvo
  test "should save valid product" do
    # Cria um usuário de teste
    user = users(:one)

    # Cria um produto com todos os campos obrigatórios preenchidos
    product = Product.new(
      user: user,
      name: "Test Ship",
      model: "T-1",
      manufacturer: "Test Corp",
      price: 100,
      overview: "A test ship.",
      category: "Spaceships"
    )

    # Anexa uma foto de teste
    product.photos.attach(
      io: File.open(Rails.root.join('test/fixtures/files/image.png')),
      filename: 'image.png',
      content_type: 'image/png'
    )

    # Verifica se o produto é válido
    assert product.valid?, "Product was invalid with all fields: #{product.errors.full_messages.join(', ')}"
  end

end
