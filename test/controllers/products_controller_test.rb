require "test_helper"

# Utilizando IntegrationTest, que simula requisições HTTP
class ProductsControllerTest < ActionDispatch::IntegrationTest

  # Inclui os helpers de teste do Devise (para sign_in)
  include Devise::Test::IntegrationHelpers

  setup do
    # O usuário do fixture é carregado
    @user = users(:one)
    # É feito o login para esta sessão de teste
    sign_in @user
  end

  # Teste 1: Ação 'index' (Listagem)
  test "should get index" do
    # Simula uma requisição GET para /products
    get products_url

    # 1. Verifica se a resposta foi HTTP 200 (OK)
    assert_response :success

    # 2. Verifica se o controller definiu a variável @products
    assert_not_nil assigns(:products)
  end

  # Teste 2: Ação 'show' (Detalhes)
  test "should get show" do
    # É preciso de um produto que exista (do fixture)
    @product = products(:one)

    # Simula GET para /products/ID_DO_PRODUTO
    get product_url(@product)

    assert_response :success
    assert_not_nil assigns(:product)
  end

  # Teste 3: Ação 'create'
  test "should create product" do
    # 1. Definindo os parâmetros que o formulário enviará
    # É usado os dados do fixture 'image.png'
    @file = fixture_file_upload(Rails.root.join('test/fixtures/files/image.png'), 'image/png')

    product_params = {
      product: {
        name: "Millennium Falcon",
        model: "YT-1300",
        manufacturer: "Corellian Engineering",
        price: 100000,
        overview: "The fastest hunk of junk.",
        category: "Spaceships",
        photos: [@file]
      }
    }

    # 2. É verificado a mudança no banco
    # "Afirmando que a contagem de 'Product' vai mudar em +1"
    assert_difference "Product.count", 1 do
      # Simula uma requisição POST para /products com os parâmetros
      post products_url, params: product_params
    end

    # 3. O resultado é verificado

    # Verifica se houve redirecionamento para a página de 'show' do novo produto
    assert_redirected_to product_url(Product.last)

    # Verifica se a mensagem de sucesso foi definida
    assert_equal "Product was successfully added!", flash[:notice]
  end

  # Teste 4: Ação 'update'
  test "should update product" do
    @product = products(:one)
    @file = fixture_file_upload(Rails.root.join('test/fixtures/files/image.png'), 'image/png')

    patch_params = {
      product: {
        name: "X-Wing Elite",
        price: 999999,
        model: @product.model,
        manufacturer: @product.manufacturer,
        overview: @product.overview,
        photos: [@file],
        category: "Spaceships"
      }
    }

    patch product_url(@product), params: patch_params
    @product.reload

    assert_redirected_to product_url(@product)
    assert_equal "Product was successfully updated!", flash[:notice]
    assert_equal "X-Wing Elite", @product.name
  end

  # Teste 5: Ação 'destroy' (Deleção)
  test "should destroy product" do
    # 1. Seleciona um produto existente dos fixtures
    @product = products(:one) # O "X-Wing"

    # 2. Verificação da mudança no banco de dados
    # "Afirmando que a contagem de 'Product' vai mudar em -1"
    assert_difference "Product.count", -1 do
      # Simula uma requisição DELETE para /products/ID_DO_PRODUTO
      delete product_url(@product)
    end

    # 3. O resultado é verificado

    # Verifica se houve redirecionamento para a página de 'index' (listagem)
    assert_redirected_to products_url

    # Verifica se a mensagem de sucesso foi definida
    assert_equal "Product was successfully deleted!", flash[:notice]
  end

  # Teste 6: Restrições de Acesso - Tentativa de modificar produto de outro usuário
  test "should NOT update a product owned by another user" do
    # Fazendo login como user_2 (Vader)
    sign_in users(:two)
    # Seleciona o produto do user_1 (Skyboy)
    @product_of_user_one = products(:one)

    patch_params = { product: { name: "Hacked Name" } }
    patch product_url(@product_of_user_one), params: patch_params

    # O ApplicationController deve ter redirecionado
    assert_redirected_to root_path

    # O ApplicationController deve ter definido o alerta
    assert_equal "You are not authorized to perform this action.", flash[:alert]

    # Garantindo que o nome do produto NÃO mudou na base de dados
    assert_not_equal "Hacked Name", @product_of_user_one.reload.name
  end

  # Teste 7: Restrições de Acesso - Tentativa de deletar produto de outro usuário
  test "should NOT destroy a product owned by another user" do
    sign_in users(:two) # Login como "Vader"
    @product_of_user_one = products(:one) # Seleciona o produto do "Skyboy"

    # Verificando que o 'delete' NÃO muda a contagem
    assert_no_difference "Product.count" do
      delete product_url(@product_of_user_one)
    end

    assert_redirected_to root_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

end
