require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase

  setup do
    @user = users(:one)
    sign_in @user
  end

  # Teste para visitar a página de listagem de produtos (index)
  test "visiting the index (product list)" do
    # O setup já nos logou com @user = users(:one)
    # Os fixtures já carregaram os produtos 'one' (X-Wing) e 'two' (TIE Fighter)

    # ACTION
    # 1. Visitar a página de listagem de produtos
    visit products_path

    assert_text "Shop"

    # 2. Verificar se os produtos dos fixtures estão sendo exibidos (Buscando pelos seus nomes)
    assert_text "X-Wing"
    assert_text "TIE Fighter"

    # 3. (Opcional) Verificar se os preços formatados aparecem
    assert_text "150,000.00" # Preço do X-Wing
    assert_text "90,000.00"  # Preço do TIE Fighter
  end

  # Teste para criar um novo produto
  test "creating a new product" do
    # 1. Navegar para a página
    visit new_product_path

    # ... (resto do teste) ...

    fill_in "Name", with: "Millennium Falcon"
    fill_in "Model", with: "YT-1300 light freighter"
    fill_in "Manufacturer", with: "Corellian Engineering Corporation"
    fill_in "Price", with: 100000
    fill_in "Overview", with: "The fastest hunk of junk in the galaxy."
    select "Spaceship", from: "Category"

    attach_file "product_photos", Rails.root.join("test/fixtures/files/image.png")

    click_on "Submit"
    assert_text "Product was successfully added!"
    assert_text "Millennium Falcon"
    assert_text "Corellian Engineering Corporation"
  end

  # Teste para atualizar um produto
  test "updating a product" do
    @product = products(:one)

    # ACTION
    # 1. Visitar a página de edição do produto
    visit edit_product_path(@product)

    # 2. Mudar alguns dados no formulário
    fill_in "Name", with: "Updated Product Name"
    fill_in "Price", with: 9999

    attach_file "product_photos", Rails.root.join("test/fixtures/files/image.png")

    # 3. Clicar no botão "Submit"
    click_on "Submit"

    # ASSERT
    # 1. Verificar a mensagem flash de sucesso
    assert_text "Product was successfully updated"

    # 2. Verificar se os dados novos estão na página (show)
    assert_text "Updated Product Name"
    assert_text "9,999.00"
  end

  # Teste para deletar um produto
  test "deleting a product" do
    # O setup já logou o @user.
    # O produto 'one' é selecionado dos fixtures.
    @product = products(:one)

    # Navegação para a página de 'show' do produto
    visit product_path(@product)

    # ACTION
    # 1. O Capybara é instruído para aceitar o próximo pop-up de confirmação
    accept_alert do
      # 2. O link/botão "Delete Product" é clicado.
      click_on "Delete Product"
    end

    # ASSERT
    # 1. O teste deve ser redirecionado e mostrar a mensagem de sucesso.
    assert_text "Product was successfully deleted!"

    # 2. O nome do produto não deve mais estar na página
    # Isso prova que ele foi removido da listagem.
    assert_no_text "X-Wing" # (O nome do produto 'one' no fixture)
  end
end
