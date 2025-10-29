require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include ActiveRecord::TestFixtures

  fixtures :all

  include Devise::Test::IntegrationHelpers

  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400] do |options|
    options.add_argument("--disable-dev-shm-usage")
  end

  Capybara.save_path = Rails.root.join("tmp/screenshots")
  setup do
    Capybara.server = :puma, { Silent: true }
  end
end
