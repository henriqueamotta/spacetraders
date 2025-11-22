require "test_helper"

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get my_products" do
    get dashboards_my_products_url
    assert_response :success
  end
end
