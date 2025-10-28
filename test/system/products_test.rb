require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase

  setup do
    @user = users(:one)
    sign_in @user
  end

  test "creating a new product" do
    # 1. Navegar para a página
    visit new_product_path

    # ... (resto do seu teste) ...

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
end
